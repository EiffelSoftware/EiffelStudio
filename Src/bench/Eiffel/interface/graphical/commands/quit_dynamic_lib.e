indexing

	description:	
		"Command to quit the system tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_DYNAMIC_LIB

inherit

	QUIT_FILE
		redefine 
			work, save_changes, loose_changes, tool
		end

create

	make
	
feature -- Callbacks

	loose_changes is
		local
			f: PLAIN_TEXT_FILE
			res: BOOLEAN
		do
			if tool.Eiffel_dynamic_lib.file_name /= Void then
				create f.make_open_read (tool.Eiffel_dynamic_lib.file_name)

				Res:= tool.Eiffel_dynamic_lib.parse_exports_from_file(f)
				tool.Eiffel_dynamic_lib.set_modified(False)
				tool.hide
			end
		end

	save_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end
			text_window.clear_window;
			tool.Eiffel_dynamic_lib.set_modified(False)
			tool.hide;
		end

feature

	tool: DYNAMIC_LIB_W

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if last_warner /= Void and argument = last_warner then
			else
				-- First click on open
				if tool.Eiffel_dynamic_lib.modified then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					text_window.clear_window;
					tool.hide;
					tool.close_windows;
				end
			end
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

end -- class QUIT_DYNAMIC_LIB

