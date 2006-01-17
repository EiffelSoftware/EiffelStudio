indexing

	description:	
		"Command to open a new ace file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OPEN_SYSTEM 

inherit

	SHARED_EIFFEL_PROJECT;
	OPEN_FILE
		redefine
			work
		end;

create

	make
	
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Open a file.
		local
			fn: STRING;
			f: PLAIN_TEXT_FILE;
			chooser: NAME_CHOOSER_W
		do
			if argument /= Void and then argument = last_name_chooser then
				fn := clone (last_name_chooser.selected_file);
				if not fn.is_empty then
					create f.make (fn);
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						tool.show_file (f);
						Eiffel_ace.set_file_name (fn)
					elseif f.exists and then not f.is_plain then
						warner (popup_parent).custom_call (Current,
							Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
					else
						warner (popup_parent).custom_call (Current, 
						Warning_messages.w_Cannot_read_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel);
					end
				else
					warner (popup_parent).custom_call (Current,
						Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
				end
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					chooser := name_chooser (popup_parent);
					chooser.set_open_file;
					chooser.set_pattern ("*.ace")
					chooser.set_pattern_name ("System File (*.ace)")

					last_name_chooser.call (Current) 
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

end -- class OPEN_SYSTEM
