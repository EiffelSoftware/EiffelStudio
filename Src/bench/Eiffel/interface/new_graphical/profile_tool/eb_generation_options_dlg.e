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
		rename
			make as old_make
		end

	EB_CONSTANTS

	EIFFEL_ENV

	EV_COMMAND

	WINDOW_ATTRIBUTES

creation
	make

feature {NONE} -- Initialization

	make (a_parent: EV_CONTAINER) is
			-- Create dialog with `a_parent' as `parent'.
		do
			old_make (a_parent)
			set_title (Interface_names.t_Generation_options)
			build_widgets
--			set_composite_attributes (Current)
		end

feature -- Basic operations

	call (a_caller: EB_GENERATE_PROFILE_INFO_CMD) is
			-- Popup Current and record `a_caller'
			-- to be called on the event of callbacks
		do
			last_caller := a_caller
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
			if last_selected_position /= 0 then
				Result := (profiler_list @ last_selected_position).value
			end
		end

feature {NONE} -- User Interface

	build_widgets is
			-- Setup the interface.
		do
			create text_form.make (Current)
			create text_sep.make (Current)
			create compile_form.make (Current)
			create compile_sep.make (Current)
			create profiler_form.make (Current)
			create profiler_sep.make (Current)
			create button_form.make (Current)

			create text_label.make_with_text (text_form, Interface_names.l_Input_file)
			create text_field.make_with_text (text_form, Interface_names.t_Empty)
			text_field.set_text ("profinfo")

			create compile_label.make_with_text (compile_form, Interface_names.l_Compile_type)
			create compile_box.make (compile_form)
			create workbench_button.make_with_text (compile_box, Interface_names.b_Workbench)
			workbench_button.set_state (True)
			create final_button.make_with_text (compile_box, Interface_names.b_Final)

			create profiler_label.make_with_text (profiler_form, Interface_names.l_Select_profiler)
			create profiler_list.make (profiler_form)
			profiler_list.add_activate_command (Current, click_it)
			fill_profiler_list

			create ok_button.make_with_text (button_form, Interface_names.b_Ok)
			ok_button.add_click_command (Current, ok_it)
			create cancel_button.make_with_text (button_form, Interface_names.b_Cancel)
			cancel_button.add_click_command (Current, cancel_it)

			set_size (200, 300)
		end


feature {NONE} -- Attributes

	last_caller: EB_GENERATE_PROFILE_INFO_CMD
			-- Last caller of Current

	compile_box: EV_VERTICAL_BOX
			-- Check box with compile mode sewitches

	compile_form,
			-- Form for compile modes

	global_form,
			-- Form as parent of all other widgets

	text_form,
			-- Form for text field

	profiler_form,
			-- Form for scrollable list of profilers

	button_form: EV_VERTICAL_BOX
			-- Form for action buttons

	text_label,
			-- Label to denote input file

	compile_label,
			-- Label to denote compile modes

	profiler_label: EV_LABEL
			-- Label to denote profilers

	text_field: EV_TEXT_FIELD
			-- Text field for input file

	workbench_button,
			-- Check button for workbench mode

	final_button: EV_RADIO_BUTTON
			-- Check button for final mode

	profiler_list: EV_LIST
			-- List with supported profilers

	text_sep,
			-- Separator for text and compile form

	compile_sep,
			-- Separator for compile and profiler form

	profiler_sep: EV_VERTICAL_SEPARATOR
			-- Separator for profile and button form

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
--			from
--				to_be_selected := 1
				update := True
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
				if update then
					to_be_selected := to_be_selected + 1
				end
			end
--			if not profiler_list.empty then
--				profiler_list.select_i_th (to_be_selected)
--				last_selected_position := to_be_selected
--			end
		end

feature {NONE} -- Execution arguments

	ok_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make
		end

	cancel_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make
		end

	click_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make
		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data EV_EVENT_DATA) is
			-- Execute Current.
		do
			if arg = ok_it then
				if profiler_list.selected_position /= 0 then
					last_caller.execute (Current, data)
				end
			elseif arg = cancel_it then
				last_caller.execute (Void, Void )
			elseif arg = click_it then
				if profiler_list.selected_count = 0 then
					profiler_list.select_i_th (last_selected_position)
				else
					last_selected_position := profiler_list.selected_position
				end
			end
		end

end -- class EB_GENERATION_OPTIONS_DLG
