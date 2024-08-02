import 'package:langchain_community/langchain_community.dart';
import 'package:langchain_ollama/langchain_ollama.dart';
import 'package:objectbox/objectbox.dart';

final embeddings = OllamaEmbeddings(model: 'mxbai-embed-large');
final chatModel =
    ChatOllama(defaultOptions: const ChatOllamaOptions(model: 'llama3:8b'));
final vectorStore = ObjectBoxVectorStore(
  embeddings: embeddings,
  dimensions: 1024,
);
// dir containing all documents
const documentsDir =
    'model_playground/resources/Federal/Legislation/markdown_pages/';
const promptTemplate = """
Answer the question based only on the following context:

{context}

---

Answer the question based on the above context: {question}
""";
const queryText = 'What does the secretary of state do?';
final res = embeddings.embedQuery(queryText);

void main() {
  print("Hello, World!");
  late final List<double> embedded_query;
  res.then((value) => embedded_query = value);
  final query_results =
      vectorStore.similaritySearchByVectorWithScores(embedding: embedded_query);
  print(query_results);
}
