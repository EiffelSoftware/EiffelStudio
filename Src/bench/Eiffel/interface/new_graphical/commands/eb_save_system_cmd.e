indexing
	description: "Command to save the ace file."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_SYSTEM_CMD

inherit
	SHARED_EIFFEL_PROJECT
	SHARED_RESCUE_STATUS	
	PROJECT_CONTEXT

	EB_SAVE_CMD
		redefine
			tool
		end

	EB_SYSTEM_TOOL_DATA

creation
	make

feature -- Properties

	tool: EB_SYSTEM_TOOL

feature {NONE} -- Implementation
feature -- Execution

	execute is
			-- Save a file with the chosen name.
		local   
			new_file, tmp_file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING
			file_name, tmp_name: STRING
			aok, create_backup: BOOLEAN
--			show_text: SHOW_TEXT
			default_name: FILE_NAME
			wd: EV_WARNING_DIALOG
		do
			if tool.file_name /= Void then
				file_name := tool.file_name
			else
				create default_name.make_from_string (Project_directory_name)
				default_name.set_file_name ("Ace")
				default_name.add_extension ("ace")
				file_name := default_name
			end
			create new_file.make (file_name)
			aok := True
			if (new_file.exists) and then (not new_file.is_plain) then
				aok := False
				create wd.make_with_text (Warning_messages.w_Not_a_plain_file (new_file.name))
				wd.show_modal
			elseif new_file.exists and then (not new_file.is_writable) then
				aok := False
				create wd.make_with_text (Warning_messages.w_Not_writable (new_file.name))
				wd.show_modal
			elseif (not new_file.exists) and then (not new_file.is_creatable) then
				aok := False
				create wd.make_with_text (Warning_messages.w_Not_creatable (new_file.name))
				wd.show_modal
			end

				-- Create a backup of the file in case there will be a problem during the savings.
			tmp_name := clone (file_name)
			tmp_name.append (".swp")
			create tmp_file.make (tmp_name)
			create_backup := not tmp_file.exists and then tmp_file.is_creatable

			if not create_backup then
				tmp_file := new_file
			end

			if aok then
				to_write := tool.text_area.text
				tmp_file.open_write
				if not to_write.empty then
					to_write.prune_all ('%R')
					if text_mode.is_equal ("UNIX") then
						tmp_file.putstring (to_write)
						if to_write.item (to_write.count) /= '%N' then 
							-- Add a carriage return like `vi' if there's none at the end 
							tmp_file.new_line
						end
					else
						to_write.replace_substring_all ("%N", "%R%N")
						tmp_file.putstring (to_write)
					end
				end
				tmp_file.close

				if create_backup then
						-- We need to copy the backup file to the original file and then
						-- delete the backup file
					new_file.delete
					tmp_file.change_name (file_name)
				end
				tool.set_last_saving_date (tmp_file.date)

				if tool.last_format = tool.format_list.text_format then
					--| Only set the file name if it is an Ace file
					--| (and not the show_clusters file name).
					Eiffel_ace.set_file_name (file_name)
				end
				tool.text_area.disable_clicking
				if tool.stone /= Void and then parse_ace_after_saving then
					tool.parse_file
				end
				tool.update_save_symbol
			end
		end

end -- class EB_SAVE_SYSTEM_CMD
