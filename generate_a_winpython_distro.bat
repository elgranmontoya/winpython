rem  to launch from a winpython package directory, where 'make.py' is
@echo on
rem  this is initialised per the calling .bat
rem  set my_original_path=%path%
rem  set my_buildenv=C:\winpython-64bit-3.4.3.7Qt5
rem  set my_root_dir_for_builds=D:\Winp

rem  set my_python_target=34
rem  set my_pyver=3.4
rem  set my_release=84

rem *****************************
rem v2 2016-03-19 change 
rem we don't use building rootdir (D:\winPython) anymore
rem we use only building basedir (D:\WinPython\basedir34Qt5)  

set my_basedir=%my_root_dir_for_builds%\bd%my_python_target%
rem set my_basedir=%my_root_dir_for_builds%\build%my_python_target%\%my_arch%

rem ***********************************************************
rem Override other scripts (simpler maintenance)

set my_buildenv=C:\winpython-64bit-3.4.3.7Qt5

rem handle alpha
if "%my_release_level%"=="" set my_release_level=b5

if %my_python_target%==27 set my_release=2

if %my_python_target%==34 set my_release=8

if %my_python_target%==35 set my_release=2

if %my_python_target%==36 set my_release=0

if %my_python_target%==37 set my_release=0

rem ***********************************************************

rem  set my_flavor=Slim

rem  set my_arch=32
rem  set my_preclear_build_directory=Yes

rem  set my_requi=C:\Winpents=d:\my_req1.txt d:\my_req2.txt d:\my_req3.txt  d:\my_req4.txt
rem  set my_find_links=D:\WinPython\packages.srcreq

rem  set my_source_dirs=D:\WinPython\bd34\packages.src D:\WinPython\bd34\packages.win32.Slim
rem  set my_toolsdirs=D:\WinPython\bd34\Tools.Slim
rem  set my_docsdirs=D:\WinPython\bd34\docs.Slim


rem  set my_install_options=--no-index --pre

set my_day=%date:/=-%
set my_time=%time:~0,5%
set my_time=%my_time::=_%

rem  was the bug 
set my_time=%my_time: =0%

set my_archive_dir=%~dp0WinPython_build_logs
if not exist %my_archive_dir% mkdir %my_archive_dir%

set my_archive_log=%my_archive_dir%\build_%my_pyver%._.%my_release%%my_flavor%_%my_release_level%_of_%my_day%_at_%my_time%.txt


echo ===============
echo preparing winpython for %my_pyver% (%my_python_target%)release %my_release%%my_flavor% (%my_release_level%) *** %my_arch% bit *** 
echo %date% %time%
echo ===============
echo ===============>>%my_archive_log%
echo preparing winpython for %my_pyver% (%my_python_target%)release %my_release%%my_flavor% (%my_release_level%) *** %my_arch% bit ***>>%my_archive_log%
echo %date% %time%>>%my_archive_log%
echo ===============>>%my_archive_log%


if not "%my_preclear_build_directory%"=="Yes" goto no_preclear

echo ------------------>>%my_archive_log%
echo 1.0 Do Pre-clear  >>%my_archive_log%
echo ------------------>>%my_archive_log%


cd /D  %my_root_dir_for_builds%\bd%my_python_target%

set build_det=\%my_flavor%
if "%my_flavor%"=="" set build_det=

dir %build_det%
echo rmdir /S /Q bu%my_flavor%
rem  pause
rmdir /S /Q bu%my_flavor%
rmdir /S /Q bu%my_flavor%
rmdir /S /Q bu%my_flavor%
rmdir /S /Q bu%my_flavor%
rmdir /S /Q bu%my_flavor%
rmdir /S /Q dist

echo %date% %time%
echo %date% %time%>>%my_archive_log%

:no_preclear


echo ------------------>>%my_archive_log%
echo 2.0 Create a build>>%my_archive_log%
echo ------------------>>%my_archive_log%


echo cd /D %~dp0>>%my_archive_log%
cd /D %~dp0

echo set path=%my_original_path%>>%my_archive_log%
set path=%my_original_path%

echo call %my_buildenv%\scripts\env.bat>>%my_archive_log%
call %my_buildenv%\scripts\env.bat

rem  build with this 
cd /D %~dp0
echo python.exe  -c "from make import *;make_all(%my_release%, '%my_release_level%', pyver='%my_pyver%', basedir=r'%my_basedir%', verbose=True, architecture=%my_arch%, flavor='%my_flavor%', requirements=r'%my_requirements%', install_options=r'%my_install_options%', find_links=r'%my_find_links%', source_dirs=r'%my_source_dirs%', toolsdirs=r'%my_toolsdirs%', docsdirs=r'%my_docsdirs%')">>%my_archive_log%
python.exe  -c "from make import *;make_all(%my_release%, '%my_release_level%', pyver='%my_pyver%', basedir=r'%my_basedir%', verbose=True, architecture=%my_arch%, flavor='%my_flavor%', requirements=r'%my_requirements%', install_options=r'%my_install_options%', find_links=r'%my_find_links%', source_dirs=r'%my_source_dirs%', toolsdirs=r'%my_toolsdirs%', docsdirs=r'%my_docsdirs%')">>%my_archive_log%

echo ===============>>%my_archive_log%
echo END OF creation>>%my_archive_log%
echo %date% %time%  >>%my_archive_log%
echo ===============>>%my_archive_log%

set path=%my_original_path%
