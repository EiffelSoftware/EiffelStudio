indexing
	description	: "Command to show (and create if necessary) the dynamic library window."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SHOW_DYNAMIC_LIB_WINDOW_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_CONFIRM_SAVE_CALLBACK
		export
			{NONE} all
		end

create
	default_create

feature -- Execution

	execute is
			-- Execute command
		do
			execute_with_dialog (Void)
		end

feature {EB_CHOOSE_DYNAMIC_LIB_DIALOG}-- Callbacks

	load_default is
			-- Used when first open the dynamic_tool. (Create default)
			-- and when we click on the dynamic_lib button, to say, RELOAD (NO).
		local
			fn:FILE_NAME
			f: PLAIN_TEXT_FILE
			fc: PLAIN_TEXT_FILE
			retried: BOOLEAN
			wd: EV_WARNING_DIALOG
		do
			if not retried then
				if Eiffel_dynamic_lib /= Void then
					if Eiffel_dynamic_lib.modified then
						create fc.make_open_read (eiffel_dynamic_lib.file_name)
						if eiffel_dynamic_lib.parse_exports_from_file (fc) then
							dynamic_lib_window.refresh
						end
						fc.close
					end
				else
						-- First creation of the dynamic library
					create fn.make_from_string (Eiffel_project.name)
					fn.set_file_name (eiffel_system.name)
					fn.add_extension ("def")
					create f.make_create_read_write (fn)
					if 
						f.exists and then 
						f.is_readable and then 
						f.is_plain
					then
						f.close
						Eiffel_project.create_dynamic_lib
						Eiffel_dynamic_lib.set_file_name (fn)
						execute
					else
						create wd.make_with_text (Warning_messages.w_Cannot_create_file (fn))
						wd.show_modal_to_window (Window_manager.last_focused_development_window)
					end
				end
			else
				if fn /= Void and Eiffel_dynamic_lib = Void then
					create wd.make_with_text (Warning_messages.w_Cannot_create_file (fn))
					wd.show_modal_to_window (Window_manager.last_focused_development_window)
				elseif Eiffel_dynamic_lib = Void then
					create wd.make_with_text (Warning_messages.w_Unknown_error)
					wd.show_modal_to_window (Window_manager.last_focused_development_window)
				else
					create wd.make_with_text (Warning_messages.w_Cannot_read_file (eiffel_dynamic_lib.file_name))
					wd.show_modal_to_window (Window_manager.last_focused_development_window)
				end
			end
		rescue
			retried := True
			retry
		end

	load_chosen is
			-- Used when first open the dynamic_tool.
		local
			fod: EV_FILE_OPEN_DIALOG
		do
			create fod
--			fod.set_filter (<<"Dynamic Library Definition File (*.def)">>, <<"*.def">>)
			fod.ok_actions.extend (~execute_with_dialog (fod))
			fod.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
			-- and when we click on the dynamic_lib button, to say, SAVE (OK).
		local
			fc: PLAIN_TEXT_FILE
		do
			create fc.make_open_read (eiffel_dynamic_lib.file_name)
			if eiffel_dynamic_lib.parse_exports_from_file(fc) then
				dynamic_lib_window.refresh
			end
			fc.close
			eiffel_dynamic_lib.set_modified (false)
		end

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
--			if tool = Project_window then
--				open_dynamic_lib_window (st)
--			else
--				tool.receive (st)
--			end
		end

	process_classi (st: CLASSI_STONE) is
		do
--			if tool = Project_window then
--				open_dynamic_lib_window (st)
--			else
--				tool.receive (st)
--			end
		end

	process_feature (st: FEATURE_STONE) is
		do
--			if dynamic_lib_window_is_valid then
--				open_dynamic_lib_window (st)
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

	execute_with_dialog (argument: EV_FILE_OPEN_DIALOG) is
		local
			fn: STRING
			f: PLAIN_TEXT_FILE
			dl_win: EB_DYNAMIC_LIB_WINDOW
			cd: EV_CONFIRMATION_DIALOG
			dialog: EB_CHOOSE_DYNAMIC_LIB_DIALOG			
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if Eiffel_project.initialized and then Eiffel_project.system /= Void then
				if Eiffel_dynamic_lib = Void then
						-- No dynamic lib has been created, we request the creation
						-- of one.
					if argument = Void then
							-- Display the "Specify Dynamic Library" dialog
						create dialog.make_default (Current, Interface_names.t_Warning,
							Interface_names.t_Specify_dynamic_lib)
					else
						fn := argument.file_name
						if not fn.is_empty then
							create f.make (fn)
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
									-- First creation of the dynamic library
								Eiffel_project.create_dynamic_lib
								Eiffel_dynamic_lib.set_file_name (fn)
								execute_with_dialog (Void)
							elseif f.exists and then not f.is_plain then
								create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
								cd.button ("Ok").select_actions.extend (~execute_with_dialog (Void))
								cd.show_modal_to_window (window_manager.last_focused_development_window.window)
							else
								create cd.make_with_text (Warning_messages.w_Cannot_read_file_retry (fn))
								cd.button ("Ok").select_actions.extend (~execute_with_dialog (Void))
								cd.show_modal_to_window (window_manager.last_focused_development_window.window)
							end
						else
							create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
							cd.button ("Ok").select_actions.extend (~execute_with_dialog (Void))
							cd.show_modal_to_window (window_manager.last_focused_development_window.window)
						end
					end
				else
					if not dynamic_lib_window_is_valid then
						create dl_win.make
						set_dynamic_lib_window (dl_win)
						dynamic_lib_window.show_file_content (create {FILE_NAME}.make_from_string (Eiffel_dynamic_lib.file_name))
					elseif Eiffel_dynamic_lib.modified then
						create csd.make_and_launch (dynamic_lib_window, Current)
					else
						process
					end
					dynamic_lib_window.show
						-- should be `raise'
				end 
			end
		end

feature {NONE} -- Implementation

	open_dynamic_lib_window (a_stone: STONE) is
			-- open a dynamic lib tool and process `a_stone'.
		require
			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		do
			dynamic_lib_window.show
			dynamic_lib_window.set_stone (a_stone)
		end

end -- class EB_SHOW_DYNAMIC_LIB_WINDOW_COMMAND
