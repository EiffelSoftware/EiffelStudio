indexing

	description:
		"Window to display results from a query.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_QUERY_WINDOW

inherit
	FORM_D
		rename
			make as form_d_make
		end;
	EB_CONSTANTS;
	SHARED_TABS

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_TOOL) is
			-- Create Current with `a_tool' as `tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool;
			form_d_make (Interface_names.n_X_resource_name, a_tool);
			set_title (Interface_names.t_Profile_query_window);

			build_interface
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature -- Access

	save_in (fn: STRING) is
			-- Save options, result, and query
			-- to a file named `fn'.
		require
			fn_not_void: fn /= Void;
			fn_not_empty: not fn.empty
		local
			ptf: PLAIN_TEXT_FILE
		do
			!! ptf.make_create_read_write (fn);
			ptf.putstring ("Options:%N========%N%N");
			ptf.putstring (profiler_options.image);
			ptf.putstring ("%NQuery:%N======%N%N");
			ptf.putstring (profiler_query.image);
			ptf.putstring ("%NResults:%N========%N%N");
			ptf.putstring (text_window.text);
			ptf.new_line;
			ptf.close
		end

feature -- Status Setting

	update_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; pi: PROFILE_INFORMATION) is
			-- Update User Interface Widgets to reflect the parameters.
		do
			profiler_query := pq;
			profiler_options := po;
			profinfo := pi;

			query_text.set_text (pq.image);
			text_window.clear_window;
			text_window.process_text (st);
			text_window.display
		end

feature -- Update

	update_graphical_resources is
			-- Update the graphical resources.
		do
			text_window.clear_window;
			text_window.init_resource_values;
			run_subquery_cmd.execute (Void)
		end

feature {NONE} -- Graphical User Interface

	build_interface is
			-- Build the user interface.
		do
				--| Build forms
			!! query_form.make (Interface_names.t_Empty, Current);
			!! text_form.make (Interface_names.t_Empty, Current);
			!! subquery_form.make (Interface_names.t_Empty, Current);
			!! button_form.make (Interface_names.t_Empty, Current);

				--| Build widgets
			!! query_sep.make (Interface_names.t_Empty, Current);
			!! text_sep.make (Interface_names.t_Empty, Current);
			!! subquery_sep.make (Interface_names.t_Empty, Current);

			!! query_label.make (Interface_names.l_Query, query_form);
			!! query_text.make (Interface_names.t_Empty, query_form);
			query_text.set_read_only;
			query_text.set_rows (3);

			!! text_label.make (Interface_names.l_Results, text_form);
			if is_graphics_disabled then
				if tabs_disabled then
					!SCROLLED_TEXT_WINDOW! text_window.make (Interface_names.t_Empty, text_form)
				else
					!TABBED_TEXT_WINDOW! text_window.make (Interface_names.t_Empty, text_form)
				end
			else
				!GRAPHICAL_TEXT_WINDOW! text_window.make (Interface_names.t_Empty, text_form)
			end;

			text_window.init_resource_values;
			!! subquery_label.make (Interface_names.l_Subquery, subquery_form);
			!! subquery_text.make (Interface_names.t_Empty, subquery_form);

			!! run_button.make (Interface_names.b_Run_subquery, button_form);
			!! run_subquery_cmd.make (Current);
			run_button.add_activate_action (run_subquery_cmd, Void);
			subquery_text.add_activate_action (run_subquery_cmd, Void);
			!! save_as_button.make (Interface_names.b_Save_as, button_form);
			!! save_result_cmd.make (Current);
			save_as_button.add_activate_action (save_result_cmd, Void);
			!! close_button.make (Interface_names.b_Close, button_form);
			!! close_cmd.make (Current);
			close_button.add_activate_action (close_cmd, Void);

				--| Attach all
			attach_all;

				--| Sizing
			set_size (Profiler_resources.query_tool_width.actual_value, 
					Profiler_resources.query_tool_height.actual_value)
		end;

	attach_all is
			-- Attach widgets in interface.
		do
				--| Attach forms
			attach_top (query_form, 0);
			attach_right (query_form, 0);
			attach_left (query_form, 0);

			attach_top_widget (query_form, query_sep, 1);
			attach_right (query_sep, 0);
			attach_left (query_sep, 0);

			attach_top_widget (query_sep, text_form, 1);
			attach_right (text_form, 0);
			attach_bottom_widget (text_sep, text_form, 1);
			attach_left (text_form, 0);

			attach_right (text_sep, 0);
			attach_bottom_widget (subquery_form, text_sep, 1);
			attach_left (text_sep, 0);

			attach_right (subquery_form, 0);
			attach_bottom_widget (subquery_sep, subquery_form, 1);
			attach_left (subquery_form, 0);

			attach_right (subquery_sep, 0);
			attach_bottom_widget (button_form, subquery_sep, 1);
			attach_left (subquery_sep, 0);

			attach_right (button_form, 0);
			attach_bottom (button_form, 0);
			attach_left (button_form, 0);

				--| Attach widgets in forms
			query_form.attach_top (query_label, 0);
			query_form.attach_left (query_label, 5);

			query_form.attach_top_widget (query_label, query_text, 2);
			query_form.attach_right (query_text, 0);
			query_form.attach_bottom (query_text, 0);
			query_form.attach_left (query_text, 0);

			text_form.attach_top (text_label, 0);
			text_form.attach_left (text_label, 5);
			text_form.attach_top_widget (text_label, text_window.widget, 2);
			text_form.attach_right (text_window.widget, 0);
			text_form.attach_bottom (text_window.widget, 0);
			text_form.attach_left (text_window.widget, 0);

			subquery_form.attach_top (subquery_label, 0);
			subquery_form.attach_left (subquery_label, 5);

			subquery_form.attach_top_widget (subquery_label, subquery_text, 2);
			subquery_form.attach_right (subquery_text, 0);
			subquery_form.attach_bottom (subquery_text, 0);
			subquery_form.attach_left (subquery_text, 0);

			button_form.set_fraction_base (6);
			button_form.attach_left_position (run_button, 0);
			button_form.attach_right_position (run_button, 2);
			button_form.attach_left_position (save_as_button, 2);
			button_form.attach_right_position (save_as_button, 4);
			button_form.attach_left_position (close_button, 4);
			button_form.attach_right_position (close_button, 6)
		end

feature {NONE} -- Attributes

	tool: PROFILE_TOOL;
			-- Tool as parent of Current

	query_sep,
			-- Separator between `query_form' and `text_form'

	text_sep,
			-- Separator between `text_form' and `subquery_form'

	subquery_sep: SEPARATOR
			-- Separator between `subquery_form' and `button_form'

	query_form,
			-- Form for the query

	text_form,
			-- Form for the text window

	subquery_form,
			-- Form for the subquery

	button_form: FORM;
			-- Form for the buttons

	query_label,
			-- Label for `query_text'

	text_label,
			-- Label for `text_window'

	subquery_label: LABEL;
			-- Label for `subquery_text'

	subquery_text: TEXT_FIELD;
			-- Text field for eventual subqueries

	query_text: TEXT;
			-- Text field for the query

	text_window: TEXT_WINDOW;
			-- Output window for the results

	run_button,
			-- Button for `run_subquery_cmd'

	save_as_button,
			-- Button for `save_result_cmd'

	close_button: PUSH_B;
			-- Button to close Current

	run_subquery_cmd: RUN_SUBQUERY_CMD;
			-- Command to run a subquery from Current

	save_result_cmd: SAVE_RESULT_CMD;
			-- Command to save the result of currently displayed query

	close_cmd: CLOSE_QUERY_WINDOW_CMD
			-- Command to close Current

feature {RUN_SUBQUERY_CMD} -- Attributes

	profiler_query: PROFILER_QUERY;
			-- Query from which `profinfo' is the result

	profiler_options: PROFILER_OPTIONS;
			-- Options used to generate `profinfo'

	profinfo: PROFILE_INFORMATION;
			-- Set of information about profiled system, generated
			-- with help of `profiler_query' and `profiler_options'

feature {CLOSE_QUERY_WINDOW_CMD} -- User Interface

	close is
			-- Close Current and update `tool'
		do
			popdown;
			destroy;
			tool.query_window_is_closed (Current)
		end;

feature {RUN_SUBQUERY_CMD} -- Access

	subquery: STRING is
			-- Text typed in the subquery window
		do
			Result := subquery_text.text
		end

feature {NONE} -- Implementation

	is_graphics_disabled: BOOLEAN is
			-- Is Graphics disabled for the text window?
		once 
			Result := Configure_resources.get_boolean (r_Graphics_disabled, False) 
		end

end -- class PROFILE_QUERY_WINDOW
