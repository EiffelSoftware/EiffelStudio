indexing
	description: "Command to save a feature."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_FEATURE_CMD

inherit
	EB_FEATURE_TOOL_DATA
	EB_SAVE_CMD
		redefine
			tool
		end

creation
	make
	
feature -- Properties


	tool: EB_FEATURE_TOOL
			-- The tool

feature {NONE} -- Implementation
feature -- Execution

	execute is
			-- Save a file with the chosen name.
		local   
			new_file, tmp_file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING
			aok, create_backup: BOOLEAN
			tmp_name: STRING
			wd: EV_WARNING_DIALOG
		do
			if tool.file_name = Void then
				create wd.make_with_text ("feature does not exist.")
				wd.show_modal
			else
				create new_file.make (tool.file_name)
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
				tmp_name := clone (tool.file_name)
				tmp_name.append (".swp")
				create tmp_file.make (tmp_name)
				create_backup := not tmp_file.exists and then tmp_file.is_creatable

				if not create_backup then
					tmp_file := new_file
				end

				if aok then
					to_write := new_file_text
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
						tmp_file.change_name (tool.file_name)
					end
					tool.set_last_saving_date (tmp_file.date)

					tool.text_area.disable_clicking
					tool.update_save_symbol
				end
			end
		end

	new_file_text: STRING is
			-- Text to be saved in file
			-- Made by replacing feature text by current text
			-- in the corresponding class file.
		local
			a_file: RAW_FILE
			temp: STRING
		do
			if tool.stone.is_valid then
				create a_file.make (tool.stone.file_name)
				if a_file.exists and then a_file.is_readable then
					a_file.open_read
					a_file.readstream (a_file.count)
					a_file.close
					temp := a_file.laststring
					Result := temp.substring (1, tool.stone.start_position)
					Result.append (feature_text)
					Result.append (temp.substring (tool.stone.end_position + 1, temp.count))
				end
			end
		end

	feature_text: STRING is
		local
			temp: STRING
		do
			temp := tool.text_area.text
			Result := temp.substring (tool.stone.header_size + 1, temp.count -1)
		end

end -- class EB_SAVE_FEATURE_CMD
