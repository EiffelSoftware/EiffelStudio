indexing
	description:
		"Command to show (and create if necessary) the dynamic library tool.%
		% Could maybe be merged with EB_CHOOSE_ACE_DIALOG"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_DYNAMIC_LIB_TOOL

inherit
	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

--	DEFAULT_HOLE_COMMAND
--		redefine
--			symbol, full_symbol, icon_symbol,
--			name, stone_type, process_class, process_feature,
--			compatible, process_classi, receive, menu_name, accelerator,
--			work
--		end
	EV_COMMAND
	
	EB_SHARED_INTERFACE_TOOLS

	NEW_EB_CONSTANTS

	EB_CONFIRM_SAVE_CALLBACK

creation
	make

feature {NONE} -- Initialization

	make (w: EV_WINDOW) is
		do
			associated_window := w
		end

feature {EB_CHOOSE_DYNAMIC_LIB_DIALOG}-- Callbacks

	associated_window: EV_WINDOW

	load_default is
			-- Used when first open the dynamic_tool. (Create default)
			-- and when we click on the dynamic_lib button, to say, RELOAD (NO).
		local
			fn:STRING
			f: PLAIN_TEXT_FILE
			fc: PLAIN_TEXT_FILE
		do
			if Eiffel_dynamic_lib /= Void  and then Eiffel_dynamic_lib.modified then
				create fc.make_open_read (eiffel_dynamic_lib.file_name)
				if eiffel_dynamic_lib.parse_exports_from_file (fc) then
					dynamic_lib_tool.synchronize
				end
				fc.close
				eiffel_dynamic_lib.set_modified (false)
			else
					-- First creation of the dynamic library
				Eiffel_project.create_dynamic_lib
				fn := clone (eiffel_system.name)
				fn.append_string (".def")
				create f.make_create_read_write (fn)
				if 
					f.exists and then 
					f.is_readable and then 
					f.is_plain
				then
					f.close
					Eiffel_dynamic_lib.set_file_name (fn)
					execute (Void, Void)
				else
					io.put_string ("Impossible to create the default file%N")
				end
			end
		end

	load_chosen is
			-- Used when first open the dynamic_tool.
		local
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
		do
			create fod.make (associated_window)
			fod.set_filter (<<"Dynamic Library Definition File (*.def)">>, <<"*.def">>)
			create arg.make (fod)
			fod.add_ok_command (Current, arg)
			fod.show
		end

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
			-- and when we click on the dynamic_lib button, to say, SAVE (OK).
		local
			fc: PLAIN_TEXT_FILE
		do
			create fc.make_open_read (eiffel_dynamic_lib.file_name)
			if eiffel_dynamic_lib.parse_exports_from_file(fc) then
				dynamic_lib_tool.synchronize
			end
			fc.close
			eiffel_dynamic_lib.set_modified(false)
		end
	

feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Icon for the Dynamic Lib tool
--		once
--			Result := Pixmaps.bm_Dynamic_lib
--		end

--	full_symbol: EV_PIXMAP is
--			-- Icon for the Dynamic Lib tool
--		once
--			Result := Pixmaps.bm_Dynamic_lib_dot
--		end

--	icon_symbol: EV_PIXMAP is
--			-- Icon for the Dynamic Lib tool
--		once
--			Result := Pixmaps.bm_Dynamic_lib_icon
--		end

--	name: STRING is
--		do
--			Result := Interface_names.s_Dynamic_lib_stone
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_New_dynamic_lib
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

--	stone_type: INTEGER is
--		do
--			Result := Dynamic_lib_type
--		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
--			Result := dropped /= Void and then
--				((dropped.stone_type = Dynamic_lib_type) or
--				else (dropped.stone_type = Class_type) or
--				else (dropped.stone_type = Routine_type))
--			Result := True
		end

feature -- Update

	-- Actually we have two types of class holes. One type is
	-- displayed on the project window and the other type is
	-- used within the class and feature tool.
	-- When we drag a feature stone into the class hole of the project tool,
	-- we should bring up a class tool and highlight the feature.
	-- That's the intelligent stuff.

	process_class (st: CLASSC_STONE) is
		do
--			if tool = Project_tool then
--				open_dynamic_lib_tool (st)
--			else
--				tool.receive (st)
--			end
		end

	process_classi (st: CLASSI_STONE) is
		do
--			if tool = Project_tool then
--				open_dynamic_lib_tool (st)
--			else
--				tool.receive (st)
--			end
		end

	process_feature (st: FEATURE_STONE) is
		do
--			if dynamic_lib_tool_is_valid then
--				open_dynamic_lib_tool (st)
--			else
--				execute (Void, Void)
--			end
		end

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
--			if a_stone.is_valid and then compatible (a_stone) then
--				a_stone.process (Current)
--			end
		end

feature {NONE} -- Execution

	execute (argument: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
		local
			fn: STRING
			f: PLAIN_TEXT_FILE
			dl_win: EB_DYNAMIC_LIB_WINDOW
			wd: EV_WARNING_DIALOG
			dialog: EB_CHOOSE_DYNAMIC_LIB_DIALOG			
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if Project_tool.initialized and then Eiffel_project.system /= Void then
				if Eiffel_dynamic_lib = Void then
						-- No dynamic lib has been created, we request the creation
						-- of one.
					if argument = Void then
							-- Display the "Specify Dynamic Library" dialog
						create dialog.make_default (Current, Interface_names.t_Warning,
							Interface_names.t_Specify_dynamic_lib)
					else
						fn := argument.first.file
						if not fn.empty then
							create f.make (fn)
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
									-- First creation of the dynamic library
								Eiffel_project.create_dynamic_lib
								Eiffel_dynamic_lib.set_file_name (fn)
								execute (Void, Void)
							elseif f.exists and then not f.is_plain then
								create wd.make_with_text (associated_window, Interface_names.t_Warning,
									Warning_messages.w_Not_a_file_retry (fn))
								wd.show_ok_cancel_buttons
								wd.add_ok_command (Current, Void)
								wd.show
							else
								create wd.make_with_text (associated_window, Interface_names.t_Warning,
									Warning_messages.w_Cannot_read_file_retry (fn))
								wd.show_ok_cancel_buttons	
								wd.add_ok_command (Current, Void)
								wd.show
							end
						else
							create wd.make_with_text (associated_window, Interface_names.t_Warning,
								Warning_messages.w_Not_a_file_retry (fn))
							wd.show_ok_cancel_buttons	
							wd.add_ok_command (Current, Void)
							wd.show
						end
					end
				else
					if not dynamic_lib_tool_is_valid then
						create dl_win.make_top_level
						set_dynamic_lib_tool (dl_win.tool)
						dynamic_lib_tool.show_file_content (Eiffel_dynamic_lib.file_name)
					elseif Eiffel_dynamic_lib.modified then
						create csd.make_and_launch (dynamic_lib_tool, Current)
					else
						process
					end
					dynamic_lib_tool.show
						-- should be `raise'
				end 
			end
		end

feature {NONE} -- Implementation

	open_dynamic_lib_tool (a_stone: STONE) is
			-- open a dynamic lib tool and process `a_stone'.
		require
			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		do
			dynamic_lib_tool.show
--			dynamic_lib_tool.receive (a_stone)
		end

end -- class EB_SHOW_DYNAMIC_LIB_TOOL
