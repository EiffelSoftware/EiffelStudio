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
		end

	EB_CONSTANTS

	SHARED_CONFIGURE_RESOURCES

	COMMAND

	WINDOW_ATTRIBUTES

	WINDOWS

creation
	make
	

feature {NONE} -- Initialization

	make (a_tool: PROFILE_TOOL) is
			-- Create Current with `a_tool' as `tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
			form_d_make (Interface_names.n_X_resource_name, a_tool)
			set_title (Interface_names.t_Profile_query_window)

			!! all_subqueries.make
			!! all_operators.make

			build_interface
			set_composite_attributes (Current)
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature -- Access

	save_in (fn: STRING) is
			-- Save options, result, and query
			-- to a file named `fn'.
		require
			fn_not_void: fn /= Void;
			fn_not_empty: not fn.is_empty
		local
			ptf: RAW_FILE;	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			aok: BOOLEAN
		do
			!! ptf.make (fn)
			aok := True
			if ptf.exists and then not ptf.is_plain then
				aok := False
				warner (Current).gotcha_call (Warning_messages.w_Not_a_plain_file (fn))
			elseif ptf.exists and then ptf.is_writable then
				aok := False
				warner (Current).custom_call (Void, 
					Warning_messages.w_File_exists (fn), 
					Interface_names.b_Overwrite, Void, Interface_names.b_Cancel)
			elseif ptf.exists and then not ptf.is_writable then
				aok := False
				warner (Current).gotcha_call (Warning_messages.w_Not_writable (fn))
			elseif not ptf.is_creatable then
				aok := False
				warner (Current).gotcha_call (Warning_messages.w_Not_creatable (fn))
			end

			if aok then
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
		end

feature -- Status Setting

	update_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; pi: PROFILE_INFORMATION) is
			-- Update User Interface Widgets to reflect the parameters.
		do
			profiler_query := pq;
			profiler_options := po;
			profinfo := pi;

			count_active_subqueries
			if profiler_query.subqueries.count > active_subqueries then
				from
					profiler_query.subqueries.go_i_th ( active_subqueries + 1 )
					profiler_query.subquery_operators.go_i_th ( active_subqueries )
					if profiler_query.subquery_operators.before then
						profiler_query.subquery_operators.forth
					end
				until
					profiler_query.subqueries.after 
				loop
					all_subqueries.extend ( profiler_query.subqueries.item )
					profiler_query.subqueries.forth
					if not profiler_query.subquery_operators.after then
						all_operators.extend ( profiler_query.subquery_operators.item )
						profiler_query.subquery_operators.forth
					end
				end
			end

			update_query_form  
			subquery_text.clear
			text_window.clear_window;
			text_window.process_text (st);
			text_window.set_cursor_position (0)
			text_window.display
		end

feature -- Update

	update_graphical_resources is
			-- Update the graphical resources.
		do
			text_window.clear_window;
			text_window.init_resource_values;
			run_query_cmd.execute (Void)
		end

	update_query_form is
		local
			i : INTEGER
			scrollable_subquery: SCROLLABLE_SUBQUERY
		do
			active_query_window.wipe_out
			inactive_subqueries_window.wipe_out
			if all_subqueries.count > 0 then
				all_subqueries.start
				!! scrollable_subquery.make_first (all_subqueries.item.image)
				if all_subqueries.item.is_active then
					active_query_window.force (scrollable_subquery)
				else
					inactive_subqueries_window.force (scrollable_subquery)
				end
				if all_operators.count > 0 then
					from
						all_subqueries.forth
						all_operators.start
						i := 2
					until
						all_subqueries.after or else all_operators.after
					loop
						!! scrollable_subquery.make (all_operators.item.actual_operator, all_subqueries.item.image, i )
						if all_subqueries.item.is_active then
							if active_query_window.is_empty then
								!! scrollable_subquery.make ("", all_subqueries.item.image, i) 
							end
							active_query_window.force (scrollable_subquery)
						else
							inactive_subqueries_window.force (scrollable_subquery)
						end
						all_subqueries.forth
						all_operators.forth
						i := i + 1
					end							
				end
			end
		end

	update_profiler_query is
		do
			profiler_query.set_subqueries (all_subqueries)
			profiler_query.set_subquery_operators (all_operators)
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

			!! active_query_form.make (Interface_names.t_empty, query_form)
			!! query_button_form.make (Interface_names.t_empty, query_form)
			!! inactive_subqueries_form.make (Interface_names.t_empty, query_form)

			!! active_query_label.make (Interface_names.l_Active_query, active_query_form)
			!! active_query_window.make (Interface_names.t_empty, active_query_form)
			active_query_window.set_multiple_selection

			!! reactivate_label.make (Interface_names.l_Reactivate, query_button_form)
			!! inactivate_label.make (Interface_names.l_Inactivate, query_button_form)
			!! reactivate_button.make (Interface_names.t_empty, query_button_form)
			reactivate_button.set_left
			!! inactivate_button.make (Interface_names.t_empty, query_button_form)
			inactivate_button.set_right
			reactivate_button.add_activate_action (Current, reactivate_subqueries)
			inactivate_button.add_activate_action (Current, inactivate_subqueries)
			!! change_operator_label.make (Interface_names.l_Change_operator, query_button_form) 
			!! set_or_operator_button.make (Interface_names.b_Or, query_button_form)
			!! set_and_operator_button.make (Interface_names.b_And, query_button_form)
			!! change_operator_cmd.make (Current)
			set_or_operator_button.add_activate_action (change_operator_cmd, "or")
			set_and_operator_button.add_activate_action (change_operator_cmd, "and")

			!! inactive_subqueries_label.make (Interface_names.l_Inactive_subqueries, inactive_subqueries_form)
			!! inactive_subqueries_window.make (Interface_names.t_empty, inactive_subqueries_form)
			inactive_subqueries_window.set_multiple_selection

			!! text_label.make (Interface_names.l_Results, text_form);
			if is_graphics_disabled then
				!SCROLLED_TEXT_WINDOW! text_window.make (Interface_names.t_Empty, text_form)
			else
				!GRAPHICAL_TEXT_WINDOW! text_window.make (Interface_names.t_Empty, text_form)
			end;

			text_window.init_resource_values;

			!! subquery_label.make (Interface_names.l_Subquery, subquery_form);
			!! subquery_text.make (Interface_names.t_Empty, subquery_form);
			!! add_label.make (Interface_names.l_Add, subquery_form)
			add_label.set_left_alignment
			!! add_subquery_cmd.make(Current)
			!! add_and_operator_button.make (Interface_names.b_And, subquery_form);
			add_and_operator_button.add_activate_action (add_subquery_cmd, "and")
			!! add_or_operator_button.make (Interface_names.b_Or, subquery_form); 
			add_or_operator_button.add_activate_action (add_subquery_cmd, "or")

			!! run_button.make (Interface_names.b_Run, button_form);
			!! run_query_cmd.make (Current);
			run_button.add_activate_action (run_query_cmd, Void);
			!! save_as_button.make (Interface_names.b_Save, button_form);
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

			attach_top_widget (query_form, query_sep, 0);
			attach_right (query_sep, 0);
			attach_left (query_sep, 0);

			attach_top_widget (query_sep, text_form, 0);
			attach_right (text_form, 0);
			attach_bottom_widget (text_sep, text_form, 0);
			attach_left (text_form, 0);

			attach_right (text_sep, 0);
			attach_bottom_widget (subquery_form, text_sep, 0);
			attach_left (text_sep, 0);

			attach_right (subquery_form, 0);
			attach_bottom_widget (subquery_sep, subquery_form, 0);
			attach_left (subquery_form, 0);

			attach_right (subquery_sep, 0);
			attach_bottom_widget (button_form, subquery_sep, 0);
			attach_left (subquery_sep, 0);

			attach_right (button_form, 0);
			attach_bottom (button_form, 0);
			attach_left (button_form, 0);

			query_form.attach_left (active_query_form, 1)
			query_form.attach_top (active_query_form, 0)
			query_form.attach_bottom (active_query_form, 0)

			query_form.attach_top (query_button_form, 0)
		 	query_form.attach_bottom (query_button_form, 0)

			query_form.attach_top (inactive_subqueries_form, 0)
			query_form.attach_right (inactive_subqueries_form, 1)
			query_form.attach_bottom (inactive_subqueries_form, 0)

			query_form.attach_right_position (active_query_form, 40)

			query_form.attach_left_position (query_button_form, 40)
			query_form.attach_right_position (query_button_form, 60)

			query_form.attach_left_position (inactive_subqueries_form, 60)


			active_query_form.attach_left (active_query_label, 0)
			active_query_form.attach_top (active_query_label, 5)
			active_query_form.attach_right (active_query_label, 0)
			active_query_form.attach_top_widget (active_query_label, active_query_window, 10)
			active_query_form.attach_left (active_query_window, 0)
			active_query_form.attach_bottom (active_query_window, 5)
			active_query_form.attach_right (active_query_window, 0)

			query_button_form.attach_top (reactivate_label, 0)
			query_button_form.attach_left (reactivate_label, 0)
			query_button_form.attach_right ( reactivate_label, 0)
			query_button_form.attach_top_widget (reactivate_label, reactivate_button, 5)
			query_button_form.attach_left_position (reactivate_button, 40)
			query_button_form.attach_right_position (reactivate_button, 60)
			query_button_form.attach_top_widget (reactivate_button, inactivate_label, 10)
			query_button_form.attach_left (inactivate_label, 0)
			query_button_form.attach_right (inactivate_label, 0)
			query_button_form.attach_top_widget (inactivate_label, inactivate_button, 5)
			query_button_form.attach_left_position (inactivate_button, 40)
			query_button_form.attach_right_position (inactivate_button, 60)
			query_button_form.attach_top_widget (inactivate_button, change_operator_label, 10)
			query_button_form.attach_left (change_operator_label, 0)
			query_button_form.attach_right (change_operator_label, 0)
			query_button_form.attach_top_widget (change_operator_label, set_and_operator_button, 5)
			query_button_form.attach_top_widget (change_operator_label, set_or_operator_button, 5)
			query_button_form.attach_left_position (set_and_operator_button, 10)
			query_button_form.attach_right_position (set_and_operator_button, 45)
			query_button_form.attach_left_position (set_or_operator_button, 55)
			query_button_form.attach_right_position (set_or_operator_button, 90)

			inactive_subqueries_form.attach_left ( inactive_subqueries_label, 0 )
			inactive_subqueries_form.attach_top ( inactive_subqueries_label, 5 )
			inactive_subqueries_form.attach_right ( inactive_subqueries_label, 0 )
			inactive_subqueries_form.attach_top_widget ( inactive_subqueries_label, inactive_subqueries_window, 10)
			inactive_subqueries_form.attach_left ( inactive_subqueries_window, 0 )
			inactive_subqueries_form.attach_bottom ( inactive_subqueries_window, 5 )
			inactive_subqueries_form.attach_right ( inactive_subqueries_window, 0 )

			text_form.attach_top (text_label, 0);
			text_form.attach_left (text_label, 5);
			text_form.attach_top_widget (text_label, text_window.widget, 2);
			text_form.attach_right (text_window.widget, 0);
			text_form.attach_bottom (text_window.widget, 0);
			text_form.attach_left (text_window.widget, 0);

			subquery_form.attach_top (subquery_label, 0);
			subquery_form.attach_left (subquery_label, 2);
			subquery_form.attach_top_widget (subquery_label, subquery_text, 10)
			subquery_form.attach_right_position (subquery_text, 90);
			subquery_form.attach_left_position (subquery_text, 10)
			subquery_form.attach_top_widget (subquery_text, add_label, 10)
			subquery_form.attach_left (add_label, 2)
			subquery_form.attach_bottom (add_label, 2)
			subquery_form.attach_right_position (add_label, 25)
			subquery_form.attach_left_position (add_and_operator_button, 30)
			subquery_form.attach_right_position (add_and_operator_button, 40)
			subquery_form.attach_top_widget (subquery_text, add_and_operator_button, 10)
			subquery_form.attach_bottom (add_and_operator_button, 10)
			subquery_form.attach_top_widget (subquery_text, add_or_operator_button, 10)
			subquery_form.attach_bottom (add_or_operator_button, 10)
			subquery_form.attach_left_position (add_or_operator_button, 60)
			subquery_form.attach_right_position (add_or_operator_button, 70)

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

	subquery_sep: THREE_D_SEPARATOR
			-- Separator between `subquery_form' and `button_form'

	query_form,
			-- Form for the query

	text_form,
			-- Form for the text window

	subquery_form,
			-- Form for the subquery

	button_form: FORM;
			-- Form for the buttons

	text_label,
			-- Label for `text_window'

	subquery_label: LABEL
			-- Label for `subquery_text'

	change_operator_label: LABEL;
			-- Label for 'change_operator_button'

	text_window: TEXT_WINDOW;
			-- Output window for the results

	run_button,
			-- Button for `run_subquery_cmd'

	save_as_button,
			-- Button for `save_result_cmd'

	close_button,
			-- Button to close Current

	add_or_operator_button,
			-- Button to add a subquery with 'or' operator

	add_and_operator_button,
			-- Button to add a subquery with 'and' operator

	set_and_operator_button,
			-- Button to set all the selected subqueries operators
			-- to 'and'

	set_or_operator_button: PUSH_B
			-- Button to set all the selected subqueries operators
			-- to 'or'

	run_query_cmd: RUN_QUERY_CMD;
			-- Command to run a subquery from Current

	save_result_cmd: SAVE_RESULT_CMD;
			-- Command to save the result of currently displayed query

	close_cmd: CLOSE_QUERY_WINDOW_CMD
			-- Command to close Current

	add_subquery_cmd: ADD_SUBQUERY_CMD
			-- Command to add a subquery

	change_operator_cmd: CHANGE_OPERATOR_CMD
			-- Command to change subquery operators

	active_query_form,
			-- Form for active query

	query_button_form,
			-- Form wih buttons allowing subqueries activation/inactivation

	inactive_subqueries_form: FORM
			-- Form for inactive subqueries

	add_label,
			-- Label for adding an operator

	active_query_label,
			-- Label for 'active_query_form'

	inactive_subqueries_label,
			-- Label for 'inactive_subqueries_form'

	reactivate_label,
			-- Label for 'reactivate_button'

	inactivate_label: LABEL
			-- Label for 'inactivate_button

	reactivate_button,
			-- Button to reactivate one or more subqueries

	inactivate_button: ARROW_B
			-- Button to inactivate one or more subqueries

	active_subqueries: INTEGER
			-- number of active subqueries in all_subqueries

feature {CHANGE_OPERATOR_CMD} -- Attributes

	active_query_window,
			--  Scrollable list of active subqueries

	inactive_subqueries_window: SCROLLABLE_LIST
			-- Scrollable list if inactive queries

feature {ADD_SUBQUERY_CMD, CHANGE_OPERATOR_CMD} -- Attributes

	subquery_text: TEXT_FIELD;
			-- Text field for eventual subqueries


	all_subqueries: LINKED_LIST[SUBQUERY]
			-- all the subqueries typed

	all_operators: LINKED_LIST[SUBQUERY_OPERATOR]
			-- all the subquery operators typed

feature {RUN_QUERY_CMD} -- Attributes

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

feature {ADD_SUBQUERY_CMD} -- Access

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

	count_active_subqueries is
		do
			from
				all_subqueries.start
				active_subqueries := 0
			until
				all_subqueries.after
			loop
				if all_subqueries.item.is_active then
					active_subqueries := active_subqueries + 1
				end
				all_subqueries.forth
			end
		end
	
	inactivate is
		-- copy all the selected 'scrollable_subquery' from 'active_query_window'
		-- into 'inactive_subqueries_window', activate the corresponding subqueries
		-- and operators in 'all_subqueries' and 'all_operators'
		local
			selected_positions: SORTED_TWO_WAY_LIST [INTEGER]
			i: INTEGER
			inactive_element, active_element: SCROLLABLE_SUBQUERY
		do
			if active_query_window.selected_count > 0 then
				!! selected_positions.make
				selected_positions.fill ( active_query_window.selected_positions )
				from
					selected_positions.sort
					selected_positions.start
					i := selected_positions.item
					active_query_window.go_i_th ( i )
					inactive_subqueries_window.start
					-- !! active_element.make
					-- active_element ?= active_query_window.item
					-- !! inactive_element.make
					-- inactive_element ?= inactive_subqueries_window.item
				until
					i > selected_positions.last
				loop
					if i = selected_positions.item then
						active_element ?= active_query_window.item
							--| FIXME: Guillaume - 28/09/97
							--| Not correct. Must find a way to get the right index 
							--| of active_query_window.item
						if not inactive_subqueries_window.is_empty then
							from
								inactive_element ?= inactive_subqueries_window.item
							until
								inactive_subqueries_window.after
								or else inactive_element.index >= active_element.index
							loop
								inactive_subqueries_window.forth
								inactive_element ?= inactive_subqueries_window.item
							end
						end
							--| add the inactivated subquery in the 'inactive_subqueries_window'
						inactive_subqueries_window.put_left ( active_element )
						
							--| inactivate the subquery in 'all_subqueries'
						all_subqueries.go_i_th ( active_element.index )
						all_subqueries.item.inactivate
						
							--| inactivate the subquery operator in 'all_operators'
						if not all_operators.is_empty then
							if inactive_element = void or else inactive_element.index = 1 then
								all_operators.go_i_th ( 1 )
							else
								all_operators.go_i_th ( active_element.index - 1 )
							end
							all_operators.item.inactivate	
						end 
						
							--| remove the inactivated subquery from 'active_query_window'
						active_query_window.remove
						i := i + 1
						-- active_element ?= active_query_window.item
						
						selected_positions.forth
					else
						i := i + 1
						active_query_window.forth
						-- active_element ?= active_query_window.item
					end
					profiler_query.set_subqueries ( all_subqueries )
					profiler_query.set_subquery_operators ( all_operators )
				end
			end
			update_query_form
		end

	reactivate is
		-- copy all the selected 'scrollable_subquery' from 'inactive_subqueries_window'
		-- into 'active_query_window', activate the corresponding subqueries
		-- and operators in 'all_subqueries' and 'all_operators'
		local
			selected_positions: SORTED_TWO_WAY_LIST [INTEGER]
			i: INTEGER
			inactive_element, active_element: SCROLLABLE_SUBQUERY
		do
			if inactive_subqueries_window.selected_count > 0 then
				!! selected_positions.make
				selected_positions.fill ( inactive_subqueries_window.selected_positions )
				from
					selected_positions.sort
					selected_positions.start
					i := selected_positions.item
					inactive_subqueries_window.go_i_th ( i )
					active_query_window.start
					!! active_element.make ("", "", 0)
					active_element ?= active_query_window.item
					!! inactive_element.make ("", "", 0)
					inactive_element ?= inactive_subqueries_window.item
				until
					i > selected_positions.last
				loop
					if i = selected_positions.item then
						inactive_element ?= inactive_subqueries_window.item
						if not active_query_window.is_empty then
							from
								active_element ?= active_query_window.item
							until
								active_query_window.after
								or else active_element.index >= inactive_element.index
							loop
								active_query_window.forth
								active_element ?= active_query_window.item
							end
						end

							--| add the inactivated subquery in the 'inactive_subqueries_window'
						active_query_window.put_left ( inactive_element )
						
							--| reactivate the subquery in 'all_subqueries'
						all_subqueries.go_i_th ( inactive_element.index )
						all_subqueries.item.activate
						
							--| reactivate the subquery operator in 'all_operators'
						if not all_operators.is_empty then
							if active_element = void or else active_element.index = 1 then
								all_operators.go_i_th ( 1 )
							else
								all_operators.go_i_th ( inactive_element.index - 1 )
							end
							all_operators.item.activate
						end	
						
							--| remove the reactivated subquery from 'inactive_subqueries_window'
						inactive_subqueries_window.remove
						i := i + 1
						
						selected_positions.forth
					else
						i := i + 1
						inactive_subqueries_window.forth
					end
					profiler_query.set_subqueries ( all_subqueries )
					profiler_query.set_subquery_operators ( all_operators )
				end
			end
			update_query_form
		end

feature {NONE} -- Execution arguments

	reactivate_subqueries: ANY is
		once
			!! Result
		end
		
	inactivate_subqueries: ANY is
		once
			!! Result
		end
		
feature {NONE} -- execution

	execute (arg: ANY) is
		do
			if arg = reactivate_subqueries then
				reactivate
			elseif arg = inactivate_subqueries then
				inactivate
			end
		end

end -- class PROFILE_QUERY_WINDOW
