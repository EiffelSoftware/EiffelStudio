@echo off

if not exist es_to_envision.exe call compile_es_to_envision.bat
if exist samples rd /q /s samples
mkdir samples
cd samples
copy ..\es_to_envision.exe
copy ..\eiffel_project.eifp

mkdir ado
cd ado
copy %EIFFEL_SRC%\examples\dotnet\ado\ado3\*.e 
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\ado\ado3\ace.ace" "$EIFFEL_SRC\..\samples\ado" "debug"
copy .\\envision.ace .\\ado\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\ado\ado3\ace.ace" "$EIFFEL_SRC\..\samples\ado" "release"
copy .\\envision.ace .\\ado\\release\\ace.ace
copy .\\eiffel_project.eifp .\\ado\\ado.eifp
del envision.ace

mkdir calculator
cd calculator
copy %EIFFEL_SRC%\examples\base\calculator\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\calculator\ace.ace" "$EIFFEL_SRC\..\samples\calculator" "debug"
copy .\\envision.ace .\\calculator\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\calculator\ace.ace" "$EIFFEL_SRC\..\samples\calculator" "release"
copy .\\envision.ace .\\calculator\\release\\ace.ace
copy .\\eiffel_project.eifp .\\calculator\\calculator.eifp
del envision.ace

mkdir monitor
cd monitor
copy %EIFFEL_SRC%\examples\dotnet\threading\monitor\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\monitor\ace.ace" "$EIFFEL_SRC\..\samples\monitor" "debug"
copy .\\envision.ace .\\monitor\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\monitor\ace.ace" "$EIFFEL_SRC\..\samples\monitor" "release"
copy .\\envision.ace .\\monitor\\release\\ace.ace
copy .\\eiffel_project.eifp .\\monitor\\monitor.eifp
del envision.ace

mkdir pools
cd pools
copy %EIFFEL_SRC%\examples\dotnet\threading\pools\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\pools\ace.ace" "$EIFFEL_SRC\..\samples\pools" "debug"
copy .\\envision.ace .\\pools\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\pools\ace.ace" "$EIFFEL_SRC\..\samples\pools" "release"
copy .\\envision.ace .\\pools\\release\\ace.ace
copy .\\eiffel_project.eifp .\\pools\\pools.eifp
del envision.ace

mkdir timers
cd timers
copy %EIFFEL_SRC%\examples\dotnet\threading\timers\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\timers\ace.ace" "$EIFFEL_SRC\..\samples\timers" "debug"
copy .\\envision.ace .\\timers\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\timers\ace.ace" "$EIFFEL_SRC\..\samples\timers" "release"
copy .\\envision.ace .\\timers\\release\\ace.ace
copy .\\eiffel_project.eifp .\\timers\\timers.eifp
del envision.ace

mkdir data
cd data
copy %EIFFEL_SRC%\examples\dotnet\winforms\data\grid\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\data\grid\ace.ace" "$EIFFEL_SRC\..\samples\data" "debug"
copy .\\envision.ace .\\data\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\data\grid\ace.ace" "$EIFFEL_SRC\..\samples\data" "release"
copy .\\envision.ace .\\data\\release\\ace.ace
copy .\\eiffel_project.eifp .\\data\\data.eifp
del envision.ace

mkdir simple_window
cd simple_window
copy %EIFFEL_SRC%\examples\dotnet\winforms\basic\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\basic\ace.ace" "$EIFFEL_SRC\..\samples\simple_window" "debug"
copy .\\envision.ace .\\simple_window\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\basic\ace.ace" "$EIFFEL_SRC\..\samples\simple_window" "release"
copy .\\envision.ace .\\simple_window\\release\\ace.ace
copy .\\eiffel_project.eifp .\\simple_window\\simple_window.eifp
del envision.ace

mkdir hello_world_window
cd hello_world_window
copy %EIFFEL_SRC%\examples\dotnet\winforms\hello_world*.e"
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world\ace.ace" "$EIFFEL_SRC\..\samples\hello_world_window" "debug"
copy .\\envision.ace .\\hello_world_window\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world\ace.ace" "$EIFFEL_SRC\..\samples\hello_world_window" "release"
copy .\\envision.ace .\\hello_world_window\\release\\ace.ace
copy .\\eiffel_project.eifp .\\hello_world_window\\hello_world_window.eifp
del envision.ace

mkdir hello_world_dialog
cd hello_world_dialog
copy %EIFFEL_SRC%\examples\dotnet\winforms\hello_world_dlg\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world_dlg\ace.ace" "$EIFFEL_SRC\..\samples\hello_world_dialog" "debug"
copy .\\envision.ace .\\hello_world_dialog\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world_dlg\ace.ace" "$EIFFEL_SRC\..\samples\hello_world_dialog" "release"
copy .\\envision.ace .\\hello_world_dialog\\release\\ace.ace
copy .\\eiffel_project.eifp .\\hello_world_dialog\\hello_world_dialog.eifp
del envision.ace

mkdir date_time_picker
cd date_time_picker
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\date_time_picker_ctl\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\date_time_picker_ctl\ace.ace" "$EIFFEL_SRC\..\samples\date_time_picker" "debug"
copy .\\envision.ace .\\date_time_picker\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\date_time_picker_ctl\ace.ace" "$EIFFEL_SRC\..\samples\date_time_picker" "release"
copy .\\envision.ace .\\date_time_picker\\release\\ace.ace
copy .\\eiffel_project.eifp .\\date_time_picker\\date_time_picker.eifp
del envision.ace

mkdir progress_bar
cd progress_bar
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\progress_bar_ctl\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\progress_bar_ctl\ace.ace" "$EIFFEL_SRC\..\samples\progress_bar" "debug"
copy .\\envision.ace .\\progress_bar\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\progress_bar_ctl\ace.ace" "$EIFFEL_SRC\..\samples\progress_bar" "release"
copy .\\envision.ace .\\progress_bar\\release\\ace.ace
copy .\\eiffel_project.eifp .\\progress_bar\\progress_bar.eifp
del envision.ace

mkdir tree_view
cd tree_view
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\tree_view_ctl\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\tree_view_ctl\ace.ace" "$EIFFEL_SRC\..\samples\tree_view" "debug"
copy .\\envision.ace .\\tree_view\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\tree_view_ctl\ace.ace" "$EIFFEL_SRC\..\samples\tree_view" "release"
copy .\\envision.ace .\\tree_view\\release\\ace.ace
copy .\\eiffel_project.eifp .\\tree_view\\tree_view.eifp
del envision.ace

mkdir menu
cd menu
copy %EIFFEL_SRC%\examples\dotnet\winforms\menu\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\menu\ace.ace" "$EIFFEL_SRC\..\samples\menu" "debug"
copy .\\envision.ace .\\tree_view\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\menu\ace.ace" "$EIFFEL_SRC\..\samples\menu" "release"
copy .\\envision.ace .\\tree_view\\release\\ace.ace
copy .\\eiffel_project.eifp .\\menu\\menu.eifp
del envision.ace

mkdir mdi
cd mdi
copy %EIFFEL_SRC%\examples\dotnet\winforms\mdi\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\mdi\ace.ace" "$EIFFEL_SRC\..\samples\mdi" "debug"
copy .\\envision.ace .\\mdi\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\mdi\ace.ace" "$EIFFEL_SRC\..\samples\mdi" "release"
copy .\\envision.ace .\\mdi\\release\\ace.ace
copy .\\eiffel_project.eifp .\\mdi\\mdi.eifp
del envision.ace

mkdir window_calculator
cd window_calculator
copy %EIFFEL_SRC%\examples\dotnet\winforms\applications\world_calc\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\applications\world_calc\ace.ace" "$EIFFEL_SRC\..\samples\window_calculator" "debug"
copy .\\envision.ace .\\window_calculator\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\applications\world_calc\ace.ace" "$EIFFEL_SRC\..\samples\window_calculator" "release"
copy .\\envision.ace .\\window_calculator\\release\\ace.ace
copy .\\eiffel_project.eifp .\\window_calculator\\window_calculator.eifp
del envision.ace

mkdir gdi
cd gdi
copy %EIFFEL_SRC%\examples\dotnet\winforms\gdi_plus\text\*.e
mkdir debug
mkdir release
cd ..
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\gdi_plus\text\ace.ace" "$EIFFEL_SRC\..\samples\gdi" "debug"
copy .\\envision.ace .\\gdi\\debug\\ace.ace
call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\gdi_plus\text\ace.ace" "$EIFFEL_SRC\..\samples\gdi" "release"
copy .\\envision.ace .\\gdi\\release\\ace.ace
copy .\\eiffel_project.eifp .\\gdi\\gdi.eifp
del envision.ace

del es_to_envision.exe
del eiffel_project.eifp
cd ..