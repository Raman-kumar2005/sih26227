import os
import sys
import traceback

os.environ['GDAL_DATA'] = r'D:\Anaconda\miniconda3\envs\sih26227\Library\share\gdal'
os.environ['PROJ_LIB'] = r'D:\Anaconda\miniconda3\envs\sih26227\Library\share\proj'

try:
    from ml.pipelines.p6_confidence import run_confidence_pipeline
    run_confidence_pipeline()
except Exception as e:
    print("\nEXCEPTION CAUGHT:", flush=True)
    traceback.print_exc(file=sys.stdout)

