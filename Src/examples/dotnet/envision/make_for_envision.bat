@echo off

if not exist es_to_envision.exe call compile_es_to_envision.bat
if exist samples rd /q /s samples
mkdir samples
cd samples
copy ..\es_to_envision.exe
copy ..\eiffel_project.eifp

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\calculator\ace.ace" "$EIFFEL_SRC\..\samples\ado"
mkdir ado
cd ado
copy %EIFFEL_SRC%\examples\dotnet\ado\ado3\*.e 
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\ado.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\calculator\ace.ace" "$EIFFEL_SRC\..\samples\calculator"
mkdir calculator
cd calculator
copy %EIFFEL_SRC%\examples\base\calculator\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\calculator.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\monitor\ace.ace" "$EIFFEL_SRC\..\samples\monitor"
mkdir monitor
cd monitor
copy %EIFFEL_SRC%\examples\dotnet\threading\monitor\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\monitor.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\pools\ace.ace" "$EIFFEL_SRC\..\samples\pools"
mkdir pools
cd pools
copy %EIFFEL_SRC%\examples\dotnet\threading\pools\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\pools.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\threading\timers\ace.ace" "$EIFFEL_SRC\..\samples\timers"
mkdir timers
cd timers
copy %EIFFEL_SRC%\examples\dotnet\threading\timers\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\timers.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\data\grid\ace.ace" "$EIFFEL_SRC\..\samples\data"
mkdir data
cd data
copy %EIFFEL_SRC%\examples\dotnet\winforms\data\grid\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\data.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\basic\ace.ace" "$EIFFEL_SRC\..\samples\simple_window"
mkdir simple_window
cd simple_window
copy %EIFFEL_SRC%\examples\dotnet\winforms\basic\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\simple_window.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world\ace.ace" "$EIFFEL_SRC\..\samples\hello_world_window"
mkdir hello_world_window
cd hello_world_window
copy %EIFFEL_SRC%\examples\dotnet\winforms\hello_world*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\hello_world_window.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\hello_world_dlg\ace.ace" "$EIFFEL_SRC\..\samples\hello_world_dialog"
mkdir hello_world_dialog
cd hello_world_dialog
copy %EIFFEL_SRC%\examples\dotnet\winforms\hello_world_dlg\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\hello_world_dialog.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\date_time_picker_ctl\ace.ace" "$EIFFEL_SRC\..\samples\date_time_picker"
mkdir date_time_picker
cd date_time_picker
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\date_time_picker_ctl\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\date_time_picker.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\progress_bar_ctl\ace.ace" "$EIFFEL_SRC\..\samples\progress_bar"
mkdir progress_bar
cd progress_bar
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\progress_bar_ctl\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\progress_bar.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\control_reference\tree_view_ctl\ace.ace" "$EIFFEL_SRC\..\samples\tree_view"
mkdir tree_view
cd tree_view
copy %EIFFEL_SRC%\examples\dotnet\winforms\control_reference\tree_view_ctl\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\tree_view.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\menu\ace.ace" "$EIFFEL_SRC\..\samples\menu"
mkdir menu
cd menu
copy %EIFFEL_SRC%\examples\dotnet\winforms\menu\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\menu.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\mdi\ace.ace" "$EIFFEL_SRC\..\samples\mdi"
mkdir mdi
cd mdi
copy %EIFFEL_SRC%\examples\dotnet\winforms\mdi\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\mdi.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\applications\world_calc\ace.ace" "$EIFFEL_SRC\..\samples\window_calculator"
mkdir window_calculator
cd window_calculator
copy %EIFFEL_SRC%\examples\dotnet\winforms\applications\world_calc\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\window_calculator.eifp
cd ..
del envision.ace

call es_to_envision.exe "EIFFEL_SRC\examples\dotnet\winforms\gdi_plus\text\ace.ace" "$EIFFEL_SRC\..\samples\gdi"
mkdir gdi
cd gdi
copy %EIFFEL_SRC%\examples\dotnet\winforms\gdi_plus\text\*.e
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\gdi.eifp
cd ..
del envision.ace

del es_to_envision.exe
del eiffel_project.eifp
