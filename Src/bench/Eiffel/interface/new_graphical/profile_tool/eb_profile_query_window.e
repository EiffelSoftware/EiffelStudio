indexing
	description	: "Window to display results from a query."
	author		: "Christophe BONNARD, Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILE_QUERY_WINDOW

inherit
	EV_TITLED_WINDOW

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_QUERY_VALUES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_default

feature {NONE} -- Initialization

	make_default is
			-- Create Current.
		do
			default_create
			set_title (Interface_names.t_Profile_query_window)
			set_icon_pixmap (Pixmaps.Icon_profiler_window)

			create all_subqueries.make
			create all_operators.make

			init_commands
			build_interface
			resize_actions.extend (agent resize_columns)
		end
		
	init_commands is
			-- Initialize the commands
		do
			create run_query_cmd.make (Current)
			create save_result_cmd.make (Current)
		end
		
	resize_columns (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Resize the columns for the active & inactive query lists
		do
			active_query_window.set_column_width (active_query_window.width, 1)
			inactive_subqueries_window.set_column_width (inactive_subqueries_window.width, 1)
		end
		
	build_interface is
			-- Build the user interface.
		local
			editor_window: EB_CLICKABLE_EDITOR
			container: EV_VERTICAL_BOX			-- Widget containing all others
			query_box: EV_HORIZONTAL_BOX		-- Form for the query
			subquery_box: EV_HORIZONTAL_BOX		-- Box for `subquery_text'
			query_button_form: EV_VERTICAL_BOX	-- Form with buttons allowing subqueries activation/inactivation
			text_frame: EV_FRAME				-- Form for the text window
			subquery_frame: EV_FRAME			-- Frame for the subquery
			button_box: EV_HORIZONTAL_BOX		-- Box for the buttons
			--| FIXME help_button: EV_BUTTON	-- Button for `help'
			run_button: EV_BUTTON 				-- Button for `run_subquery_cmd'
			save_as_button: EV_BUTTON			-- Button for `save_result_cmd'
			close_button: EV_BUTTON				-- Button to close Current
			add_or_operator_button: EV_BUTTON	-- Button to add a subquery with 'or' operator
			add_and_operator_button: EV_BUTTON	-- Button to add a subquery with 'and' operator
			set_and_operator_button: EV_BUTTON	-- Button to set all the selected subqueries operators to 'and'
			set_or_operator_button: EV_BUTTON	-- Button to set all the selected subqueries operators to 'or'
			reactivate_button: EV_BUTTON		-- Button to reactivate one or more subqueries
			inactivate_button: EV_BUTTON		-- Button to inactivate one or more subqueries
		do
				--| Create the Active & Inactive list
			create active_query_window
			active_query_window.enable_multiple_selection
			active_query_window.set_column_title (Interface_names.l_Active_query, 1)
			create inactive_subqueries_window
			inactive_subqueries_window.enable_multiple_selection
			inactive_subqueries_window.set_column_title (Interface_names.l_Inactive_subqueries, 1)

				--| Query buttons (Activate, Inactivate, Or, And)
			create reactivate_button.make_with_text_and_action ("< Activate", agent reactivate)
			create inactivate_button.make_with_text_and_action ("Inactivate >", agent inactivate)
			create set_or_operator_button.make_with_text_and_action (Interface_names.b_Or, agent change_operator ("or"))
			create set_and_operator_button.make_with_text_and_action (Interface_names.b_And, agent change_operator ("and"))
			create query_button_form
			query_button_form.set_padding (Layout_constants.Small_border_size)
			extend_button (query_button_form, reactivate_button)
			extend_button (query_button_form, inactivate_button)
			extend_button (query_button_form, set_or_operator_button)
			extend_button (query_button_form, set_and_operator_button)
			query_button_form.extend (create {EV_CELL}) -- Expandable item

				--| Query box (contain Active Query, Add/Remove Buttons, Inactive Subqueries)
			create query_box
			query_box.set_padding (Layout_constants.Small_border_size)
			query_box.extend (active_query_window) -- expandable item
			query_box.extend (query_button_form)
			query_box.disable_item_expand (query_button_form)
			query_box.extend (inactive_subqueries_window) -- expandable item

				--| Subquery frame
			create add_and_operator_button.make_with_text_and_action (Interface_names.b_And, agent add_subquery ("and"))
			create add_or_operator_button.make_with_text_and_action (Interface_names.b_Or, agent add_subquery ("or")) 
			create subquery_text

			create subquery_box
			subquery_box.set_border_width (Layout_constants.Small_border_size)
			subquery_box.set_padding (Layout_constants.Small_border_size)
			subquery_box.extend (subquery_text) -- expandable item
			extend_button (subquery_box, add_and_operator_button)
			extend_button (subquery_box, add_or_operator_button)

			create subquery_frame.make_with_text (Interface_names.l_Subquery)
			subquery_frame.extend (subquery_box)

				--| Result display
			create editor_window.make (Void)
			editor_window.set_tabulation_size (12)
			editor_window.disable_editable
			text_window := editor_window
			create text_frame
			text_frame.set_minimum_width (Layout_constants.Dialog_unit_to_pixels(100))
			text_frame.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_lowered)
			text_frame.extend (editor_window.widget)

				--| Build button bar
			--|FIXME: Put the Help button back when help is available.
			--|FIXME create help_button.make_with_text (Interface_names.b_Help)
			create run_button.make_with_text_and_action (Interface_names.b_Update, agent run_query_cmd.execute)
			create save_as_button.make_with_text_and_action (Interface_names.b_Save, agent save_result_cmd.execute)
			create close_button.make_with_text_and_action (Interface_names.b_Close, agent close)
			create button_box
			button_box.set_border_width (Layout_constants.Small_border_size)
			button_box.set_padding (Layout_constants.Small_border_size)
			--| FIXME extend_button (button_box, help_button)
			button_box.extend (create {EV_CELL}) -- expandable item
			extend_button (button_box, run_button)
			extend_button (button_box, save_as_button)
			extend_button (button_box, close_button)

				--| Build forms
			create container
			container.set_padding (Layout_constants.Small_padding_size)
			container.set_border_width (Layout_constants.Small_border_size)
			container.extend (query_box)
			container.disable_item_expand (query_box)
			container.extend (subquery_frame)
			container.disable_item_expand (subquery_frame)
			container.extend (text_frame) -- expandable item
			container.extend (button_box)
			container.disable_item_expand (button_box)
			extend (container)

				--| Sizing
			set_window_size
		end

feature {EB_SAVE_RESULT_CMD} -- Save commands

	save_it (ptf: RAW_FILE) is
			-- Save window content in `ptf'.
		do
			ptf.create_read_write
			ptf.putstring ("Options:%N========%N")
			ptf.putstring (profiler_options.image)
			ptf.putstring ("%NQuery:%N======%N")
			ptf.putstring (profiler_query.image)
			ptf.putstring ("%NResults:%N========%N")
			ptf.putstring (text_window.text)
			ptf.new_line
			ptf.close
		end

feature -- Status Setting

	set_window_size is
			-- Set window size, according to preferences.
		do
--| FIXME ARNAUD: To be fixed (Save window size into preferences and restore it)
			set_size (Layout_constants.Dialog_unit_to_pixels(600), Layout_constants.Dialog_unit_to_pixels(500))
--| END FIXME ARNAUD.
		end

	update_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; pi: PROFILE_INFORMATION) is
			-- Update User Interface Widgets to reflect the parameters:
			-- This window will be associated with `pq', will
			-- use `po' and `profinfo', and display `st'.
		do
			profiler_query := pq
			profiler_options := po
			profinfo := pi

			count_active_subqueries
			if profiler_query.subqueries.count > active_subqueries then
				from
					profiler_query.subqueries.go_i_th (active_subqueries + 1)
					profiler_query.subquery_operators.go_i_th (active_subqueries)
					if profiler_query.subquery_operators.before then
						profiler_query.subquery_operators.forth
					end
				until
					profiler_query.subqueries.after 
				loop
					all_subqueries.extend (profiler_query.subqueries.item)
					profiler_query.subqueries.forth
					if not profiler_query.subquery_operators.after then
						all_operators.extend (profiler_query.subquery_operators.item)
						profiler_query.subquery_operators.forth
					end
				end
			end

			update_query_frame
			subquery_text.remove_text
			text_window.clear_window
			text_window.process_text (st)
			text_window.set_position (1)
			text_window.disable_editable
		end

feature -- Update

	update_graphical_resources is
			-- Update the graphical resources.
		do
			text_window.clear_window
			run_query_cmd.execute
		end

	update_query_frame is
			-- Refresh active and inactive subquery frames.
		local
			i : INTEGER
			scrollable_subquery: EB_SUBQUERY_ITEM
			op: STRING
		do
			active_query_window.wipe_out
			inactive_subqueries_window.wipe_out
			if all_subqueries.count > 0 then
				all_subqueries.start
				create scrollable_subquery.make_first (all_subqueries.item.image)
				if all_subqueries.item.is_active then
					active_query_window.extend (scrollable_subquery)
				else
					inactive_subqueries_window.extend (scrollable_subquery)
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
							create scrollable_subquery.make_normal (op, all_subqueries.item.image, i)
							active_query_window.extend (scrollable_subquery)
						else
							create scrollable_subquery.make_normal (all_operators.item.actual_operator, all_subqueries.item.image, i)
							inactive_subqueries_window.extend (scrollable_subquery)
						end
						all_subqueries.forth
						all_operators.forth
						i := i + 1
					end							
				end
			end
		end

	update_profiler_query is
			-- Refresh `profiler_query' according to changes made on subquery list
		do
			profiler_query.set_subqueries (all_subqueries)
			profiler_query.set_subquery_operators (all_operators)
		end

feature {NONE} -- Attributes

	text_window: EB_FORMATTED_TEXT
			-- Output text for the results

	active_subqueries: INTEGER
			-- Number of active subqueries in all_subqueries

feature {EB_CHANGE_OPERATOR_CMD} -- Attributes

	active_query_window: EV_MULTI_COLUMN_LIST
			--  Scrollable list of active subqueries

	inactive_subqueries_window: EV_MULTI_COLUMN_LIST
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
			-- Close Current and update `parent'
		do
			destroy
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

feature {NONE} -- Implementation

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
			-- Copy all the selected subqueries from `active_query_window'
			-- into `inactive_subqueries_window', inactivate the corresponding subqueries
			-- and operators in `all_subqueries' and `all_operators'
		local
			selected_subqueries: DYNAMIC_LIST  [EV_MULTI_COLUMN_LIST_ROW]
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
				selected_subqueries.forth
			end
			if active_query_window.count > 0 then
				selected_subquery ?= active_query_window.first
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
			-- Copy all the selected subqueries from `inactive_subqueries_window'
			-- into `active_query_window', activate the corresponding subqueries
			-- and operators in `all_subqueries' and `all_operators'
		local
			selected_subqueries: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			selected_subquery: EB_SUBQUERY_ITEM
			i, smallest_active: INTEGER
			is_window_empty: BOOLEAN
				-- is `active_subquery_window' empty?
		do
			if inactive_subqueries_window.count > 0 then
				selected_subqueries := inactive_subqueries_window.selected_items
				is_window_empty := (active_query_window.count = 0)
				if not is_window_empty then
					selected_subquery ?= active_query_window.first
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
					if is_window_empty then
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

feature {NONE} -- execution

	add_subquery (string_arg: STRING) is
			-- Add subquery to list of subqueries.
			-- Subquery operator is given by `string_arg'.
		local
			parser: EB_QUERY_PARSER
			txt: STRING
			operator: SUBQUERY_OPERATOR
			error_dialog: EV_WARNING_DIALOG
		do
			txt := subquery
			if txt /= Void and then not txt.is_empty then 
				clear_values
				create parser
				if parser.parse (txt, Current) then
					all_subqueries.append (subqueries)
					create operator.make (string_arg)
					all_operators.extend (operator)
					all_operators.append (subquery_operators)
					update_query_frame
					subquery_text.remove_text
				else
					create error_dialog.make_with_text (Warning_messages.w_Profiler_bad_query)
					error_dialog.show_modal_to_window (Current)
				end
			end
		end

	change_operator (string_arg: STRING) is
			-- Change selected subqueries
			-- operators according to `string_arg'.
		local
			selected_subqueries: DYNAMIC_LIST  [EV_MULTI_COLUMN_LIST_ROW]
			selected_subquery: EB_SUBQUERY_ITEM
		do
			if active_query_window.count > 0 then
				from
					selected_subqueries := active_query_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end
					if selected_subquery.number > 1 then
						all_operators.go_i_th (selected_subquery.number - 1)
						all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			if inactive_subqueries_window.count > 0 then
				from
					selected_subqueries := inactive_subqueries_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end	
					if selected_subquery.number > 1 then
						all_operators.go_i_th (selected_subquery.number - 1)
						all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			update_query_frame
		end

end -- class EB_PROFILE_QUERY_WINDOW
