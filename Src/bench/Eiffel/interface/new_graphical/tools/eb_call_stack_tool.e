indexing
	description: "Tool that displays the call stack during a debugging session."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CALL_STACK_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap
		end

	EB_RECYCLABLE

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end
	
	EB_DEBUG_TOOL_DATA
		export
			{NONE} all
		end
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		local
			development_window: EB_DEVELOPMENT_WINDOW
			box: EV_VERTICAL_BOX
			box2: EV_VERTICAL_BOX
		do
			development_window ?= manager
			create stack_list
			stack_list.disable_multiple_selection
			create box
			create box2
			box2.set_padding (3)
			create stop_cause
			stop_cause.align_text_left
			box2.extend (stop_cause)
			box2.disable_item_expand (stop_cause)
			create exception
--			exception.align_text_left
			box2.extend (exception)
			box2.disable_item_expand (exception)
			box.extend (box2)
			box.disable_item_expand (box2)
			if Application.status /= Void then
				display_stop_cause
			end
			exception.remove_text
				-- We set a minimum width to prevent the label from resizing the call stack.
			exception.set_minimum_width (40)
			exception.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			exception.disable_edit
			box.extend (stack_list)
			stack_list.set_column_titles (
				  <<Interface_names.t_Feature,
					Interface_names.t_Dynamic_type,
					Interface_names.t_Static_type>>)
--| FIXME XR: Use preferences to store/restore column widths
			stack_list.set_column_widths (<<100, 100, 100>>)
			stack_list.drop_actions.extend (~on_element_drop)
			stack_list.key_press_actions.extend (~key_pressed)
			update_agent := ~real_update
			widget := box
		end

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		local
			tb: EV_TOOL_BAR
		do
			create tb
			create save_call_stack_cmd.make
			save_call_stack_cmd.set_mini_pixmaps (Pixmaps.Icon_save_call_stack)
			save_call_stack_cmd.set_tooltip (Interface_names.e_Save_call_stack)
			save_call_stack_cmd.add_agent (~save_call_stack)
			tb.extend (save_call_stack_cmd.new_mini_toolbar_item)
			create set_stack_depth_cmd.make
			set_stack_depth_cmd.set_mini_pixmaps (Pixmaps.Icon_set_stack_depth)
			set_stack_depth_cmd.set_tooltip (Interface_names.e_Set_stack_depth)
			set_stack_depth_cmd.add_agent (~set_stack_depth)
			set_stack_depth_cmd.enable_sensitive
			tb.extend (set_stack_depth_cmd.new_mini_toolbar_item)
			create explorer_bar_item.make_with_mini_toolbar (explorer_bar, widget, title, False, tb)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
			explorer_bar.repack_widgets
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget representing Current.

	stop_cause: EV_LABEL
			-- Why did the execution stop? (encountered breakpoint, raised exception,...)

	exception: EV_TEXT_FIELD
			-- Exception application has encountered.

	title: STRING is 
			-- Title of the tool.
		do
			Result := Interface_names.t_Call_stack_tool
		end

	stack_list: EV_MULTI_COLUMN_LIST
			-- Graphical representation of the execution stack.

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Call_stack_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_call_stack
		end

feature -- Status setting

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			st: CALL_STACK_STONE
			new_level: INTEGER
			count: INTEGER
		do
			st ?= a_stone
			if st /= Void then
				new_level := st.level_number
				count := stack_list.count  
				if arrowed_level >= 1 and then count >= arrowed_level then
					(stack_list @ (arrowed_level)).remove_pixmap
				end
				if new_level >= 1 and then count >= new_level then
					(stack_list @ (new_level)).set_pixmap (Pixmaps.Icon_green_arrow)
					arrowed_level := new_level
				end
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
		end

	update is
			-- Refresh `Current's display.
		do
			stack_list.wipe_out
			if Application.status /= Void then
				display_stop_cause
			end
			ev_application.idle_actions.prune_all (update_agent)
			ev_application.idle_actions.extend (update_agent)
		end

	change_manager (a_manager: EB_TOOL_MANAGER; an_explorer_bar: like explorer_bar) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
			build_explorer_bar
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			explorer_bar_item.recycle
		end

feature {NONE} -- Implementation

	arrowed_level: INTEGER
			-- Line number in the stack that has an arrow displayed.

	save_call_stack_cmd: EB_STANDARD_CMD
			-- Command that saves the call stack to a file.

	set_stack_depth_cmd: EB_STANDARD_CMD
			-- Command that alters the displayed depth of the call stack.

	update_agent: PROCEDURE [ANY, TUPLE []]
			-- Agent that is put in the idle_actions to update the call stack after a while.

	real_update is
			-- Display current execution status.
		local
			i: INTEGER
			stack: EIFFEL_CALL_STACK
			tmp_list: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			ev_application.idle_actions.prune_all (update_agent)			
			if Application.status /= Void then
				display_stop_cause
				stack_list.wipe_out
				stack := Application.status.where
				if
					Application.is_stopped and then
					stack /= Void
				then
					create tmp_list.make (stack.count)
					save_call_stack_cmd.enable_sensitive
					from
						stack.start
						i := 1
					until
						stack.after
					loop
						tmp_list.extend (element_to_row (stack.item, i))
						i := i + 1
						stack.forth
					end
					stack_list.append (tmp_list)
				else
					save_call_stack_cmd.disable_sensitive
				end
			end
		end

	display_stop_cause is
			-- Fill in the `stop_cause' label with a message describing the application status.
		local
			m: STRING
		do
			if not Application.status.is_stopped then
				stop_cause.set_text (Interface_names.l_System_running)
				exception.remove_text
				exception.remove_tooltip
			else -- Application is stopped.
				create m.make (100)
				inspect Application.status.reason
				when Pg_step then
					stop_cause.set_text (Interface_names.l_Stepped)
					m.append (Interface_names.l_Stepped)
				when Pg_break then
					stop_cause.set_text (Interface_names.l_Stop_point_reached)
					m.append (Interface_names.l_Stop_point_reached)
				when Pg_interrupt then
					stop_cause.set_text (Interface_names.l_Execution_interrupted)
					m.append (Interface_names.l_Execution_interrupted)
				when Pg_overflow then
					stop_cause.set_text (Interface_names.l_Possible_overflow)
					m.append (Interface_names.l_Possible_overflow)
				when Pg_raise then
					stop_cause.set_text (Interface_names.l_Explicit_exception_pending)
					m.append (Interface_names.l_Explicit_exception_pending)
					m.append (": ")
					m.append (exception_text)
					display_exception
				when Pg_viol then
					stop_cause.set_text (Interface_names.l_Implicit_exception_pending)
					m.append (Interface_names.l_Implicit_exception_pending)
					m.append (": ")
					m.append (exception_text)
					display_exception
				when Pg_new_breakpoint then
					stop_cause.set_text (Interface_names.l_New_breakpoint)
					m.append (Interface_names.l_New_breakpoint)
				else
					stop_cause.set_text (Interface_names.l_Unknown_status)
					m.append (Interface_names.l_Unknown_status)
				end
				Debugger_manager.debugging_window.status_bar.display_message (m)
			end
		end

	display_exception is
			-- Fill in the `exception' label with a text describing the exception, if any.
		local
			m: STRING
		do
			m := exception_text
			exception.set_text (m)
			exception.set_tooltip (m)
		end

	exception_text: STRING is
			-- Text corresponding to the current exception.
		local
			e: EXCEPTIONS
			s: STRING
		do
			create Result.make (100)
			Result.append ("Code: ")
			Result.append (Application.status.exception_code.out)
			Result.append (" (")
			!!e
			s := e.meaning (Application.status.exception_code)
			if s = Void then
				s := "Undefined"
			end
			Result.append (s)
			Result.append (")")
			Result.append (" Tag: ")
			Result.append (Application.status.exception_tag)
		ensure
			one_line: Result /= Void and then (not Result.has ('%R') and not Result.has ('%N'))
		end

	on_element_drop (st: CALL_STACK_STONE) is
			-- Change stack level to the one described by `st'.
		do
			debugger_manager.launch_stone (st)
		end

	element_to_row (elem: CALL_STACK_ELEMENT; level: INTEGER): EV_MULTI_COLUMN_LIST_ROW is
			-- Display information about associated routine.
		local
			c: CLASS_C
			dc, oc: CLASS_C
		do
			create Result
			c := elem.dynamic_class
				-- Print object address
			if c /= Void then
				if elem.is_melted then
					Result.extend (elem.routine_name + "*")
				else
					Result.extend (elem.routine_name)
				end
				dc := elem.dynamic_class
				Result.extend (dc.name_in_upper)
--				Result.extend (elem.break_index.out)
--				Result.extend (elem.object_address)
				oc := elem.origin_class
				if not oc.is_equal (dc) then
					Result.extend (oc.name_in_upper)
				else
					Result.extend (Interface_names.l_Same_class_name)
				end
				Result.set_pebble_function (~pebble_from_x_y (?, ?, level))
				Result.set_accept_cursor (Cursors.cur_Setstop)
				Result.set_data (level)
				Result.pointer_button_press_actions.extend (~select_element(?,?,?,?,?,?,?,?,level))
				if level = Application.current_execution_stack_number then
					Result.set_pixmap (Pixmaps.Icon_green_arrow)
					arrowed_level := level
				end
			else
--				io.putstring ("Void dclass")
			end
		end

	select_element (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; level: INTEGER) is
			-- Set `a_stone' in the development window.
		require
			valid_level: level > 0 and level <= stack_list.count
		local
			st: CALL_STACK_STONE
		do
			if a_button = 1 then
				create st.make (level)
				if st.is_valid then
					debugger_manager.launch_stone (st)
				end
			end
		end

	key_pressed (a_key: EV_KEY) is
			-- If `a_key' is enter, set the selected stack element as the new stone.
		local
			level: INTEGER_REF
			conv_st: CALL_STACK_STONE
		do
			if a_key.code = Key_enter then
				if stack_list.selected_item /= Void then
					level ?= stack_list.selected_item.data
					create conv_st.make (level.item)
					debugger_manager.launch_stone (conv_st)
				end
			end
		end

	pebble_from_x_y (x, y, line: INTEGER): CALL_STACK_STONE is
			-- Returns the call_stack_stone of line `line'.
		require
			valid_line: line > 0 and line <= stack_list.count
		local
			elem: CALL_STACK_ELEMENT
		do
			elem := application.status.where.i_th (line)
			if
				elem /= Void and then
				elem.dynamic_class /= Void and then
				elem.dynamic_class.has_feature_table
			then
				create Result.make (line)
			end
		end

	save_call_stack is
			-- Saves the current call stack representation in a file.
		local
			fd: EV_FILE_SAVE_DIALOG
			standard_path: DIRECTORY_NAME
			f: RAW_FILE
			fn: FILE_NAME
			last_path: STRING
			i: INTEGER
		do
				--| Get last path from the preferences.
			last_path := last_saved_stack_path
			if last_path = Void then
					--| The first time, start in the project directory.
				create standard_path.make
				standard_path.extend (Eiffel_project.project_directory.name)
			else
				create standard_path.make
				standard_path.extend (last_path)
			end
			create fd
			fd.set_filter ("*.txt")
			fd.set_start_directory (standard_path)
				--| We try to find a file_name that does not exist.
			create fn.make
			fn.set_directory (standard_path)
			fn.set_file_name (Interface_names.default_stack_file_name)
			fn.add_extension ("txt")
			create f.make (fn)
			from
				i := 1
			until
				not f.exists
			loop
				create fn.make
				fn.set_directory (standard_path)
				fn.set_file_name (Interface_names.default_stack_file_name + i.out)
				fn.add_extension ("txt")
				create f.make (fn)
				i := i + 1
			end
				--| OK, now `fn' represents a file that does not exist.
			fd.set_file_name (fn)
			fd.save_actions.extend (~save_call_stack_to_file (fd))
			fd.show_modal_to_window (Debugger_manager.debugging_window.window)
		end

	save_call_stack_to_file (fd: EV_FILE_DIALOG) is
			-- Actually saves the call stack.
		require
			valid_dialog: fd /= Void
		local
			fn: PLAIN_TEXT_FILE
			retried: BOOLEAN
			wd: EV_WARNING_DIALOG
			stt: STRUCTURED_TEXT
		do
			if not retried then
					--| We create a file (or open it).
				create fn.make_create_read_write (fd.file_name)
				create stt.make
					--| We generate the call stack.
				Application.status.where.display_stack (stt)
					--| We put it in the file.
				fn.put_string (stt.image)
				fn.close
					--| Save the path to the preferences.
				set_last_saved_stack_path (fd.file_path)
			else
					-- The file name was probably incorrect (not creatable).
				create wd.make_with_text (Warning_messages.w_Not_creatable (fd.file_name))
				wd.show_modal_to_window (Debugger_manager.debugging_window.window)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: set stack depth command

	set_stack_depth is
			-- Display a dialog that lets the user change the maximum depth of the call stack.
		local
			rb2: EV_RADIO_BUTTON
			l: EV_LABEL
			okb, cancelb: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
				-- Create widgets.
			create dialog
			create show_all_radio.make_with_text (Interface_names.l_show_all_call_stack)
			create rb2.make_with_text (Interface_names.l_Show_only_n_elements)
			create l.make_with_text (Interface_names.l_Elements)
			create set_as_default.make_with_text (Interface_names.l_Set_as_default)
			create element_nb.make_with_value_range (1 |..| 500)
			create okb.make_with_text (Interface_names.b_Ok)
			create cancelb.make_with_text (Interface_names.b_Cancel)
			
				-- Set widget properties.
			dialog.set_title (Interface_names.t_Set_stack_depth)
			dialog.disable_user_resize
			Layout_constants.set_default_size_for_button (okb)
			Layout_constants.set_default_size_for_button (cancelb)
			if Debugger_manager.maximum_stack_depth > 500 then
				element_nb.set_value (500)
			elseif Debugger_manager.maximum_stack_depth = -1 then
				element_nb.set_value (50)
			else
				element_nb.set_value (Debugger_manager.maximum_stack_depth)
			end
			
				-- Organize widgets.
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.extend (show_all_radio)
			vb.extend (rb2)
			rb2.enable_select
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (element_nb)
			hb.disable_item_expand (element_nb)
			hb.extend (l)
			hb.disable_item_expand (l)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.extend (set_as_default)
			
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			vb.extend (hb)
			
			dialog.extend (vb)

				-- Set up actions.
			cancelb.select_actions.extend (~close_dialog)
			okb.select_actions.extend (~accept_dialog)
			show_all_radio.select_actions.extend (element_nb~disable_sensitive)
			rb2.select_actions.extend (element_nb~enable_sensitive)
			dialog.set_default_push_button (okb)
			dialog.set_default_cancel_button (cancelb)
			dialog.show_actions.extend (element_nb~set_focus)
			
			dialog.show_modal_to_window (Debugger_manager.debugging_window.window)
		end

	set_as_default: EV_CHECK_BUTTON
			-- Button that decides whether the chosen stack depth should be saved in the preferences.

	element_nb: EV_SPIN_BUTTON
			-- Spin button that indicates how many stack elements should be displayed.

	dialog: EV_DIALOG
			-- Dialog that lets the user choose how many stack elements he wishes to see.

	show_all_radio: EV_RADIO_BUTTON
			-- Radio button that indicates whether all stack elements should be displayed.

	close_dialog is
			-- Close `dialog' without doing anything.
		do
			dialog.destroy
			dialog := Void
			element_nb := Void
			set_as_default := Void
			show_all_radio := Void
		end

	accept_dialog is
			-- Close `dialog' without doing anything.
		local
			nb: INTEGER
		do
			if show_all_radio.is_selected then
				nb := -1
			else
				nb := element_nb.value
			end
			if set_as_default.is_selected then
				set_max_stack_depth (nb)
			end
			close_dialog
			debugger_manager.set_maximum_stack_depth (nb)
		end

end -- class EB_CALL_STACK_TOOL
