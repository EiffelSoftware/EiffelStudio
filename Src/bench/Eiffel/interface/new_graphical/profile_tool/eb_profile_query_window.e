indexing
	description:
		"Window to display results from a query."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_QUERY_WINDOW

inherit
	EV_WINDOW

	EB_PROFILE_TOOL_DATA

	NEW_EB_CONSTANTS

	SHARED_CONFIGURE_RESOURCES

	EV_COMMAND

creation
	make_default
	

feature {NONE} -- Initialization

	make_default (a_tool: EB_PROFILE_TOOL) is
			-- Create Current with `a_tool' as `tool'.
		require
			a_tool_not_void: a_tool /= Void
			a_tool_exists: not a_tool.destroyed
		do
			tool := a_tool
			make_top_level
			set_title (Interface_names.t_Profile_query_window)

			create all_subqueries.make
			create all_operators.make

			build_interface
--			set_composite_attributes (Current)
		ensure
			tool_set: tool.is_equal (a_tool)
		end

	build_interface is
			-- Build the user interface.
		local
			string_arg: EV_ARGUMENT1 [STRING]
		do
				--| Build forms
			create container.make (Current)
			container.set_spacing (4)
			container.set_border_width (4)

				--| Query manager
			create query_box.make (container)
			container.set_child_expandable (query_box, False)
			query_box.set_spacing (4)

			create active_query_frame.make_with_text (query_box, Interface_names.l_Active_query)
			active_query_frame.set_minimum_width (100)
			create active_query_window.make (active_query_frame)
			active_query_window.set_multiple_selection

			create query_button_form.make (query_box)
			query_box.set_child_expandable (query_button_form, False)
			query_button_form.set_spacing (4)

			create reactivate_label.make_with_text (query_button_form, Interface_names.l_Reactivate)
			create reactivate_button.make_with_text (query_button_form, "<")
			reactivate_button.set_horizontal_resize (False)
			reactivate_button.set_vertical_resize (False)
			reactivate_button.add_click_command (Current, reactivate_subqueries)
			create inactivate_label.make_with_text (query_button_form, Interface_names.l_Inactivate)
			create inactivate_button.make_with_text (query_button_form, ">")
			inactivate_button.set_horizontal_resize (False)
			inactivate_button.set_vertical_resize (False)
			inactivate_button.add_click_command (Current, inactivate_subqueries)

			create change_operator_label.make_with_text (query_button_form, Interface_names.l_Change_operator) 
			create change_operator_box.make (query_button_form)
			create change_operator_cmd.make (Current)
			create set_or_operator_button.make_with_text (change_operator_box, Interface_names.b_Or)
			set_or_operator_button.set_horizontal_resize (False)
			set_or_operator_button.set_vertical_resize (False)
			create string_arg.make("or")
			set_or_operator_button.add_click_command (change_operator_cmd, string_arg)
			create set_and_operator_button.make_with_text (change_operator_box, Interface_names.b_And)
			set_and_operator_button.set_horizontal_resize (False)
			set_and_operator_button.set_vertical_resize (False)
			create string_arg.make("and")
			set_and_operator_button.add_click_command (change_operator_cmd, string_arg)

			create inactive_subqueries_frame.make_with_text (query_box, Interface_names.l_Inactive_subqueries)
			inactive_subqueries_frame.set_minimum_width (100)
			create inactive_subqueries_window.make (inactive_subqueries_frame)
			inactive_subqueries_window.set_multiple_selection

				--| Result display
			create text_frame.make_with_text (container, Interface_names.l_Results)
			!EB_CLICKABLE_RICH_TEXT! text_window.make (text_frame)
			text_window.init_resource_values
			text_window.set_editable (False)

				--| Subsquery frame
			create subquery_frame.make_with_text (container, Interface_names.l_Subquery)
			container.set_child_expandable (subquery_frame, False)

			create subquery_box.make (subquery_frame)
			subquery_box.set_border_width (4)
			subquery_box.set_spacing (4)

			create subquery_text.make (subquery_box)
			subquery_text.set_horizontal_resize (True)
			create add_box.make (subquery_box)
			add_box.set_spacing (16)
			create add_label.make_with_text (add_box, Interface_names.l_Add)
			add_box.set_child_expandable (add_label, False)

			create add_subquery_cmd.make(Current)

			create add_and_operator_button.make_with_text (add_box, Interface_names.b_And)
			add_box.set_child_expandable (add_and_operator_button, False)
			add_and_operator_button.set_horizontal_resize (False)
			add_and_operator_button.set_vertical_resize (False)
			create string_arg.make("and")
			add_and_operator_button.add_click_command (add_subquery_cmd, string_arg)

			create add_or_operator_button.make_with_text (add_box, Interface_names.b_Or) 
			add_box.set_child_expandable (add_or_operator_button, False)
			add_or_operator_button.set_horizontal_resize (False)
			add_or_operator_button.set_vertical_resize (False)
			create string_arg.make("or")
			add_or_operator_button.add_click_command (add_subquery_cmd, string_arg)

				--| Build button bar

			create button_box.make (container)
			container.set_child_expandable (button_box, False)
			button_box.set_border_width (4)

			create run_button.make_with_text (button_box, Interface_names.b_Run)
			run_button.set_minimum_width (100)
			run_button.set_horizontal_resize (False)
			run_button.set_vertical_resize (False)
			create run_query_cmd.make (Current)
			run_button.add_click_command (run_query_cmd, Void)
			create save_as_button.make_with_text (button_box, Interface_names.b_Save)
			save_as_button.set_minimum_width (100)
			save_as_button.set_horizontal_resize (False)
			save_as_button.set_vertical_resize (False)
			create save_result_cmd.make (Current)
			save_as_button.add_click_command (save_result_cmd, Void)
			create close_button.make_with_text (button_box, Interface_names.b_Close)
			close_button.set_minimum_width (100)
			close_button.set_horizontal_resize (False)
			close_button.set_vertical_resize (False)
			create close_cmd.make (Current)
			close_button.add_click_command (close_cmd, Void)

				--| Sizing
			set_window_size
		end

feature {EB_SAVE_RESULT_CMD} -- Save commands

	save_it (ptf: RAW_FILE) is
		do
			ptf.create_read_write
			ptf.putstring ("Options:%N========%N%N")
			ptf.putstring (profiler_options.image)
			ptf.putstring ("%NQuery:%N======%N%N")
			ptf.putstring (profiler_query.image)
			ptf.putstring ("%NResults:%N========%N%N")
			ptf.putstring (text_window.text)
			ptf.new_line
			ptf.close
		end

feature -- Status Setting

	set_window_size is
		do
			set_size (query_window_width, query_window_height)
		end

	update_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; pi: PROFILE_INFORMATION) is
			-- Update User Interface Widgets to reflect the parameters.
		do
			profiler_query := pq
			profiler_options := po
			profinfo := pi

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

			update_query_frame
			subquery_text.set_text ("")
			text_window.freeze
			text_window.clear_window
			text_window.process_text (st)
			text_window.set_editable (True)
			text_window.set_position (1)
			text_window.set_editable (False)
			text_window.thaw
		end

feature -- Update

	update_graphical_resources is
			-- Update the graphical resources.
		do
			text_window.clear_window
			text_window.init_resource_values
			run_query_cmd.execute (Void, Void)
		end

	update_query_frame is
		local
			i : INTEGER
			scrollable_subquery: EB_SUBQUERY_ITEM
			op: STRING
		do
			active_query_window.clear_items
			inactive_subqueries_window.clear_items
			if all_subqueries.count > 0 then
				all_subqueries.start
				if all_subqueries.item.is_active then
					create scrollable_subquery.make_first (active_query_window, all_subqueries.item.image)
				else
					create scrollable_subquery.make_first (inactive_subqueries_window, all_subqueries.item.image)
				end
				if all_operators.count > 0 then
					from
						all_subqueries.forth
						all_operators.start
						i := 2
					until
						all_subqueries.after or else all_operators.after
					loop
						if all_subqueries.item.is_active then
							if active_query_window.count = 0 then
								op := ""
							else
								op := all_operators.item.actual_operator
							end
							create scrollable_subquery.make_normal (active_query_window, op, all_subqueries.item.image, i)
						else
							create scrollable_subquery.make_normal (inactive_subqueries_window, all_operators.item.actual_operator, all_subqueries.item.image, i)
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

feature {NONE} -- Attributes

	tool: EB_PROFILE_TOOL
			-- Tool as parent of Current

	container: EV_VERTICAL_BOX
			-- Widget containing all others

	query_box: EV_HORIZONTAL_BOX
			-- Form for the query

	active_query_frame,
			-- Frame for active query

	inactive_subqueries_frame: EV_FRAME
			-- Frame for inactive subqueries

	query_button_form: EV_VERTICAL_BOX
			-- Form with buttons allowing subqueries activation/inactivation

	change_operator_box: EV_HORIZONTAL_BOX
			-- Box for the subquery operator change buttons

	text_frame: EV_FRAME
			-- Form for the text window

	subquery_frame: EV_FRAME
			-- Frame for the subquery

	subquery_box: EV_VERTICAL_BOX
			-- Box for `subquery_text'

	button_box: EV_HORIZONTAL_BOX
			-- Box for the buttons

	change_operator_label: EV_LABEL
			-- Label for 'change_operator_button'

	text_window: EB_FORMATTED_TEXT
			-- Output text for the results

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

	set_or_operator_button: EV_BUTTON
			-- Button to set all the selected subqueries operators
			-- to 'or'

	inactive_subqueries_form: EV_VERTICAL_BOX
			-- Form for inactive subqueries

	add_box: EV_HORIZONTAL_BOX

	add_label,
			-- Label for adding an operator

	reactivate_label,
			-- Label for 'reactivate_button'

	inactivate_label: EV_LABEL
			-- Label for 'inactivate_button

	reactivate_button,
			-- Button to reactivate one or more subqueries

	inactivate_button: EV_BUTTON
			-- Button to inactivate one or more subqueries

	active_subqueries: INTEGER
			-- Number of active subqueries in all_subqueries

feature {EB_CHANGE_OPERATOR_CMD} -- Attributes

	active_query_window,
			--  Scrollable list of active subqueries

	inactive_subqueries_window: EV_LIST
			-- Scrollable list if inactive queries

feature {EB_ADD_SUBQUERY_CMD, EB_CHANGE_OPERATOR_CMD} -- Attributes

	subquery_text: EV_TEXT_FIELD
			-- Text field for eventual subqueries


	all_subqueries: LINKED_LIST[SUBQUERY]
			-- All the subqueries typed

	all_operators: LINKED_LIST[SUBQUERY_OPERATOR]
			-- All the subquery operators typed

feature {EB_RUN_QUERY_CMD} -- Attributes

	profiler_query: PROFILER_QUERY
			-- Query from which `profinfo' is the result

	profiler_options: PROFILER_OPTIONS
			-- Options used to generate `profinfo'

	profinfo: PROFILE_INFORMATION
			-- Set of information about profiled system, generated
			-- with help of `profiler_query' and `profiler_options'

feature {EB_CLOSE_QUERY_WINDOW_CMD} -- User Interface

	close is
			-- Close Current and update `tool'
		do
			hide
			destroy
			tool.query_window_is_closed (Current)
		end

feature {EB_ADD_SUBQUERY_CMD} -- Access

	subquery: STRING is
			-- Text typed in the subquery window
		do
			Result := subquery_text.text
		end

feature -- Commands

	run_query_cmd: EB_RUN_QUERY_CMD
			-- Command to run a subquery from Current

	save_result_cmd: EB_SAVE_RESULT_CMD
			-- Command to save the result of currently displayed query

	close_cmd: EB_CLOSE_QUERY_WINDOW_CMD
			-- Command to close Current

	add_subquery_cmd: EB_ADD_SUBQUERY_CMD
			-- Command to add a subquery

	change_operator_cmd: EB_CHANGE_OPERATOR_CMD
			-- Command to change subquery operators

feature {NONE} -- Implementation

	is_graphics_disabled: BOOLEAN is
			-- Is Graphics disabled for the text window?
		once 
			Result := Configure_resources.get_boolean (r_Graphics_disabled, False) 
		end

	count_active_subqueries is
			-- Number of active subqueries
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
		-- copy all the selected subqueries from `active_query_window'
		-- into `inactive_subqueries_window', inactivate the corresponding subqueries
		-- and operators in `all_subqueries' and `all_operators'
		local
			selected_subqueries: LINKED_LIST [EV_LIST_ITEM]
			selected_subquery: EB_SUBQUERY_ITEM
			i: INTEGER
		do
			selected_subqueries := active_query_window.selected_items
			from
				selected_subqueries.start
			until
				selected_subqueries.after
			loop
				selected_subquery ?= selected_subqueries.item
				i := selected_subquery.number			
					--| inactivate the subquery in 'all_subqueries'
				all_subqueries.go_i_th (i)
				all_subqueries.item.inactivate
					--| inactivate the operator in 'all_subquery_operators'
				if i > 1 then
					all_operators.go_i_th (i-1)
					all_operators.item.inactivate
				end					
				selected_subquery.set_parent (Void)					
				selected_subqueries.forth
			end
			if active_query_window.count > 0 then
				selected_subquery ?= active_query_window.get_item (1)
				i := selected_subquery.number			
				if i > 1 then
					all_operators.go_i_th (i-1)
					all_operators.item.inactivate					
				end
			end
			profiler_query.set_subqueries ( all_subqueries )
			profiler_query.set_subquery_operators ( all_operators )
			update_query_frame
		end

	reactivate is
		-- copy all the selected subqueries from `inactive_subqueries_window'
		-- into `active_query_window', activate the corresponding subqueries
		-- and operators in `all_subqueries' and `all_operators'
		local
			selected_subqueries: LINKED_LIST [EV_LIST_ITEM]
			selected_subquery: EB_SUBQUERY_ITEM
			i, smallest_active: INTEGER
			empty: BOOLEAN
				-- is `active_subquery_window' empty?
		do
			if inactive_subqueries_window.count > 0 then
				selected_subqueries := inactive_subqueries_window.selected_items
				empty := (active_query_window.count = 0)
				if not empty then
					selected_subquery ?= active_query_window.get_item (1)
					smallest_active := selected_subquery.number
				end
				from
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item

					i := selected_subquery.number			
						--| inactivate the subquery in 'all_subqueries'
					all_subqueries.go_i_th (i)
					all_subqueries.item.activate
						--| inactivate the operator in 'all_subquery_operators'
					if empty then
						smallest_active := i
					elseif i < smallest_active then
						all_operators.go_i_th (smallest_active - 1)
						all_operators.item.activate
						smallest_active := i
					else
						all_operators.go_i_th (i - 1)
						all_operators.item.activate
					end
					selected_subqueries.forth
				end
				profiler_query.set_subqueries ( all_subqueries )
				profiler_query.set_subquery_operators ( all_operators )
				update_query_frame
			end
		end

feature {NONE} -- Execution arguments

	reactivate_subqueries: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end
		
	inactivate_subqueries: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end
		
feature {NONE} -- execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- activate or not queries, depending on `arg'.
		do
			if arg = reactivate_subqueries then
				reactivate
			elseif arg = inactivate_subqueries then
				inactivate
			end
		end

end -- class EB_PROFILE_QUERY_WINDOW
