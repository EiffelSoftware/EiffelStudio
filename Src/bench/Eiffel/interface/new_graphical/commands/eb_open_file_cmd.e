indexing
	description: "Command to open a file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_FILE_CMD

inherit
	SHARED_EIFFEL_PROJECT
	EB_EDITOR_COMMAND
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS

	EB_CONFIRM_SAVE_CALLBACK

creation
	make
	
feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
		local
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
		do
			create fod.make (tool.parent)
--			fod.set_filter (<<"Eiffel Class File (*.e)">>, <<"*.e">>)
			create arg.make (fod)
			fod.add_ok_command (Current, arg)
			fod.show
		end
	
feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Open
--		end

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
			-- Open a file.
		local
			fn: FILE_NAME
			f: PLAIN_TEXT_FILE
			temp: STRING	
			wd: EV_WARNING_DIALOG
			csd: EB_CONFIRM_SAVE_DIALOG
			class_i: CLASS_I
			classi_stone: CLASSI_STONE
			classc_stone: CLASSC_STONE
		do
			if argument = Void then
				-- First click on open
				if tool.text_area.changed then
					create csd.make_and_launch (tool, Current)
				else
					process
				end
			else
				create fn.make_from_string (argument.first.file)
				if not fn.empty then
					create f.make (fn)
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						if not project_tool.initialized then
							tool.show_file (f)
						else
							class_i := Eiffel_universe.class_with_file_name (fn)
							if class_i = Void then
								tool.show_file (f)
	--						elseif class_i.compiled then
	--							create classc_stone.make (class_i.compiled_class)
	--							tool.process_class (classc_stone)
	--						else
	--							create classi_stone.make (class_i)
	--							tool.process_classi (classi_stone)
	--|FIXME
	--| Christophe, 18 oct 1999
	--| `process_class' not defined in an EB_EDIT_TOOL.
	--| has to for drag and drop.
							end
						end
					elseif f.exists and then not f.is_plain then
						create wd.make_default (tool.parent, Interface_names.t_Warning, 
							Warning_messages.w_Not_a_file_retry (fn))
						wd.show_ok_cancel_buttons
						wd.add_ok_command (Current, Void)
						wd.show
					else
						create wd.make_default (tool.parent, Interface_names.t_Warning,
							Warning_messages.w_Cannot_read_file_retry (fn))
						wd.show_ok_cancel_buttons
						wd.add_ok_command (Current, Void)
						wd.show
					end
				else
					 create wd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Not_a_file_retry (fn))
					wd.show_ok_cancel_buttons
					wd.add_ok_command (Current, Void)
					wd.show
				end
			end
		end

feature {NONE} -- Attributes

--	tool: EB_CLASS_TOOL

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Open
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Open
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Open
--		end

end -- class EB_OPEN_FILE_CMD
