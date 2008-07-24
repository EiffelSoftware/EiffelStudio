indexing
	description: "Names for external outputs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_OUTPUT_NAMES

inherit
	SHARED_LOCALE

feature -- Names

	t_command_name: STRING_32 is 				 do Result := locale.translation ("Command name: ") end
	l_no_command_is_running: STRING_32 is 		 do Result := locale.translation ("No command is running") end
	f_Input_text_field: STRING_32 is 			 do Result := locale.translation ("Type input data here") end
	f_Input_send_button: STRING_32 is    		 do Result := locale.translation ("Send input data into the running command") end
	f_Terminate_command_button: STRING_32 is 	 do Result := locale.translation ("Terminate running command") end
	f_start_command_button: STRING_32 is 		 do Result := locale.translation ("Start command") end
	f_run_process_hidden_button: STRING_32 is	 do Result := locale.translation ("Run command hidden") end
	f_edit_cmd_detail_button: STRING_32 is		 do Result := locale.translation ("Edit command") end
	f_send_input_button: STRING_32 is			 do Result := locale.translation ("Send input to command") end
	f_delete_command: STRING_32 is				 do Result := locale.translation ("Delete command") end
	f_clear_output: STRING_32 is				 do Result := locale.translation ("Clear output") end
	l_launching: STRING_32 is					 do Result := locale.translation ("Launching...") end
	l_command_has_been_terminated: STRING_32 is	 do Result := locale.translation ("Command terminated") end
	l_launch_failed: STRING_32 is				 do Result := locale.translation ("Launch failed") end
	l_command_is_running: STRING_32 is			 do Result := locale.translation ("Command is running") end
	l_command: STRING_32 is						 do Result := locale.translation ("Command") end
	l_output: STRING_32 is						 do Result := locale.translation ("Output") end
	l_input: STRING_32 is						 do Result := locale.translation ("Input") end
	f_save_output_button: STRING_32 is 			 do Result := locale.translation ("Save output to file") end
	f_new_cmd_detail_button: STRING_32 is		 do Result := locale.translation ("Add a new command") end

	l_command_has_exited_with_code (a_code: INTEGER): STRING_32 is
		do
			Result := locale.formatted_string (locale.translation ("Command has exited with code $1"), [a_code.out])
		end

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
