REM ---------------------------------------------------------------------------------
REM This configuration is when Anaconda is installed for all users (not recommended!)
REM ---------------------------------------------------------------------------------
SET condaPath=%USERPROFILE%\Anaconda3\
IF NOT EXIST %condaPath% SET condaPath=%USERPROFILE%\AppData\Local\Continuum\anaconda3\

REM ---------------------------------------------------------------------------------
REM Instantiate the notebook using the current directory
REM ---------------------------------------------------------------------------------
%condaPath%python.exe %condaPath%cwp.py %condaPath% %condaPath%python.exe %condaPath%Scripts\jupyter-notebook-script.py "%~dp0

pause


