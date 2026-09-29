import os
import shutil
from backend.app.schemas.query import ParsedQuery
from backend.app.services.llm_provider import LLMProvider

def test_caching():
    cache_dir = "data/cache/llm"
    if os.path.exists(cache_dir):
        shutil.rmtree(cache_dir)
        
    provider = LLMProvider(backend="rules")
    
    # Call 1 - should write to cache
    res1 = provider.complete("hello world", ParsedQuery)
    
    # Assert cache file exists
    files = os.listdir(cache_dir)
    assert len(files) == 1
    
    # Call 2 - should read from cache (even if we temporarily break the rules parser)
    original_parse = provider.rules.parse
    def broken_parse(*args, **kwargs):
        raise Exception("This should not be called due to cache hit!")
    provider.rules.parse = broken_parse
    
    # This will succeed only if it hits the cache
    res2 = provider.complete("hello world", ParsedQuery)
    
    assert res1.model_dump() == res2.model_dump()
    print("Caching test PASSED!")

if __name__ == "__main__":
    test_caching()

