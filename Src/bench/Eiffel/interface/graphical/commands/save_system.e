indexing
	description:	
		"Command to savethe save the ace file.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_SYSTEM

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_RESCUE_STATUS
	
	PROJECT_CONTEXT

	SAVE_FILE
		redefine
			work
		end

creation
	make

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			new_file, tmp_file, file: RAW_FILE;	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING;
			file_name, tmp_name: STRING;
			aok, create_backup, is_symlink: BOOLEAN;
			show_text: SHOW_TEXT;
			default_name: FILE_NAME
		do
			if tool.file_name /= Void then
				file_name := tool.file_name;
			else
				!! default_name.make_from_string (Project_directory_name);
				default_name.set_file_name ("Ace");
				default_name.add_extension ("ace");
				file_name := default_name
			end;
			!!new_file.make (file_name);
			aok := True;
			if (new_file.exists) and then (not new_file.is_plain) then
				aok := False;
				warner (popup_parent).gotcha_call (Warning_messages.w_Not_a_plain_file (new_file.name))

			elseif new_file.exists and then (not new_file.is_writable) then
				aok := False;
				warner (popup_parent).gotcha_call (Warning_messages.w_Not_writable (new_file.name))

			elseif (not new_file.exists) and then (not new_file.is_creatable) then
				aok := False;
				warner (popup_parent).gotcha_call (Warning_messages.w_Not_creatable (new_file.name))
			end;

			is_symlink := new_file.is_symlink
			if is_symlink then
					-- Copy the original file to a swap file
				tmp_name := clone (file_name)
				tmp_name.append (".swp")
				create tmp_file.make (tmp_name)
				create_backup := not tmp_file.exists and then tmp_file.is_creatable
				if create_backup then
						-- Copy content of `original' file to `original.swp'
					new_file.open_read
					new_file.read_stream (new_file.count)
					new_file.close
					tmp_file.open_write
					tmp_file.putstring (new_file.last_string)
					tmp_file.close
					file := tmp_file
					tmp_file := new_file
				end
			else
					-- Create a backup of the file in case there will be a problem during the savings.
				tmp_name := clone (file_name)
				tmp_name.append (".swp")
				!! tmp_file.make (tmp_name)
				create_backup := not tmp_file.exists and then tmp_file.is_creatable
			end

			if not create_backup then
				tmp_file := new_file
			end

			if aok then
				to_write := text_window.text;
				tmp_file.open_write;
				if not to_write.is_empty then
					to_write.prune_all ('%R')
					if general_resources.text_mode.value.is_equal ("UNIX") then
						tmp_file.putstring (to_write)
						if to_write.item (to_write.count) /= '%N' then 
							-- Add a carriage return like `vi' if there's none at the end 
							tmp_file.new_line
						end
					else
						to_write.replace_substring_all ("%N", "%R%N")
						tmp_file.putstring (to_write)
					end
				end;
				tmp_file.close;

				if create_backup then
					if is_symlink then
							-- We delete the backup done from the symbolic link.
						file.delete
					else
							-- We need to copy the backup file to the original file and then
							-- delete the backup file
						new_file.delete
						tmp_file.change_name (file_name)
					end
				end

				show_text ?= tool.last_format.associated_command;
				if show_text /= Void then
					--| Only set the file name if it is an Ace file
					--| (and not the show_clusters file name).
					Eiffel_ace.set_file_name (file_name);
				end;
				text_window.disable_clicking;
				if tool.stone /= Void and then system_resources.parse_ace_after_saving.actual_value then
					if tool.parse_file then
						tool.synchronise_stone
					end
				end
				tool.update_save_symbol
			end
		end

end -- class SAVE_SYSTEM
