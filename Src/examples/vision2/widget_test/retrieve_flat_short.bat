mkdir %TEMP%\vision2_precompile
XCOPY /Y root_none.ace %TEMP%\Vision2_precompile
%ISE_EIFFEL%\studio\spec\windows\bin\ec -precompile -ace %TEMP%\Vision2_precompile\root_none.ace -project_path %TEMP%\vision2_precompile
%ISE_EIFFEL%\studio\spec\windows\bin\ec -project %TEMP%\Vision2_precompile\precomp.epr -flatshort -all

REM copy all flatshorts to flatshort directory
MD .\flatshort

XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_cell_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_fixed_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_frame_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_horizontal_box_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_horizontal_split_area_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_notebook_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_scrollable_area_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_table_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_vertical_box_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_vertical_split_area_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\containers\ev_viewport_flatshort.txt .\flatshort



XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_button_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_check_button_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_combo_box_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_drawing_area_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_horizontal_progress_bar_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_horizontal_range_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_horizontal_scroll_bar_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_horizontal_separator_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_label_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_list_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_multi_column_list_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_password_field_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_pixmap_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_radio_button_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_spin_button_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_text_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_text_field_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_toggle_button_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_tool_bar_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_tree_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_vertical_progress_bar_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_vertical_range_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_vertical_scroll_bar_flatshort.txt .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\Documentation\vision2\interface\widgets\primitives\ev_vertical_separator_flatshort.txt .\flatshort

