REM Check out Build source.
cvs co Src/build2

REM Copy constants and eiffel environment to interface.
XCOPY /Y Src\Build2\constants\gb_constants.e .\interface
XCOPY /Y Src\Build2\utilities\eiffel_env.e .\interface
XCOPY /Y Src\Build2\utilities\gb_general_utilities.e .\interface
XCOPY /Y Src\Build2\utilities\gb_widget_utilities.e .\interface
XCOPY /Y Src\Build2\utilities\ordered_string_handler.e .\interface
XCOPY /Y Src\Build2\main\gb_supported_events.e .\interface


REM Copy modified vision2 interface failes needed.
XCOPY /Y Src\Build2\modified_libraries\vision2\ev_pixmap.e .\interface
XCOPY /Y Src\Build2\modified_libraries\vision2\ev_pixmapable.e .\interface


REM Copy all the editor constructor classes into interface.
XCOPY /Y Src\Build2\interface\gb_ev_pixmap_handler.e .\interface
XCOPY /Y Src\Build2\interface\widgets\gb_ev_widget_editor_constructor.e .\interface
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

REM Remove all temporary checked out files.
rm -r Src
