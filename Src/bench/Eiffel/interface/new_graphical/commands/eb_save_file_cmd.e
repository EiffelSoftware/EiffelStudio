indexing
	description: "Command to save a file."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_FILE_CMD

inherit
	EB_GENERAL_DATA
	NEW_EB_CONSTANTS
	SYSTEM_CONSTANTS
	EB_EDITOR_COMMAND
		redefine
--			license_checked,
			tool
		end

creation
	make
	
feature -- Properties

--	unmodified_pixmap: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Save 
--		end
--
--	modified_pixmap: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Modified
--		end

	tool: EB_EDITOR
--	tool: EB_CLASS_TOOL
			-- The tool

feature {NONE} -- Implementation
feature -- Execution

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Save a file with the chosen name.
		local   
			new_file, tmp_file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING
			aok, create_backup: BOOLEAN
			save_as_cmd: EB_SAVE_FILE_AS_CMD
			tmp_name: STRING
			wd: EV_WARNING_DIALOG
		do
			if tool.file_name = Void then
				create save_as_cmd.make (tool)
				save_as_cmd.execute (Void, Void)
			else
				create new_file.make (tool.file_name)
				aok := True
				if (new_file.exists) and then (not new_file.is_plain) then
					aok := False
					create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_a_plain_file (new_file.name))

				elseif new_file.exists and then (not new_file.is_writable) then
					aok := False
					create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_writable (new_file.name))

				elseif (not new_file.exists) and then (not new_file.is_creatable) then
					aok := False
					create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_creatable (new_file.name))
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
					to_write := tool.text_window.text
					tmp_file.open_write
					if not to_write.empty then
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
					end
					tmp_file.close

					if create_backup then
							-- We need to copy the backup file to the original file and then
							-- delete the backup file
						new_file.delete
						tmp_file.change_name (tool.file_name)
					end

					tool.text_window.disable_clicking
					if tool.stone /= Void then
-- and then tool.resources.parse_class_after_saving.actual_value then
						if tool.parse_file then
--							tool.update
						end
					end
					tool.update_save_symbol
				end
			end
		end

 
	
feature {NONE} -- Attributes

	license_checked: BOOLEAN is True
			-- Is the license checked?

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Save
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Save
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Save
--		end

end -- class EB_SAVE_FILE_CMD
