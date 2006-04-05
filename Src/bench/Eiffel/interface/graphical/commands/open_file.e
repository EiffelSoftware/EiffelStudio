indexing

	description:	
		"Command to open a file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"


class OPEN_FILE 

inherit

	SHARED_EIFFEL_PROJECT;
	PIXMAP_COMMAND
		rename
			init as make
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_changes,
			execute_warner_help as loose_changes
		end

create

	make
	
feature -- Callbacks

	loose_changes is
			-- The user has eventually been warned that he will lose his stuff
			-- but he decided to open the file anyway without saving the file
			-- first.
		do
			open_file
		end;

	save_changes (argument: ANY) is
			-- The user has eventually been warned that he will lose his stuff
			-- and he want to save the file before going on.
		do
				-- Save file.
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end

				-- Then open a new one.
			open_file
		end;
	
feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Open
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Open a file.
		local
			fn: FILE_NAME;
			f: PLAIN_TEXT_FILE;
			class_i: CLASS_I;
			classi_stone: CLASSI_STONE;
			classc_stone: CLASSC_STONE
		do
			if argument /= Void and then argument = last_name_chooser then
				create fn.make_from_string (last_name_chooser.selected_file);
				if not fn.is_empty then
					create f.make (fn);
					if
						f.exists and then f.is_readable and then f.is_plain
					then
							-- Mark the Window not changed so that format processing can be done.
							-- This is required when opening a file on top of a modified file, otherwise
							-- it does not have any impact.
						text_window.set_changed (false);

						if not Project_tool.initialized then
							tool.show_file (f);
						else
							class_i := Eiffel_universe.class_with_file_name (fn)
							if class_i = Void then
								tool.show_file (f);
							elseif class_i.compiled then
								create classc_stone.make (class_i.compiled_class)
								tool.process_class (classc_stone);
							else
								create classi_stone.make (class_i)
								tool.process_classi (classi_stone);
							end
						end
					elseif f.exists and then not f.is_plain then
						warner (popup_parent).custom_call (Current, 
							Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel);
					else
						warner (popup_parent).custom_call (Current, 
						Warning_messages.w_Cannot_read_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel);
					end
				else
					warner (popup_parent).custom_call (Current, 
						Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel);
				end
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					open_file
				end
			end
		end;

	open_file is
			-- Display the dialog box to open a file
			-- and then open the file.
		local
			chooser: NAME_CHOOSER_W
		do
			chooser := name_chooser (popup_parent);
			chooser.set_open_file;
			chooser.set_pattern ("*.e")
			chooser.set_pattern_name ("Eiffel Class File (*.e)")
			chooser.call (Current)
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Open
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Open
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Open
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

end -- class OPEN_FILE
