from backend.app.schemas.query import ParsedQuery
from backend.app.services.llm_provider import LLMProvider

class QueryParser:
    def __init__(self, backend="rules"):
        self.provider = LLMProvider(backend=backend)
        
    def parse(self, text: str) -> ParsedQuery:
        """Parses raw text into a ParsedQuery schema."""
        return self.provider.complete(text, ParsedQuery)

if __name__ == "__main__":
    queries = [
        "newly built structures near a river",
        "large vehicle concentrations on open ground",
        "show vegetation clearance in Bangalore Lakes since 2023",
        "water body shrinkage between 2020 and 2026",
        "find sites similar to tile bangalore_lakes/1_1",
        "show me everything",
        "asdfgh"
    ]
    
    print("--- TESTING QUERY PARSER (RULES BACKEND) ---")
    parser = QueryParser(backend="rules")
    for q in queries:
        print(f"\nQuery: '{q}'")
        try:
            res = parser.parse(q)
            print(res.model_dump_json(indent=2))
        except Exception as e:
            print(f"FAILED: {e}")
