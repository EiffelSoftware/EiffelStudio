indexing

	description:
		"Dialog to display options for generation of %
		%internal data structures.";
	date: "$Date$";
	revision: "$Revision$"

class GENERATION_OPTIONS_DLG

inherit
	FORM_D
		rename
			make as top_shell_make
		end

	EB_CONSTANTS

	EIFFEL_ENV

	COMMAND

	WINDOW_ATTRIBUTES

creation
	make

feature {NONE} -- Initialization

	make (a_parent: PROFILE_TOOL) is
			-- Create dialog with `a_parent' as `parent'.
		do
			top_shell_make (Interface_names.n_X_resource_name, a_parent);
			set_title (Interface_names.t_Generation_options);
			build_widgets
			set_composite_attributes (Current)
		end

feature -- Basic operations

	call (a_caller: GENERATE_PROFILE_INFO_CMD) is
			-- Popup Current and record `a_caller'
			-- to be called on the event of callbacks
		do
			last_caller := a_caller;
			popup;
			raise
		end

feature -- Access

	profinfo_file: STRING is
			-- File to use as input file
		do
			Result := text_field.text
		end;

	compile_mode: STRING is
			-- Compile mode for which `profinfo_file'
			-- has been generated.
		do
			if workbench_button.state then
				Result := "workbench"
			else
				Result := "final"
			end
		end;

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
			!! text_form.make (Interface_names.n_X_resource_name, Current);
			!! text_sep.make (Interface_names.t_Empty, Current);
			!! compile_form.make (Interface_names.n_X_resource_name, Current);
			!! compile_sep.make (Interface_names.t_Empty, Current);
			!! profiler_form.make (Interface_names.n_X_resource_name, Current);
			!! profiler_sep.make (Interface_names.t_Empty, Current);
			!! button_form.make (Interface_names.n_X_resource_name, Current);
			button_form.set_fraction_base (3);

			!! text_label.make (Interface_names.l_Input_file, text_form);
			!! text_field.make (Interface_names.t_Empty, text_form);
			text_field.set_text ("profinfo");

			!! compile_label.make (Interface_names.l_Compile_type, compile_form);
			!! compile_box.make (Interface_names.t_Empty, compile_form);
			compile_box.set_always_one (True);
			!! workbench_button.make (Interface_names.b_Workbench, compile_box);
			workbench_button.set_toggle_on;
			!! final_button.make (Interface_names.b_Final, compile_box);

			!! profiler_label.make (Interface_names.l_Select_profiler, profiler_form);
			!! profiler_list.make (Interface_names.t_Empty, profiler_form);
			profiler_list.add_click_action (Current, click_it);
			fill_profiler_list;

			!! ok_button.make (Interface_names.b_Ok, button_form);
			ok_button.add_activate_action (Current, ok_it);
			!! cancel_button.make (Interface_names.b_Cancel, button_form);
			cancel_button.add_activate_action (Current, cancel_it);

			attach_all;

			set_size (200, 300)
		end

	attach_all is
			-- Attach all widgets
		do
				-- Attach forms
			attach_top (text_form, 0);
			attach_right (text_form, 0);
			attach_top_widget (text_form, text_sep, 1);
			attach_left (text_form, 0);
			attach_right (text_sep, 0);
			attach_top_widget (text_sep, compile_form, 1);
			attach_left (text_sep, 0);

			attach_right (compile_form, 0);
			attach_top_widget (compile_form, compile_sep, 1);
			attach_left (compile_form, 0);
			attach_right (compile_sep, 0);
			attach_top_widget (compile_sep, profiler_form, 1);
			attach_left (compile_sep, 0);

			attach_right (profiler_form, 0);
			attach_bottom_widget (profiler_sep, profiler_form, 1);
			attach_left (profiler_form, 0);
			attach_right (profiler_sep, 0);
			attach_bottom_widget (button_form, profiler_sep, 1);
			attach_left (profiler_sep, 0);

			attach_right (button_form, 0);
			attach_bottom (button_form, 0);
			attach_left (button_form, 0);

				-- Attach text_form's children
			text_form.attach_top (text_label, 1);
			text_form.attach_top_widget (text_label, text_field, 2);
			text_form.attach_left (text_label, 0);
			text_form.attach_right (text_field, 5);
			text_form.attach_bottom (text_field, 0);
			text_form.attach_left (text_field, 5);

				-- Attach compile_form's children
			compile_form.attach_top (compile_label, 1);
			compile_form.attach_top_widget (compile_label, compile_box, 2);
			compile_form.attach_left (compile_label, 0);
			compile_form.attach_right (compile_box, 0);
			compile_form.attach_bottom (compile_box, 0);
			compile_form.attach_left (compile_box, 0);

				-- Attach profiler_form's children
			profiler_form.attach_top (profiler_label, 1);
			profiler_form.attach_top_widget (profiler_label, profiler_list, 2);
			profiler_form.attach_left (profiler_label, 0);
			profiler_form.attach_right (profiler_list, 0);
			profiler_form.attach_bottom (profiler_list, 0);
			profiler_form.attach_left (profiler_list, 1);

				-- Attach button_form's children
			button_form.attach_left_position (ok_button, 0);
			button_form.attach_bottom (ok_button, 2);
			button_form.attach_right_position (ok_button, 1);
			button_form.attach_left_position (cancel_button, 2);
			button_form.attach_bottom (cancel_button, 2);
			button_form.attach_right_position (cancel_button, 3)
		end

feature {NONE} -- Attributes

	last_caller: GENERATE_PROFILE_INFO_CMD;
			-- Last caller of Current

	compile_box: RADIO_BOX;
			-- Check box with compile mode sewitches

	compile_form,
			-- Form for compile modes

	global_form,
			-- Form as parent of all other widgets

	text_form,
			-- Form for text field

	profiler_form,
			-- Form for scrollable list of profilers

	button_form: FORM;
			-- Form for action buttons

	text_label,
			-- Label to denote input file

	compile_label,
			-- Label to denote compile modes

	profiler_label: LABEL;
			-- Label to denote profilers

	text_field: TEXT_FIELD;
			-- Text field for input file

	workbench_button,
			-- Check button for workbench mode

	final_button: TOGGLE_B;
			-- Check button for final mode

	profiler_list: SCROLLABLE_LIST;
			-- List with supported profilers

	text_sep,
			-- Separator for text and compile form

	compile_sep,
			-- Separator for compile and profiler form

	profiler_sep: THREE_D_SEPARATOR;
			-- Separator for profile and button form

	ok_button,
			-- Button to start generation

	cancel_button: PUSH_B
			-- Button to cancel generation

	last_selected_position: INTEGER
			-- Position (one based) of last selected item in `profiler_list'

feature {NONE} -- Implementation

	fill_profiler_list is
			-- Fill `profiler_list' with profilers
			-- for which configuration files could be found
			-- in Eiffel installtion directory under "bench/profiler".
		require
			profiler_list_not_void: profiler_list /= Void
		local
			profdir: DIRECTORY;
			list_string: SCROLLABLE_LIST_STRING_ELEMENT;
			to_be_selected: INTEGER;
			update: BOOLEAN
		do
			!! profdir.make_open_read (profile_path);
			from
				to_be_selected := 1;
				update := True;
				profdir.start;
				profdir.readentry;
				profdir.readentry;
				profdir.readentry
			until
				profdir.lastentry = Void
			loop
				!! list_string.make (0);
				if profdir.lastentry.is_equal ("eiffel") then
					update := False
				end;
				list_string.append (profdir.lastentry);
				profiler_list.extend (list_string);
				profdir.readentry;
				if update then
					to_be_selected := to_be_selected + 1
				end
			end;
			if not profiler_list.is_empty then
				profiler_list.select_i_th (to_be_selected);
				last_selected_position := to_be_selected
			end
		end

feature {NONE} -- Execution arguments

	ok_it: ANY is
		once
			!! Result
		end;

	cancel_it: ANY is
		once
			!! Result
		end;

	click_it: ANY is
		once
			!! Result
		end

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute Current.
		do
			if arg = ok_it then
				if profiler_list.selected_position /= 0 then
					last_caller.execute (Current)
				end
			elseif arg = cancel_it then
				last_caller.execute (Void)
			elseif arg = click_it then
				if profiler_list.selected_count = 0 then
					profiler_list.select_i_th (last_selected_position)
				else
					last_selected_position := profiler_list.selected_position
				end
			end
		end

end -- class GENERATION_OPTIONS_DLG
