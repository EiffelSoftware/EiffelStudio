%{
indexing

	description: "Scanners for external commands"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class EB_COMMAND_SCANNER

inherit
	EB_COMMAND_SCANNER_SKELETON


create
	make

%}

%option line position outfile="eb_command_scanner.e"

D		[0-9]
A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)
ID		{A}{X}*

%%

"{"{ID}"}" {
								set_last_text_fragment (factory.new_class_buffer (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_CLASS_BUFFER
				}

"@{"{ID}"}" {
								set_last_text_fragment (factory.new_class_buffer_selected (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_CLASS_BUFFER_SELECTED
				}

"{"{ID}"}."{ID}	{
								set_last_text_fragment (factory.new_feature_buffer (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_FEATURE_BUFFER
						}

"["{ID}"]"			{
								set_last_text_fragment (factory.new_tool_buffer (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TOOL_BUFFER
						}

"@["{ID}"]"			{
								set_last_text_fragment (factory.new_tool_buffer_selected (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TOOL_BUFFER_SELECTED
						}

"$"[fF][iI][lL][eE]"_"[nN][aA][mM][eE] {
								set_last_text_fragment (factory.new_file_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_FILE_NAME
						}

"$"[cC][lL][aA][sS][sS]"_"[nN][aA][mM][eE] {
								set_last_text_fragment (factory.new_class_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_CLASS_NAME
						}

"$"[dD][iI][rR][eE][cC][tT][oO][rR][yY]"_"[nN][aA][mM][eE] {
								set_last_text_fragment (factory.new_directory_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_DIRECTORY_NAME
						}

"$"[wW]"_"[cC][oO][dD][eE] {
								set_last_text_fragment (factory.new_w_code (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_W_CODE
						}

"$"[fF]"_"[cC][oO][dD][eE] {
								set_last_text_fragment (factory.new_f_code (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_F_CODE
						}

"$"[gG][rR][oO][uU][pP]"_"[dD][iI][rR][eE][cC][tT][oO][rR][yY] {
								set_last_text_fragment (factory.new_group_directory (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_GROUP_DIRECTORY
						}

"$"[gG][rR][oO][uU][pP]"_"[nN][aA][mM][eE] {
								set_last_text_fragment (factory.new_group_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_GROUP_NAME
						}
"$"[lL][iI][nN][eE] {

								set_last_text_fragment (factory.new_line (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_LINE
						}

"$"[pP][rR][oO][jJ][eE][cC][tT]"_"[dD][iI][rR][eE][cC][tT][oO][rR][yY] {
								set_last_text_fragment (factory.new_project_directory (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_PROJECT_DIRECTORY
						}

"$"[tT][aA][rR][gG][eE][tT]"_"[dD][iI][rR][eE][cC][tT][oO][rR][yY] {
								set_last_text_fragment (factory.new_target_directory (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TARGET_DIRECTORY
						}

"$"[fF][iI][lL][eE] {
								set_last_text_fragment (factory.new_file (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_FILE
						}

"$"[pP][aA][tT][hH] {
								set_last_text_fragment (factory.new_path (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_PATH
							}
"$"[tT][aA][rR][gG][eE][tT]"_"[nN][aA][mM][eE] {
								set_last_text_fragment (factory.new_target_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TARGET_NAME
							}

.			{
								last_token := T_UNRECOGNIZED
			}

%%

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
