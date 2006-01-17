indexing

	description:	
		"Command to open a file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"


class OPEN_DYNAMIC_LIB

inherit

	OPEN_FILE
		redefine
			work, loose_changes, save_changes
		end

create

	make
	
feature -- Callbacks

	load_chosen (argument: ANY) is
		local
			chooser: NAME_CHOOSER_W
		do
			chooser := name_chooser (popup_parent);
			chooser.set_open_file;
			chooser.call (Current);
		end;

	loose_changes is
		local
			f: PLAIN_TEXT_FILE
			res: BOOLEAN
		do
			if Eiffel_dynamic_lib.file_name /= Void then
				create f.make_open_read (Eiffel_dynamic_lib.file_name)

				Res:= Eiffel_dynamic_lib.parse_exports_from_file(f)
				Eiffel_dynamic_lib.set_modified(False)
				dynamic_lib_tool.hide
			end
		end

	save_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			if dynamic_lib_tool.save_cmd_holder /= Void then
				dynamic_lib_tool.save_cmd_holder.associated_command.execute (Void)
			end
			dynamic_lib_tool.text_window.clear_window;
			Eiffel_dynamic_lib.set_modified(False)
			dynamic_lib_tool.hide;
		end


	
feature {NONE} -- Implementation

	new_dynamic_lib_file: BOOLEAN

	work (argument: ANY) is
			-- Open a file.
		local
			fn: FILE_NAME;
			f: PLAIN_TEXT_FILE;
			chooser: NAME_CHOOSER_W;
		do
			if argument /= Void and then argument = last_name_chooser then
				create fn.make_from_string (last_name_chooser.selected_file);
				if not fn.is_empty then
					create f.make (fn);
					if
						f.exists and then 
						f.is_readable and then 
						f.is_plain
					then
						Eiffel_dynamic_lib.set_file_name (fn)
						new_dynamic_lib_file := True
						work(Current)
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
				if Eiffel_dynamic_lib.modified then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				elseif new_dynamic_lib_file then
					new_dynamic_lib_file := False
 					dynamic_lib_tool.display
 					dynamic_lib_tool.show_file_content (Eiffel_dynamic_lib.file_name)
				else

					chooser := name_chooser (popup_parent);
					chooser.set_open_file;
					chooser.set_pattern ("*.def")
					chooser.set_pattern_name ("Dynamic Library Definition File (*.def)")

					chooser.call (Current) 
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

end -- class OPEN_DYNAMIC_LIB
 

