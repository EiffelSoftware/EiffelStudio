indexing
	description: "Command to save a file under a different name."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_FILE_AS_CMD

inherit
	EB_EDITOR_COMMAND
--		redefine
--			license_checked
--		end
	SYSTEM_CONSTANTS

	NEW_EB_CONSTANTS

creation

	make
	
feature -- Callbacks

	save_it (fn: STRING) is
			-- Save a file with a chosen name.
		local
			new_file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			to_write: STRING
			aok: BOOLEAN
			temp: STRING
			wd: EV_WARNING_DIALOG
		do
			if not fn.empty then
				create new_file.make (fn)
				aok := True
				if (new_file.exists) and then (not new_file.is_plain) then
					aok := False
					create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_a_plain_file (fn))
				elseif 
					(new_file.exists and then new_file.is_writable)
				then
					aok := False
--					warner (popup_parent).custom_call (Current, 
--						Warning_messages.w_File_exists (fn), 
--						Interface_names.b_Overwrite, Void, Interface_names.b_Cancel)
				elseif new_file.exists and then (not new_file.is_writable) then
					aok := False
					create wd.make_default
						(tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_writable (fn))
				elseif not new_file.is_creatable then
					aok := False
					create wd.make_default
						(tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_creatable (fn))
				end
			else
				aok := False
				create wd.make_default
					(tool.parent, Interface_names.t_Warning, Warning_messages.w_Not_a_plain_file (fn))
			end

			if aok then
				to_write := tool.text_window.text
				new_file.open_write
				if not to_write.empty then
					to_write.prune_all ('%R')
					if general_resources.text_mode.value.is_equal ("UNIX") then
						new_file.putstring (to_write)
						if to_write.item (to_write.count) /= '%N' then 
							-- Add a carriage return like `vi' if there's none at the end 
							new_file.new_line
						end
					else
						to_write.replace_substring_all ("%N", "%R%N")
						new_file.putstring (to_write)
					end
				end
				new_file.close
				if tool.text_window.changed then 
					tool.text_window.disable_clicking
				end
				if tool.file_name = Void then
					set_tool_new_name (new_file.name)
				end
			end
		end

	set_tool_new_name (new_name: STRING) is
		do
			tool.set_file_name (new_name)
			tool.set_title (new_name)
		end
			
feature -- Properties

--	symbol: PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Save_as 
--		end

feature {EB_SAVE_FILE_CMD} -- Implementation

	execute (argument: EV_ARGUMENT1 [EV_FILE_SAVE_DIALOG]; data: EV_EVENT_DATA) is
			-- Save a file with the chosen name.
		local
			chooser: NAME_CHOOSER_W
			fsd: EV_FILE_SAVE_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_SAVE_DIALOG]
		do
			if argument = Void then
				create fsd.make (tool.parent)
				create arg.make (fsd)
				fsd.add_ok_command (Current, arg)
				fsd.show
			else
				fsd := argument.first
				save_it (fsd.file)
			end
		end

feature {NONE}

	license_checked: BOOLEAN is True
			-- Is the license checked?

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Save_as
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Save_as
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

end -- class EB_SAVE_FILE_AS_CMD
