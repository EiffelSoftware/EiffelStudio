indexing

	description:
		"Dialog to display options for generation of %
		%internal data structures."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERATION_OPTIONS_DLG

inherit
	EV_DIALOG

	NEW_EB_CONSTANTS

	EIFFEL_ENV

	EV_COMMAND

--	WINDOW_ATTRIBUTES

creation
	make_default

feature {NONE} -- Initialization

	make_default (a_caller: EB_GENERATE_PROFILE_INFO_CMD) is
			-- Create dialog with `a_parent' as `parent'.
			-- Popup Current and record `a_caller'
			-- to be called on the event of callbacks
		do
			make (a_caller.tool.parent_window)
			set_title (Interface_names.t_Generation_options)
			caller := a_caller
			build_widgets
--			set_composite_attributes (Current)
			show
		end

feature -- Access

	profinfo_file: STRING is
			-- File to use as input file
		do
			Result := text_field.text
		end

	compile_mode: STRING is
			-- Compile mode for which `profinfo_file'
			-- has been generated.
		do
			if workbench_button.state then
				Result := "workbench"
			else
				Result := "final"
			end
		end

	profiler_type: STRING is
			-- The profiler that's been used to
			-- generate `profinfo_file'.
		do
			if profiler_list.selected then
				Result := profiler_list.selected_item.text
			end
		end

feature {NONE} -- User Interface

	build_widgets is
			-- Setup the interface.
		do
			create text_frame.make_with_text (display_area, Interface_names.l_Input_file)
			create text_field.make_with_text (text_frame, "profinfo")

			create compile_frame.make_with_text (display_area, Interface_names.l_Compile_type)
			create compile_box.make (compile_frame)
			create workbench_button.make_with_text (compile_box, Interface_names.b_Workbench)
			workbench_button.set_state (True)
			create final_button.make_with_text (compile_box, Interface_names.b_Final)

			create profiler_frame.make_with_text (display_area, Interface_names.l_Select_profiler)
			create profiler_list.make (profiler_frame)
--			profiler_list.add_activate_command (Current, click_it)
			fill_profiler_list

			create ok_button.make_with_text (action_area, Interface_names.b_Ok)
			ok_button.add_click_command (Current, ok_it)
			create cancel_button.make_with_text (action_area, Interface_names.b_Cancel)
			cancel_button.add_click_command (Current, cancel_it)

--			set_size (200, 300)
		end


feature {NONE} -- Attributes

	caller: EB_GENERATE_PROFILE_INFO_CMD
			-- Last caller of Current

	compile_box: EV_VERTICAL_BOX
			-- Check box with compile mode sewitches

	compile_frame,
			-- Form for compile modes

	text_frame,
			-- Form for text field

	profiler_frame: EV_FRAME
			-- Form for scrollable list of profilers

	button_form: EV_VERTICAL_BOX
			-- Form for action buttons

	text_field: EV_TEXT_FIELD
			-- Text field for input file

	workbench_button,
			-- Check button for workbench mode

	final_button: EV_RADIO_BUTTON
			-- Check button for final mode

	profiler_list: EV_LIST
			-- List with supported profilers

	ok_button,
			-- Button to start generation

	cancel_button: EV_BUTTON
			-- Button to cancel generation

	last_selected_position: INTEGER
			-- Position (one based) of last selected item in `profiler_list'

feature {NONE} -- Implementation

	fill_profiler_list is
			-- Fill `profiler_list' with profilers
			-- for which configuration files could be found
			-- in "$EIFFEL4/bench/profiler".
		require
			profiler_list_not_void: profiler_list /= Void
		local
			profdir: DIRECTORY
			list_string: EV_LIST_ITEM
--			to_be_selected: INTEGER
--			update: BOOLEAN
		do
			create profdir.make_open_read (profile_path)
			from
--				to_be_selected := 1
--				update := True
				profdir.start
				profdir.readentry
				profdir.readentry
				profdir.readentry
			until
				profdir.lastentry = Void
			loop
				create list_string.make_with_text (profiler_list, profdir.lastentry)
				if profdir.lastentry.is_equal ("eiffel") then
--					update := False
					list_string.set_selected (True)
				end
				profdir.readentry
--				if update then
--					to_be_selected := to_be_selected + 1
--				end
			end
--			if not profiler_list.empty then
--				profiler_list.select_i_th (to_be_selected)
--				last_selected_position := to_be_selected
--			end
		end

feature {NONE} -- Execution arguments

	ok_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	cancel_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

--	click_it: EV_ARGUMENT1 [ANY] is
--		once
--			create Result.make (Void)
--		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute Current.
		do
			if arg = ok_it then
				if profiler_list.selected then
					hide
					caller.build_profile
				end
			destroy
--			elseif arg = click_it then
--				if profiler_list.selected then
--					last_selected_position := profiler_list.selected_position
--				else
--					profiler_list.select_i_th (last_selected_position)
--				end
			end
		end

end -- class EB_GENERATION_OPTIONS_DLG
