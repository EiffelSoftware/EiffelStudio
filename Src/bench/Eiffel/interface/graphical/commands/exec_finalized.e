indexing
	description:
			"Command to execute the finalized code."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EXEC_FINALIZED

inherit

	TOOL_COMMAND
		rename
			init as make
		end;
	PROJECT_CONTEXT
		export
			{NONE} all
		end;
	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Execute Current.
		local
			appl_name: STRING;
			cmd_exec: COMMAND_EXECUTOR;
			f: RAW_FILE;
			f_name: FILE_NAME;
			make_f: INDENT_FILE;
			mp: MOUSE_PTR;
			system_name: STRING
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				system_name := clone (Eiffel_system.name);
			end;
			if system_name = Void then
				warner (popup_parent).gotcha_call (Warning_messages.w_Must_finalize_first)
			else
				appl_name := Eiffel_system.application_name (False);
				create f.make (appl_name);
				if not f.exists then
					warner (popup_parent).gotcha_call (Warning_messages.w_Unexisting_system)
				else
					create f_name.make_from_string (Final_generation_path);
					f_name.set_file_name (Makefile_SH);
					create make_f.make (f_name);
					if make_f.exists and then make_f.date > f.date then
						warner (popup_parent). gotcha_call (Warning_messages.w_MakefileSH_more_recent)
					else
						create mp.set_watch_cursor;
						appl_name.extend (' ');
						appl_name.append (current_cmd_line_argument)
						create cmd_exec;
						cmd_exec.execute (appl_name);
						mp.restore
					end
				end
			end
		end;

feature {NONE} -- Properties

	name: STRING is
			-- Short description of Current.
		do
			Result := Interface_names.f_Run_finalized
		end;
		
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Run_finalized
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EXEC_FINALIZED
