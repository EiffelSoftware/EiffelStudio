indexing
	description: "Command to open a file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_FILE_CMD

inherit
	SHARED_EIFFEL_PROJECT
	EB_EDITOR_COMMAND
		redefine
			tool
		end
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS

creation

	make
	
feature -- Callbacks

--	save_changes (argument: ANY) is
--			-- The user has eventually been warned that he will lose his stuff
--		local
--			chooser: NAME_CHOOSER_W
--		do
--			if tool.save_cmd /= Void then
--				tool.save_cmd.execute (Void, Void)
--			end
--
--			chooser := name_chooser (popup_parent)
--			chooser.set_open_file
--			chooser.call (Current) 
--		end
	
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
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
			qd: EV_QUESTION_DIALOG
			class_i: CLASS_I
			classi_stone: CLASSI_STONE
			classc_stone: CLASSC_STONE
		do
			if argument = Void then
				-- First click on open
				if tool.text_window.changed then
--					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
--						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					create fod.make (tool.parent)
					fod.set_filter (<<"Eiffel Class File (*.e)">>, <<"*.e">>)
					create arg.make (fod)
					fod.add_ok_command (Current, arg)
					fod.show
				end
			else
				fod := argument.first
				create fn.make_from_string (fod.file)
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
							elseif class_i.compiled then
								!! classc_stone.make (class_i.compiled_class)
								tool.process_class (classc_stone)
							else
								!! classi_stone.make (class_i)
								tool.process_classi (classi_stone)
							end
						end
					elseif f.exists and then not f.is_plain then
						create qd.make_default (tool.parent, Interface_names.t_Warning, 
							Warning_messages.w_Not_a_file_retry (fn))
					else
						 create qd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Cannot_read_file_retry (fn))
					end
				else
					 create qd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Not_a_file_retry (fn))
				end
			end
		end

feature {NONE} -- Attributes

	tool: EB_CLASS_TOOL

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
