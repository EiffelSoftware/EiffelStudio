echo off

mkdir samples
cd samples
copy ..\eiffel_stud_to_envision.exe
copy ..\eiffel_project.eifp

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\calculator\ace.ace" "$ISE_EIFFEL\..\samples\ado.net"
mkdir ado
cd ado
copy %ISE_EIFFEL%\examples\dotnet\ado\ado3\*.e 
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\ado.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\calculator\ace.ace" "$ISE_EIFFEL\..\samples\calculator"
mkdir calculator
cd calculator
copy "ISE_EIFFEL\examples\base\calculator\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\calculator.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\threading\monitor\ace.ace" "$ISE_EIFFEL\..\samples\monitor"
mkdir monitor
cd monitor
copy "ISE_EIFFEL\examples\dotnet\threading\monitor\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\monitor.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\threading\pools\ace.ace" "$ISE_EIFFEL\..\samples\pools"
mkdir pools
cd pools
copy "ISE_EIFFEL\examples\dotnet\threading\pools\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\pools.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\threading\timers\ace.ace" "$ISE_EIFFEL\..\samples\timers"
mkdir timers
cd timers
copy "ISE_EIFFEL\examples\dotnet\threading\timers\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\timers.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\data\grid\ace.ace" "$ISE_EIFFEL\..\samples\data"
mkdir data
cd data
copy "ISE_EIFFEL\examples\dotnet\winforms\data\grid\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\data.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\basic\ace.ace" "$ISE_EIFFEL\..\samples\simple_window"
mkdir simple_window
cd simple_window
copy "ISE_EIFFEL\examples\dotnet\winforms\basic\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\simple_window.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\hello_world\ace.ace" "$ISE_EIFFEL\..\samples\hello_world_window"
mkdir hello_world_window
cd hello_world_window
copy "ISE_EIFFEL\examples\dotnet\winforms\hello_world*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\hello_world_window.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\hello_world_dlg\ace.ace" "$ISE_EIFFEL\..\samples\hello_world_dialog"
mkdir hello_world_dialog
cd hello_world_dialog
copy "ISE_EIFFEL\examples\dotnet\winforms\hello_world_dlg\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\hello_world_dialog.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\control_reference\date_time_picker_ctl\ace.ace" "$ISE_EIFFEL\..\samples\date_time_picker"
mkdir date_time_picker
cd date_time_picker
copy "ISE_EIFFEL\examples\dotnet\winforms\control_reference\date_time_picker_ctl\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\date_time_picker.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\control_reference\progress_bar_ctl\ace.ace" "$ISE_EIFFEL\..\samples\progress_bar"
mkdir progress_bar
cd progress_bar
copy "ISE_EIFFEL\examples\dotnet\winforms\control_reference\progress_bar_ctl\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\progress_bar.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\control_reference\tree_view_ctl\ace.ace" "$ISE_EIFFEL\..\samples\tree_view"
mkdir tree_view
cd tree_view
copy "ISE_EIFFEL\examples\dotnet\winforms\control_reference\tree_view_ctl\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\tree_view.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\menu\ace.ace" "$ISE_EIFFEL\..\samples\menu"
mkdir menu
cd menu
copy "ISE_EIFFEL\examples\dotnet\winforms\menu\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\menu.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\mdi\ace.ace" "$ISE_EIFFEL\..\samples\mdi"
mkdir mdi
cd mdi
copy "ISE_EIFFEL\examples\dotnet\winforms\mdi\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\mdi.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\applications\world_calc\ace.ace" "$ISE_EIFFEL\..\samples\window_calculator"
mkdir window_calculator
cd window_calculator
copy "ISE_EIFFEL\examples\dotnet\winforms\applications\world_calc\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\window_calculator.eifp
cd ..
del envision.ace

call eiffel_stud_to_envision.exe "ISE_EIFFEL\examples\dotnet\winforms\gdi_plus\text\ace.ace" "$ISE_EIFFEL\..\samples\gdi"
mkdir gdi
cd gdi
copy "ISE_EIFFEL\examples\dotnet\winforms\gdi_plus\text\*.e"
mkdir debug
mkdir release
copy ..\\envision.ace .\\debug\\ace.ace
copy ..\\envision.ace .\\release\\ace.ace
copy ..\\eiffel_project.eifp .\\gdi.eifp
cd ..
del envision.ace

del eiffel_stud_to_envision.exe
del eiffel_project.eifp
