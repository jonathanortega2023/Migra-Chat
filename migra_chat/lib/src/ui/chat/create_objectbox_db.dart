// https://ollama.com/blog/embedding-models
// https://langchaindart.dev/#/modules/retrieval/vector_stores/integrations/objectbox
import 'dart:io';

import 'package:langchain/langchain.dart';
import 'package:langchain_community/langchain_community.dart';
import 'package:langchain_ollama/langchain_ollama.dart';
import 'package:objectbox/objectbox.dart';
// import Document from langchain
import 'package:langchain_core/documents.dart';
import 'package:langchain_core/document_loaders.dart';

final promptTemplate = ChatPromptTemplate.fromTemplates(const [
  (
    ChatMessageType.system,
    '''
You are an assistant for question-answering tasks.

Use the following pieces of retrieved context to answer the user question.

Context:
{context}

If you don't know the answer, just say that you don't know. 
Use three sentences maximum and keep the answer concise.
Cite the source you used to answer the question.

Example:
"""
One sentence [1]. Another sentence [2]. 

Sources:
[1] https://example.com/1
[2] https://example.com/2
"""
'''
  ),
  (ChatMessageType.human, '{question}'),
]);

final embeddings = OllamaEmbeddings(model: 'mxbai-embed-large');
final vectorStore = ObjectBoxVectorStore(
  embeddings: embeddings,
  dimensions: 1024,
);
final chatModel =
    ChatOllama(defaultOptions: const ChatOllamaOptions(model: 'llama3:8b'));
const documentsDir = 'test_pages/';
List<Document> docs = [];
const splitter = RecursiveCharacterTextSplitter(
  chunkSize: 500,
  chunkOverlap: 0,
);
void main() async {
  for (final file in Directory(documentsDir).listSync()) {
    final document = await TextLoader(file.path).load();
    docs = [...docs, ...document];
  }

  final List<Document> chunkedDocs = await splitter.invoke(docs);
  await vectorStore.addDocuments(documents: chunkedDocs);
  final retriever = vectorStore.asRetriever();

// 7. Create a Runnable that combines the retrieved documents into a single formatted string
  final docCombiner = Runnable.mapInput<List<Document>, String>((docs) {
    return docs.map((d) => '''
Source: ${d.metadata['source']}
Title: ${d.metadata['title']}
Content: ${d.pageContent}
---
''').join('\n');
  });

// 8. Define the RAG pipeline
  final chain = Runnable.fromMap<String>({
    'context': retriever.pipe(docCombiner),
    'question': Runnable.passthrough(),
  }).pipe(promptTemplate).pipe(chatModel).pipe(const StringOutputParser());

// 9. Run the pipeline
  final stream = chain.stream(
    'Which algorithm does ObjectBox Vector Search use? Can I use it in Flutter apps?',
  );
  await stream.forEach(print);
}
