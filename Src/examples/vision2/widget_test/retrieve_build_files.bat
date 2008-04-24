@echo off
if .%1. == .. (
set SVN_URL=https://svn.origo.ethz.ch/eiffelstudio/trunk
) else (
set SVN_URL=%*
)

REM Check out Build source.
call svn_command.bat co %SVN_URL%/Src/build Src\build

REM Check out bitmaps from Build delivery
call svn_command.bat co %SVN_URL%/Delivery/esbuilder/bitmaps Delivery\esbuilder\bitmaps

REM Check out files from vision2_demo
call svn_command.bat co %SVN_URL%/Delivery/vision2_demo Delivery/vision2_demo

REM Copy template files
XCOPY /Y /E /I Delivery\vision2_demo\templates .\templates

REM Copy constants and eiffel environment to interface.
XCOPY /Y Src\build\constants\gb_constants.e .\interface
XCOPY /Y Src\build\utilities\gb_general_utilities.e .\interface
XCOPY /Y Src\build\utilities\gb_widget_utilities.e .\interface
XCOPY /Y Src\build\utilities\ordered_string_handler.e .\interface
XCOPY /Y Src\build\main\gb_supported_events.e .\interface
XCOPY /Y Src\build\utilities\gb_color_stone.e .\interface
XCOPY /Y Src\build\utilities\default_object_state_checker.e .\interface

REM Copy icons for different widget types across. The /E option moves the whole directory structure.
XCOPY /Y /E /I Delivery\esbuilder\bitmaps .\bitmaps

REM Copy icons for standard buttons.
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\documentation.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\testing.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\properties.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\size_down.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\ico\size_up.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_demo\bitmaps\png\image1.png .\bitmaps\png\
XCOPY /Y Delivery\vision2_demo\bitmaps\png\image2.png .\bitmaps\png\


REM Copy all the editor constructor classes into interface.
XCOPY /Y Src\build\interface\gb_ev_pixmap_handler.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_box_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_container_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_fixed_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_frame_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_notebook_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_table_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\containers\gb_ev_viewport_editor_constructor.e .\interface

REM Copy any required dialogs
XCOPY /Y Src\build\dialogs\gb_fixed_positioner\gb_fixed_positioner.e .\interface
XCOPY /Y Src\build\dialogs\gb_fixed_positioner\gb_fixed_positioner_imp.e .\interface
XCOPY /Y Src\build\dialogs\gb_table_positioner\gb_table_positioner.e .\interface
XCOPY /Y Src\build\dialogs\gb_table_positioner\gb_table_positioner_imp.e .\interface

XCOPY /E /I /Y Src\build\interface\events .\interface\events


XCOPY /Y Src\build\interface\widgets\primitives\gb_ev_gauge_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\widgets\primitives\gb_ev_text_component_editor_constructor.e .\interface

XCOPY /Y Src\build\interface\properties\gb_ev_deselectable_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\properties\gb_ev_sensitive_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\properties\gb_ev_text_alignable_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\properties\gb_ev_textable_editor_constructor.e .\interface
XCOPY /Y Src\build\interface\properties\gb_ev_tooltipable_editor_constructor.e .\interface

REM Copy image used for executable icon.

XCOPY /Y %EIFFEL_SRC%\library\vision2\Clib\default_vision2_icon.ico .
ren default_vision2_icon.ico vision2_demo.ico


REM Remove all temporary checked out files.
rm -rf Src
rm -rf Delivery
