indexing
	description: "Command to save a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SAVE_FILE 

inherit
	EB_CONSTANTS
	SYSTEM_CONSTANTS
	TWO_STATE_CMD
		rename
			init as make,
			inactive_symbol as unmodified_pixmap,
			active_symbol as modified_pixmap
		redefine
			license_checked, unmodified_pixmap
		end

create
	make
	
feature -- Properties

	unmodified_pixmap: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Save 
		end

	modified_pixmap: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Modified
		end

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			new_file, tmp_file, file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING
			aok, create_backup, is_symlink: BOOLEAN
			save_as_cmd: SAVE_AS_FILE
			tmp_name: STRING
		do
			if tool.file_name = Void then
				create save_as_cmd.make (tool)
				save_as_cmd.execute (tool)
			else
				create new_file.make (tool.file_name)
				aok := True
				if (new_file.exists) and then (not new_file.is_plain) then
					aok := False
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_a_plain_file (new_file.name))

				elseif new_file.exists and then (not new_file.is_writable) then
					aok := False
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_writable (new_file.name))

				elseif (not new_file.exists) and then (not new_file.is_creatable) then
					aok := False
					warner (popup_parent).gotcha_call (Warning_messages.w_Not_creatable (new_file.name))
				end

				is_symlink := new_file.is_symlink
				if is_symlink then
						-- Copy the original file to a swap file
					tmp_name := clone (tool.file_name)
					tmp_name.append (".swp")
					create tmp_file.make (tmp_name)
					create_backup := not tmp_file.exists and then tmp_file.is_creatable
					if create_backup then
							-- Copy content of `original' file to `original.swp'
						new_file.open_read
						new_file.read_stream (new_file.count)
						new_file.close
						tmp_file.open_write
						tmp_file.put_string (new_file.last_string)
						tmp_file.close
						file := tmp_file
						tmp_file := new_file
					end
				else
						-- Create a backup of the file in case there will be a problem during the savings.
					tmp_name := clone (tool.file_name)
					tmp_name.append (".swp")
					create tmp_file.make (tmp_name)
					create_backup := not tmp_file.exists and then tmp_file.is_creatable
				end

				if not create_backup then
					tmp_file := new_file
				end

				if aok then
					to_write := text_window.text
					tmp_file.open_write
					if not to_write.is_empty then
						to_write.prune_all ('%R')
						if general_resources.text_mode.value.is_equal ("UNIX") then
							tmp_file.put_string (to_write)
							if to_write.item (to_write.count) /= '%N' then 
								-- Add a carriage return like `vi' if there's none at the end 
								tmp_file.put_new_line
							end
						else
							to_write.replace_substring_all ("%N", "%R%N")
							tmp_file.put_string (to_write)
						end
					end
					tmp_file.close

					if create_backup then
						if is_symlink then
								-- We delete the backup done from the symbolic link.
							file.delete
						else
								-- We need to copy the backup file to the original file and then
								-- delete the backup file
							new_file.delete
							tmp_file.change_name (tool.file_name)
						end
					end

					text_window.disable_clicking
					if tool.stone /= Void and then Class_resources.parse_class_after_saving.actual_value then
						if tool.parse_file then
							tool.update
						end
					end
					tool.update_save_symbol
				end
			end
		end

 
	
feature {NONE} -- Attributes

	license_checked: BOOLEAN is True
			-- Is the license checked?

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Save
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Save
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Save
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

end -- class SAVE_FILE
