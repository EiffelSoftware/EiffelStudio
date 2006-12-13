indexing
	description: "String constants used in external output tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_OUTPUT_CONSTANTS

inherit
	SHARED_LOCALE

feature
	t_command_name: STRING_GENERAL is 				 do Result := locale.translate ("Command name: ") end
	l_no_command_is_running: STRING_GENERAL is 		 do Result := locale.translate ("No command is running") end
	f_Input_text_field: STRING_GENERAL is 			 do Result := locale.translate ("Type input data here") end
	f_Input_send_button: STRING_GENERAL is    		 do Result := locale.translate ("Send input data into the running command") end
	f_Terminate_command_button: STRING_GENERAL is 	 do Result := locale.translate ("Terminate running command") end
	f_start_command_button: STRING_GENERAL is 		 do Result := locale.translate ("Start command") end
	f_run_process_hidden_button: STRING_GENERAL is	 do Result := locale.translate ("Run command hidden") end
	f_edit_cmd_detail_button: STRING_GENERAL is		 do Result := locale.translate ("Edit command") end
	f_send_input_button: STRING_GENERAL is			 do Result := locale.translate ("Send input to command") end
	f_delete_command: STRING_GENERAL is				 do Result := locale.translate ("Delete command") end
	f_clear_output: STRING_GENERAL is				 do Result := locale.translate ("Clear output") end
	l_launching: STRING_GENERAL is					 do Result := locale.translate ("Launching...") end
	l_command_has_been_terminated: STRING_GENERAL is do Result := locale.translate ("Command terminated") end
	l_launch_failed: STRING_GENERAL is				 do Result := locale.translate ("Launch failed") end
	l_command_is_running: STRING_GENERAL is			 do Result := locale.translate ("Command is running") end
	l_command: STRING_GENERAL is					 do Result := locale.translate ("Command") end
	l_output: STRING_GENERAL is						 do Result := locale.translate ("Output") end
	l_input: STRING_GENERAL is						 do Result := locale.translate ("Input") end
	f_save_output_button: STRING_GENERAL is 		 do Result := locale.translate ("Save output to file") end
	f_new_cmd_detail_button: STRING_GENERAL is		 do Result := locale.translate ("Add a new command") end

	l_command_has_exited_with_code (a_code: INTEGER): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Command has exited with code $1"), [a_code.out])
		end

	State_bar_height: INTEGER is 20

	Red_color: EV_COLOR is
			-- Red color
		once
			create Result.make_with_8_bit_rgb (255, 0, 0)
		end

	Black_color: EV_COLOR is
			-- Black color
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
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
