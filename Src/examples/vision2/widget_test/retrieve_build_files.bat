if .%1. == .. goto no_command_line

REM Check out Build source.
cvs co -r %1 Src/build2

REM Check out bitmaps from Build delivery
cvs co -r %1 Delivery/build/bitmaps

REM Check out files from vision2_tour
cvs co -r %1 Delivery/vision2_tour

GOTO files_checked_out

:no_command_line

REM Check out Build source.
cvs co Src/build2

REM Check out bitmaps from Build delivery
cvs co Delivery/build/bitmaps

REM Check out files from vision2_tour
cvs co Delivery/vision2_tour

:files_checked_out
REM Copy template files
XCOPY /Y /E /I Delivery\vision2_tour\templates .\templates

REM Copy constants and eiffel environment to interface.
XCOPY /Y Src\Build2\constants\gb_constants.e .\interface
XCOPY /Y Src\Build2\utilities\eiffel_env.e .\interface
XCOPY /Y Src\Build2\utilities\gb_general_utilities.e .\interface
XCOPY /Y Src\Build2\utilities\gb_widget_utilities.e .\interface
XCOPY /Y Src\Build2\utilities\ordered_string_handler.e .\interface
XCOPY /Y Src\Build2\main\gb_supported_events.e .\interface

REM Copy icons for different widget types across. The /E option moves the whole directory structure.
XCOPY /Y /E /I Delivery\build\bitmaps .\bitmaps

REM Copy icons for standard buttons.
XCOPY /Y Delivery\vision2_tour\bitmaps\ico\documentation.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_tour\bitmaps\ico\testing.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_tour\bitmaps\ico\properties.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_tour\bitmaps\ico\size_down.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_tour\bitmaps\ico\size_up.ico .\bitmaps\ico\
XCOPY /Y Delivery\vision2_tour\bitmaps\png\image1.png .\bitmaps\png\
XCOPY /Y Delivery\vision2_tour\bitmaps\png\image2.png .\bitmaps\png\


REM Copy modified vision2 interface files needed.
XCOPY /Y Src\Build2\modified_libraries\vision2\ev_pixmap.e .\interface
XCOPY /Y Src\Build2\modified_libraries\vision2\ev_pixmapable.e .\interface


REM Copy all the editor constructor classes into interface.
XCOPY /Y Src\Build2\interface\gb_ev_pixmap_handler.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_box_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_container_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_fixed_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_frame_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_notebook_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_table_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\containers\gb_ev_viewport_editor_constructor.e .\interface

XCOPY /E /I /Y Src\Build2\interface\events .\interface\events


XCOPY /Y Src\Build2\interface\widgets\primitives\gb_ev_gauge_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\primitives\gb_ev_pixmap_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\widgets\primitives\gb_ev_text_component_editor_constructor.e .\interface

XCOPY /Y Src\Build2\interface\properties\gb_ev_colorizable_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_deselectable_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_fontable_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_pixmapable_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_sensitive_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_text_alignable_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_textable_editor_constructor.e .\interface
XCOPY /Y Src\Build2\interface\properties\gb_ev_tooltipable_editor_constructor.e .\interface

REM Copy image used for executable icon.

XCOPY %EIFFEL_SRC%\library\vision2\Clib\default_vision2_icon.ico .
ren default_vision2_icon.ico vision2_tour.ico


REM Remove all temporary checked out files.
rm -r Src
rm -r Delivery
