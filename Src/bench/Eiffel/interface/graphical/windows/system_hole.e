indexing

	description:
		"Command to display the ace file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_HOLE

inherit
	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	DEFAULT_HOLE_COMMAND
		redefine
			work, symbol, full_symbol, name, stone_type,
			menu_name, accelerator
		end

	WARNER_CALLBACKS
		rename
			execute_warner_help as load_default,
			execute_warner_ok as load_chosen
		end

	CREATE_ACE_CALLER

create
	make

feature -- Callbacks

	load_default is
			-- Load default ace file.
		do
			load_default_ace;
		end;

	load_chosen (argument: ANY) is
		local
			chooser: NAME_CHOOSER_W
		do
			chooser := name_chooser (popup_parent);
			chooser.set_open_file;
			chooser.set_pattern ("*.ace")
			chooser.set_pattern_name ("System File (*.ace)")

			chooser.call (Current);
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Icon for the system tool.
		once
			Result := Pixmaps.bm_System
		end;

	full_symbol: PIXMAP is
			-- Icon for the system tool
		once
			Result := Pixmaps.bm_System_dot
		end;

	name: STRING is
		do
			Result := Interface_names.s_System
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_System
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	stone_type: INTEGER is
		do
			Result := System_type
		end;

feature {NONE} -- Execution

	work (argument: ANY) is
			-- With button select: popup the ACE.
			-- With transport button, do nothing.
		local
			system_stone: SYSTEM_STONE;
			fn: STRING;
			f: PLAIN_TEXT_FILE;
		do
			if is_system_tool_created and then tool = System_tool then
				tool.synchronize
			elseif Project_tool.initialized then
				if Eiffel_ace.file_name = Void then
					if argument /= Void and then argument = last_name_chooser then
						fn := clone (last_name_chooser.selected_file);
						if not fn.is_empty then
							create f.make (fn);
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Eiffel_ace.set_file_name (fn);
								work (Current);
							elseif f.exists and then not f.is_plain then
								warner (project_tool.popup_parent).custom_call 
									(Current, Warning_messages.w_Not_a_file_retry (fn), 
									Interface_names.b_Ok, Void, Interface_names.b_Cancel)
							else
								warner (project_tool.popup_parent).custom_call 
									(Current, Warning_messages.w_Cannot_read_file_retry (fn), 
									Interface_names.b_Ok, Void, Interface_names.b_Cancel)
							end
						else
							warner (project_tool.popup_parent).custom_call 
								(Current, Warning_messages.w_Not_a_file_retry (fn), 
								Interface_names.b_Ok, Void, Interface_names.b_Cancel)
						end
					else
						warner (project_tool.popup_parent).custom_call 
							(Current, Warning_messages.w_specify_ace, Interface_names.b_Browse, 
							Interface_names.b_Build, Interface_names.b_Cancel);
					end;	
				else
					create system_stone;
					system_tool.force_raise
					system_tool.display;
					system_tool.process_system (system_stone);
				end;
			end
		end;
	
feature {NONE} -- Implementation

	load_default_ace is
		local
			ace_b: ACE_BUILDER;
			wizard: WIZARD
		do
			create ace_b.make (Current);
			create wizard.make (Project_tool, wiz_dlg, ace_b);
			wizard.execute_action;
		end;

	perform_post_creation is
		local
			file_name: STRING
		do
			create file_name.make (0);
			file_name.append ("Ace.ace");
			Eiffel_ace.set_file_name (file_name);
			system_tool.display;
			system_tool.show_file_content (file_name);
		end;

feature {NONE} -- Properties

	wiz_dlg: WIZARD_DIALOG is
			-- Dialog for the wizard.
		do
			create Result.make (Interface_names.t_Ace_builder, Project_tool);
		end

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

end -- class SYSTEM_HOLE
