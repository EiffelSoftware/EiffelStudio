rm -rf %TEMP%\vision2_precompile
mkdir %TEMP%\vision2_precompile
XCOPY /Y vision2.acex %TEMP%\Vision2_precompile
XCOPY /Y flatshort_instructions.txt %TEMP%\Vision2_precompile
%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec -config %TEMP%\Vision2_precompile\vision2.acex -project_path %TEMP%\vision2_precompile

REM now perform generation based on "flatshort_instructions.txt"

type %TEMP%\Vision2_precompile\flatshort_instructions.txt | %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec -config %TEMP%\Vision2_precompile\vision2.acex -loop


REM copy all flatshorts to flatshort directory
MD .\flatshort

XCOPY /Y %TEMP%\Vision2_precompile\ev_cell_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_fixed_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_frame_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_horizontal_box_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_horizontal_split_area_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_notebook_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_scrollable_area_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_table_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_vertical_box_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_vertical_split_area_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_viewport_flatshort.rtf .\flatshort



XCOPY /Y %TEMP%\Vision2_precompile\ev_button_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_check_button_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_checkable_list_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_checkable_tree_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_combo_box_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_drawing_area_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_grid_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_header_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_horizontal_progress_bar_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_horizontal_range_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_horizontal_scroll_bar_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_horizontal_separator_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_label_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_list_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_multi_column_list_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_password_field_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_pixmap_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_radio_button_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_spin_button_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_text_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_rich_text_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_text_field_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_toggle_button_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_tool_bar_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_tree_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_vertical_progress_bar_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_vertical_range_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_vertical_scroll_bar_flatshort.rtf .\flatshort
XCOPY /Y %TEMP%\Vision2_precompile\ev_vertical_separator_flatshort.rtf .\flatshort

REM remove vision2_precompile directory.
rm -rf %TEMP%\vision2_precompile
