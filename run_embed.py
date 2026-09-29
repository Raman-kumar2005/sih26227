import os
import sys
import traceback

os.environ['GDAL_DATA'] = r'D:\Anaconda\miniconda3\envs\sih26227\Library\share\gdal'
os.environ['PROJ_LIB'] = r'D:\Anaconda\miniconda3\envs\sih26227\Library\share\proj'

from ml.pipelines.p3_embed import run_embedding_job

try:
    run_embedding_job()
except Exception as e:
    print("\nEXCEPTION CAUGHT:", flush=True)
    traceback.print_exc(file=sys.stdout)

