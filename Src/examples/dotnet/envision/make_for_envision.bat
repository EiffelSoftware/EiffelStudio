@echo off

if not exist es_to_envision.exe call compile_es_to_envision.bat
if exist samples rd /q /s samples
mkdir samples
cd samples
copy ..\es_to_envision.exe
copy ..\eiffel_project.eifp

rem "----------------------------------------Copy Ado.NET examples----------------------------------------"
mkdir ado
cd ado
copy %EIFFEL_SRC%\examples\dotnet\ado\ado3\*.e 
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\ado\ado3\ace.ace" "$ISE_EIFFEL\examples\ado" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\ado\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\ado\ado3\ace.ace" "$ISE_EIFFEL\examples\ado" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\ado\\release\\ace.ace
copy .\\eiffel_project.eifp .\\ado\\ado.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace


rem "----------------------------------------Copy Console examples----------------------------------------"
mkdir calculator
cd calculator
copy %EIFFEL_SRC%\examples\base\calculator\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\calculator\ace.ace" "$ISE_EIFFEL\examples\calculator" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\calculator\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\calculator\ace.ace" "$ISE_EIFFEL\examples\calculator" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\calculator\\release\\ace.ace
copy .\\eiffel_project.eifp .\\calculator\\calculator.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace


rem "----------------------------------------Copy threading examples----------------------------------------"
mkdir threading
cd threading
copy ..\es_to_envision.exe
copy ..\eiffel_project.eifp

rem mkdir monitor
rem cd monitor
rem copy %EIFFEL_SRC%\examples\dotnet\threading\monitor\*.e
rem mkdir debug
rem mkdir release
rem cd ..
rem call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\monitor\ace.ace" "$ISE_EIFFEL\examples\threading\monitor" "debug"
rem copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\monitor\\debug\\ace.ace
rem call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\monitor\ace.ace" "$ISE_EIFFEL\examples\threading\monitor" "release"
rem copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\monitor\\release\\ace.ace
rem copy .\\eiffel_project.eifp .\\monitor\\monitor.eifp
rem del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir pools
cd pools
copy %EIFFEL_SRC%\examples\dotnet\threading\pools\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\pools\ace.ace" "$ISE_EIFFEL\examples\threading\pools" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\pools\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\pools\ace.ace" "$ISE_EIFFEL\examples\threading\pools" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\pools\\release\\ace.ace
copy .\\eiffel_project.eifp .\\pools\\pools.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir timers
cd timers
copy %EIFFEL_SRC%\examples\dotnet\threading\timers\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\timers\ace.ace" "$ISE_EIFFEL\examples\threading\timers" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\timers\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\timers\ace.ace" "$ISE_EIFFEL\examples\threading\timers" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\timers\\release\\ace.ace
copy .\\eiffel_project.eifp .\\timers\\timers.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

del es_to_envision.exe
del eiffel_project.eifp

cd ..


rem "----------------------------------------Copy Data examples----------------------------------------"
rem mkdir data
rem cd data
rem copy %EIFFEL_SRC%\examples\dotnet\winforms\data\grid\*.e
rem mkdir debug
rem mkdir release
rem cd ..
rem call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\data\grid\ace.ace" "$ISE_EIFFEL\examples\data" "debug"
rem copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\data\\debug\\ace.ace
rem call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\data\grid\ace.ace" "$ISE_EIFFEL\examples\data" "release"
rem copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\data\\release\\ace.ace
rem copy .\\eiffel_project.eifp .\\data\\data.eifp
rem del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace



rem "----------------------------------------Copy Winforms examples----------------------------------------"
mkdir winforms
cd winforms
copy ..\es_to_envision.exe
copy ..\eiffel_project.eifp

mkdir hello_world_window
cd hello_world_window
copy %EIFFEL_SRC%\examples\dotnet\winforms\hello_world\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world\ace.ace" "$ISE_EIFFEL\examples\winforms\hello_world_window" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\hello_world_window\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world\ace.ace" "$ISE_EIFFEL\examples\winforms\hello_world_window" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\hello_world_window\\release\\ace.ace
copy .\\eiffel_project.eifp .\\hello_world_window\\hello_world_window.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir hello_world_dialog
cd hello_world_dialog
copy %EIFFEL_SRC%\examples\dotnet\winforms\hello_world_dlg\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world_dlg\ace.ace" "$ISE_EIFFEL\examples\winforms\hello_world_dialog" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\hello_world_dialog\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world_dlg\ace.ace" "$ISE_EIFFEL\examples\winforms\hello_world_dialog" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\hello_world_dialog\\release\\ace.ace
copy .\\eiffel_project.eifp .\\hello_world_dialog\\hello_world_dialog.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir date_time_picker
cd date_time_picker
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\date_time_picker_ctl\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\date_time_picker_ctl\ace.ace" "$ISE_EIFFEL\examples\winforms\date_time_picker" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\date_time_picker\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\date_time_picker_ctl\ace.ace" "$ISE_EIFFEL\examples\winforms\date_time_picker" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\date_time_picker\\release\\ace.ace
copy .\\eiffel_project.eifp .\\date_time_picker\\date_time_picker.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir progress_bar
cd progress_bar
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\progress_bar_ctl\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\progress_bar_ctl\ace.ace" "$ISE_EIFFEL\examples\winforms\progress_bar" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\progress_bar\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\progress_bar_ctl\ace.ace" "$ISE_EIFFEL\examples\winforms\progress_bar" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\progress_bar\\release\\ace.ace
copy .\\eiffel_project.eifp .\\progress_bar\\progress_bar.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir tree_view
cd tree_view
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\tree_view_ctl\*.e
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\tree_view_ctl\*.bmp
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\tree_view_ctl\ace.ace" "$ISE_EIFFEL\examples\winforms\tree_view" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\tree_view\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\tree_view_ctl\ace.ace" "$ISE_EIFFEL\examples\winforms\tree_view" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\tree_view\\release\\ace.ace
copy .\\eiffel_project.eifp .\\tree_view\\tree_view.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir menu
cd menu
copy %EIFFEL_SRC%\examples\dotnet\winforms\menu\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\menu\ace.ace" "$ISE_EIFFEL\examples\winforms\menu" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\menu\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\menu\ace.ace" "$ISE_EIFFEL\examples\winforms\menu" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\menu\\release\\ace.ace
copy .\\eiffel_project.eifp .\\menu\\menu.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir mdi
cd mdi
copy %EIFFEL_SRC%\examples\dotnet\winforms\mdi\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\mdi\ace.ace" "$ISE_EIFFEL\examples\winforms\mdi" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\mdi\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\mdi\ace.ace" "$ISE_EIFFEL\examples\winforms\mdi" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\mdi\\release\\ace.ace
copy .\\eiffel_project.eifp .\\mdi\\mdi.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir window_calculator
cd window_calculator
copy %EIFFEL_SRC%\examples\dotnet\winforms\applications\world_calc\*.e
copy %EIFFEL_SRC%\examples\dotnet\winforms\applications\world_calc\*.dll
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\world_calc_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\world_calc_release.ace .\\release\\ace.ace
cd ..
rem cd ..
rem call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\applications\world_calc\ace.ace" "$ISE_EIFFEL\examples\winforms\window_calculator" "debug"
rem copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\window_calculator\\debug\\ace.ace
rem call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\applications\world_calc\ace.ace" "$ISE_EIFFEL\examples\winforms\window_calculator" "release"
rem copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\window_calculator\\release\\ace.ace
rem copy .\\eiffel_project.eifp .\\window_calculator\\window_calculator.eifp
rem del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

mkdir gdi
cd gdi
copy %EIFFEL_SRC%\examples\dotnet\winforms\gdi_plus\text\*.e
copy %EIFFEL_SRC%\examples\dotnet\winforms\gdi_plus\text\*.jpg
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\gdi_plus\text\ace.ace" "$ISE_EIFFEL\examples\winforms\gdi" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\gdi\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\gdi_plus\text\ace.ace" "$ISE_EIFFEL\examples\winforms\gdi" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\gdi\\release\\ace.ace
copy .\\eiffel_project.eifp .\\gdi\\gdi.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

del es_to_envision.exe
del eiffel_project.eifp

cd ..


rem "----------------------------------------Copy Vision2 examples----------------------------------------"
mkdir vision2
rem xcopy /s/e ..\\vision2 .\\vision2
cd vision2

mkdir accelerator
cd accelerator
copy %EIFFEL_SRC%\examples\vision2\accelerator\*.e 
copy ..\\..\\eiffel_project.eifp .\\accelerator.eifp
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\accelerator_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\accelerator_release.ace .\\release\\ace.ace
cd ..

mkdir cursor
cd cursor
copy %EIFFEL_SRC%\examples\vision2\cursor\*.e 
copy ..\\..\\eiffel_project.eifp .\\cursor.eifp
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\cursor_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\cursor_release.ace .\\release\\ace.ace
cd ..

mkdir gauges
cd gauges
copy %EIFFEL_SRC%\examples\vision2\gauges\*.e 
copy ..\\..\\eiffel_project.eifp .\\gauges.eifp
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\gauges_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\gauges_release.ace .\\release\\ace.ace
cd ..

mkdir standard_dialogs
cd standard_dialogs
copy %EIFFEL_SRC%\examples\vision2\standard_dialogs\*.e 
copy ..\\..\\eiffel_project.eifp .\\standard_dialogs.eifp
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\standard_dialogs_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\standard_dialogs_release.ace .\\release\\ace.ace
cd ..

mkdir viewport
cd viewport
copy %EIFFEL_SRC%\examples\vision2\viewport\*.e 
copy ..\\..\\eiffel_project.eifp .\\viewport.eifp
copy %EIFFEL_SRC%\examples\vision2\viewport\*.png
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\viewport_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\viewport_release.ace .\\release\\ace.ace
cd ..

mkdir widgets
cd widgets
copy %EIFFEL_SRC%\examples\vision2\widgets\*.e 
copy ..\\..\\eiffel_project.eifp .\\widgets.eifp
copy %EIFFEL_SRC%\examples\vision2\widgets\*.png
mkdir debug
mkdir release
copy ..\\..\\..\\template_aces\\widgets_debug.ace .\\debug\\ace.ace
copy ..\\..\\..\\template_aces\\widgets_release.ace .\\release\\ace.ace
cd ..

cd ..


rem "----------------------------------Copy Wel examples---------------------------------------------"

mkdir wel

cd wel
mkdir step1
cd step1
copy %EIFFEL_SRC%\examples\wel\tutorial\step1\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step1\app.ico .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step1\app.ico .\release
copy %EIFFEL_SRC%\examples\wel\tutorial\step1\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step1\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step1.ace" "$ISE_EIFFEL\examples\wel\step1" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step1\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step1.ace" "$ISE_EIFFEL\examples\wel\step1" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step1\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step1\\step1.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step2
cd step2
copy %EIFFEL_SRC%\examples\wel\tutorial\step2\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step2\app.ico .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step2\app.ico .\release
copy %EIFFEL_SRC%\examples\wel\tutorial\step2\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step2\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step2.ace" "$ISE_EIFFEL\examples\wel\step2" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step2\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step2.ace" "$ISE_EIFFEL\examples\wel\step2" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step2\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step2\\step2.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step3
cd step3
copy %EIFFEL_SRC%\examples\wel\tutorial\step3\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step3\app.ico .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step3\app.ico .\release
copy %EIFFEL_SRC%\examples\wel\tutorial\step3\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step3\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step3.ace" "$ISE_EIFFEL\examples\wel\step3" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step3\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step3.ace" "$ISE_EIFFEL\examples\wel\step3" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step3\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step3\\step3.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step4
cd step4
copy %EIFFEL_SRC%\examples\wel\tutorial\step4\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step4\app.ico .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step4\app.ico .\release
copy %EIFFEL_SRC%\examples\wel\tutorial\step4\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step4\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step4.ace" "$ISE_EIFFEL\examples\wel\step4" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step4\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step4.ace" "$ISE_EIFFEL\examples\wel\step4" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step4\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step4\\step4.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step5
cd step5
copy %EIFFEL_SRC%\examples\wel\tutorial\step5\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step5\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step5\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step5.ace" "$ISE_EIFFEL\examples\wel\step5" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step5\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step5.ace" "$ISE_EIFFEL\examples\wel\step5" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step5\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step5\\step5.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step6
cd step6
copy %EIFFEL_SRC%\examples\wel\tutorial\step6\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step6\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step6\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step6.ace" "$ISE_EIFFEL\examples\wel\step6" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step6\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step6.ace" "$ISE_EIFFEL\examples\wel\step6" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step6\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step6\\step6.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step7
cd step7
copy %EIFFEL_SRC%\examples\wel\tutorial\step7\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step7\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step7\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step7.ace" "$ISE_EIFFEL\examples\wel\step7" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step7\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step7.ace" "$ISE_EIFFEL\examples\wel\step7" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step7\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step7\\step7.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir step8
cd step8
copy %EIFFEL_SRC%\examples\wel\tutorial\step8\*.e 
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\tutorial\step8\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\tutorial\step8\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step8.ace" "$ISE_EIFFEL\examples\wel\step8" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step8\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_tutorial_step8.ace" "$ISE_EIFFEL\examples\wel\step8" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\step8\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\step8\\step8.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace

cd wel
mkdir xcell
cd xcell
copy %EIFFEL_SRC%\examples\wel\xcell\*.e
mkdir debug
mkdir release
copy %EIFFEL_SRC%\examples\wel\xcell\*.bmp .\debug
copy %EIFFEL_SRC%\examples\wel\xcell\*.ico .\debug
copy %EIFFEL_SRC%\examples\wel\xcell\*.rc .\debug
copy %EIFFEL_SRC%\examples\wel\xcell\*.bmp .\release
copy %EIFFEL_SRC%\examples\wel\xcell\*.ico .\release
copy %EIFFEL_SRC%\examples\wel\xcell\*.rc .\release
cd ..\\..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_xcell.ace" "$ISE_EIFFEL\examples\wel\xcell" "debug"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\xcell\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\envision\template_aces\template_ace_xcell.ace" "$ISE_EIFFEL\examples\wel\xcell" "release"
copy %EIFFEL_SRC%\examples\dotnet\envision\envision.ace .\\wel\\xcell\\release\\ace.ace
copy .\\eiffel_project.eifp .\\wel\\xcell\\xcell.eifp
del %EIFFEL_SRC%\examples\dotnet\envision\envision.ace



del es_to_envision.exe
del eiffel_project.eifp

cd ..

call copy_eifp_files.bat

