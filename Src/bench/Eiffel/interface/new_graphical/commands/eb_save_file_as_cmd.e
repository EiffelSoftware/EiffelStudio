indexing
	description: "Command to save a file under a different name."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_FILE_AS_CMD

inherit
	EB_TEXT_TOOL_CMD
--		redefine
--			license_checked
--		end
	SYSTEM_CONSTANTS
	EB_GENERAL_DATA
--	NEW_EB_CONSTANTS

	EB_FILE_OPENER_CALLBACK

creation

	make
	
feature -- Callbacks

	save_it (fn: STRING) is
			-- Save a file with a chosen name.
		local
			fo: EB_FILE_OPENER
		do
			create fo.make_default (tool.parent, Current, fn)
		end


feature {EB_FILE_OPENER} -- Callbacks

	save_file (new_file: RAW_FILE) is
		local
			to_write: STRING
		do
			to_write := tool.text_area.text
			new_file.open_write
			if not to_write.empty then
				to_write.prune_all ('%R')
				if text_mode.is_equal ("UNIX") then
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
			if tool.text_area.changed then 
				tool.text_area.disable_clicking
			end
			set_tool_new_name (new_file.name)
		end

	set_tool_new_name (new_name: STRING) is
			--| FIXME
			--| Christophe, 15 oct 1999
			--| this feature should be moved in the EB_TOOL hierarchy
		local
			ed: EB_EDIT_TOOL
		do
			ed ?= tool
			if ed /= Void then
				ed.set_file_name (new_name)
			end
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
