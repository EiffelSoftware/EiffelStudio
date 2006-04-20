indexing

	description:	
		"Command to save a file under a different name."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_AS_FILE 

inherit

	PIXMAP_COMMAND
		rename
			init as make
		redefine
			license_checked
		end;
	SYSTEM_CONSTANTS;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_it
		end

create

	make
	
feature -- Callbacks

	execute_warner_help is
			-- Useless here
		do
			-- Do Nothing
		end;

	save_it (argument: ANY) is
			-- Save a file with a chosen name.
		local
			fn: STRING;
			new_file: RAW_FILE;	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING;
			aok: BOOLEAN;
		do
			fn := clone (last_name_chooser.selected_file);
			if not fn.is_empty then
				create new_file.make (fn);
				aok := True;
				if (new_file.exists) and then (not new_file.is_plain) then
					aok := False;
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_a_plain_file (fn))
				elseif 
					argument = last_name_chooser and then 
					(new_file.exists and then new_file.is_writable)
				then
					aok := False;
					warner (popup_parent).custom_call (Current, 
						Warning_messages.w_File_exists (fn), 
						Interface_names.b_Overwrite, Void, Interface_names.b_Cancel);
				elseif new_file.exists and then (not new_file.is_writable) then
					aok := False;
					warner (popup_parent).gotcha_call 
						(Warning_messages.w_Not_writable (fn))
				elseif not new_file.is_creatable then
					aok := False;
					warner (popup_parent).gotcha_call 
						(Warning_messages.w_Not_creatable (fn))
				end
			else
				aok := False;
				warner (popup_parent).gotcha_call 
					(Warning_messages.w_Not_a_plain_file (fn))
			end;

			if aok then
				to_write := text_window.text;
				new_file.open_write;
				if not to_write.is_empty then
					to_write.prune_all ('%R')
					if general_resources.text_mode.value.is_equal ("UNIX") then
						new_file.put_string (to_write)
						if to_write.item (to_write.count) /= '%N' then 
							-- Add a carriage return like `vi' if there's none at the end 
							new_file.put_new_line
						end
					else
						to_write.replace_substring_all ("%N", "%R%N")
						new_file.put_string (to_write)
					end
				end
				new_file.close;
				if text_window.changed then 
					text_window.disable_clicking
				end;
				if tool.file_name = Void then
					tool.set_file_name (new_file.name);
					tool.set_title (new_file.name);
					update_more;
				end;
			end;
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Save_as 
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local
			chooser: NAME_CHOOSER_W
		do
			if argument /= Void and then argument = last_name_chooser then
				save_it (argument)
			elseif argument = tool then
				chooser := name_chooser (popup_parent);
				chooser.set_save_file;
				chooser.call (Current)
			end
		end;

	update_more is
			-- Useless here.
		do
			-- Do nothing.
		end;

feature {NONE}

	license_checked: BOOLEAN is True;
			-- Is the license checked?

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Save_as
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Save_as
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

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

end -- class SAVE_AS_FILE
