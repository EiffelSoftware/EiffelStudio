note
	description: "View of list of EIS details"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EIS_COMPONENT_VIEW [G]

inherit
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal,
			default_create,
			copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	ES_EIS_SHARED
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	ES_SHARED_DIALOG_BUTTONS
		export
			{NONE} all
		end

	HELP_CONTEXT_I
		redefine
			is_help_available
		end

	ES_EIS_HELP_PROVIDER_HELPER

	ES_EIS_NOTE_PICKER

	ES_HELP_REQUEST_BINDER
		export {ANY}
			show_help
		end

	EB_RECYCLABLE

	EV_SHARED_APPLICATION

feature -- HELP_CONTEXT_I, Access

	help_context_id: STRING_32
			-- <Precursor>
		local
			l_eis_entry: detachable EIS_ENTRY
		do
			if eis_grid.has_selected_row and then attached {EIS_ENTRY} eis_grid.selected_rows.i_th (1).data as l_entry then
				l_eis_entry := l_entry
			end
			if l_eis_entry /= Void and then attached l_eis_entry.source as l_src and then not l_src.is_empty then
				Result := l_src
			else
					-- Looks like the post condition is too strict.
				Result := {STRING_32} "No source specified."
			end
		end

	help_context_section: detachable HELP_CONTEXT_SECTION_I
			-- <Precursor>
		do
			if eis_grid.has_selected_row and then attached {EIS_ENTRY} eis_grid.selected_rows.i_th (1).data as l_entry then
				Result := create {HELP_SECTION_EIS_ENTRY}.make (l_entry, False)
			end
		end

	help_context_description: detachable STRING_32
			-- An optional description of the context.
		do
			if eis_grid.has_selected_row and then attached {EIS_ENTRY} eis_grid.selected_rows.i_th (1).data as l_entry then
				eis_output.process (l_entry)
				Result := eis_output.last_output_code
			end
		end

	help_provider: UUID
			-- <Precursor>
			-- Help provider computed from selected eis entry
		do
			if eis_grid.has_selected_row and then attached {EIS_ENTRY} eis_grid.selected_rows.i_th (1).data as l_eis_entry then
				Result := help_provider_from_protocol (l_eis_entry.protocol)
			else
				check entry_not_attached: False end
			end
		end

feature -- Operation

	display
			-- Display EIS entries in `eis_grid'.
		do
			wipe_out
			setup_base_grid
			setup_grid_from_component
			eis_grid.request_columns_auto_resizing
		end

	wipe_out
			-- Wipe out current view.
		do
			eis_grid.wipe_out
		end

	destroy
			-- Destroy the view
			-- Leave the EIS grid along.
		do
			recycle
		end

	refresh_grid
			-- Refresh the grid, sort according to session data if needed.
		do
			if not extracted_entries.is_empty then
				cached_column := sorting_column
				cached_descend := descend_order
				new_sorter.sort (extracted_entries)
			end
			eis_grid.remove_and_clear_all_rows
			compute_grid_rows
			eis_grid.redraw
		end

	refresh_grid_without_sorting
			-- Refresh the grid without sorting.
		do
			eis_grid.remove_and_clear_all_rows
			compute_grid_rows
			eis_grid.redraw
		end

	rebuild_and_refresh_grid
			-- Rebuild table from the component and refresh the grid.
		do
			eis_grid.remove_and_clear_all_rows
			setup_grid_from_component
			eis_grid.redraw
		end

	create_new_entry
			-- Create new EIS entry based on current component at the last row.
			-- Default to do nothing.
		require
			create_new_entry_possible: new_entry_possible
		do
		end

	delete_selected_entries
			-- Delete selected entries.
		do
		end

feature {NONE} -- Sorting

	new_sorter: DS_QUICK_SORTER [EIS_ENTRY]
			-- New sorter
		do
			create Result.make (create {AGENT_BASED_EQUALITY_TESTER [EIS_ENTRY]}.make (agent sort_entry))
		end

	sort_entry (u, v: EIS_ENTRY): BOOLEAN
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
			cached_column_set: cached_column > 0 and then cached_column <= eis_grid.column_count
		local
			type_u, type_v: NATURAL
		do
			inspect cached_column
			when column_target then
				if attached u.target_id as lt_id_u then
					if attached v.target_id as lt_id_v then
						type_u := id_solution.most_possible_type_of_id (lt_id_u)
						type_v := id_solution.most_possible_type_of_id (lt_id_v)
						if type_u = type_v then
								-- Type is the same, compare the name
							if type_u = id_solution.target_type then
								if attached id_solution.target_of_id (lt_id_u) as lt_target_u and then attached id_solution.target_of_id (lt_id_v) as lt_target_v then
									Result := lt_target_u.name < lt_target_v.name
								else
										-- Simply compare there ids.
									Result := lt_id_u > lt_id_v
								end
							else
								Result := id_solution.possible_name_of_id (lt_id_u) < id_solution.possible_name_of_id (lt_id_v)
							end
						else
								-- target > group > folder > class > feature
								-- type is implemented in the reservse way, so `<' is used.
							Result := id_solution.most_possible_type_of_id (lt_id_u) < id_solution.most_possible_type_of_id (lt_id_v)
						end
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_name then
				if attached u.name as lt_name_u then
					if attached v.name as lt_name_v then
						Result := lt_name_u < lt_name_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_protocol then
				if attached u.protocol as lt_protocol_u then
					if attached v.protocol as lt_protocol_v then
						Result := lt_protocol_u < lt_protocol_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_source then
				if attached u.source as lt_source_u then
					if attached v.source as lt_source_v then
						Result := lt_source_u < lt_source_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_tags then
				if attached u.tags_as_string as lt_tags_u then
					if attached v.tags_as_string as lt_tags_v then
						Result := lt_tags_u < lt_tags_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_override then
				Result := u.override or not v.override
				if descend_order then
					Result := not Result
				end
			when column_parameters then
				if attached u.parameters_as_string as lt_parameters_u then
					if attached v.parameters_as_string as lt_parameters_v then
						Result := lt_parameters_u < lt_parameters_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			else
				check no_more_column: False end
			end
		end

	cached_column: INTEGER
	cached_descend: BOOLEAN
			-- Cached sorting information

feature -- Query

	is_help_available: BOOLEAN
			--
		do
			Result := Precursor {HELP_CONTEXT_I} and then eis_grid.has_selected_row
		end

	same_view (a_view: ES_EIS_COMPONENT_VIEW [detachable ANY]): BOOLEAN
			-- Is current view focusing the same component as `a_view'?
		do
			if a_view /= Void then
				Result := component ~ a_view.component
			end
		end

	component_editable: BOOLEAN
			-- Is component editable?
		do
		end

	new_entry_possible: BOOLEAN
			-- Is creating entry possible for current view?	

feature -- Element Change

	set_eis_widget (a_widget: like eis_widget)
			-- Set `eis_widget' with `a_widget'.
		do
			eis_widget := a_widget
		ensure
			eis_widget_set: eis_widget = a_widget
		end

feature {NONE} -- Initialization

	setup_base_grid
			-- Setup basic attributes of the displaying grid.
		local
			l_grid: like eis_grid
			l_column: EV_GRID_COLUMN
		do
			l_grid := eis_grid
			l_grid.enable_multiple_row_selection
			register_action (l_grid.key_press_actions, agent on_key_pressed)
			register_action (l_grid.pointer_double_press_actions, agent on_pointer_double_pressed)
			l_grid.enable_partial_dynamic_content
			l_grid.set_dynamic_content_function (agent on_item_display)

			l_grid.set_column_count_to (numbers_of_column)
			l_grid.set_auto_resizing_column (column_target, True)
			l_grid.set_auto_resizing_column (column_name, True)
			l_grid.set_auto_resizing_column (column_protocol, True)
			l_grid.set_auto_resizing_column (column_source, True)

			l_column := l_grid.column (column_target)
			l_column.set_title (interface_names.l_target)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_target, ?, ?, ?, ?, ?, ?, ?, ?))

			l_column := l_grid.column (column_name)
			l_column.set_title (interface_names.l_name)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_name, ?, ?, ?, ?, ?, ?, ?, ?))

			l_column := l_grid.column (column_protocol)
			l_column.set_title (interface_names.l_protocol)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_protocol, ?, ?, ?, ?, ?, ?, ?, ?))

			l_column := l_grid.column (column_source)
			l_grid.column (column_source).set_title (interface_names.l_source)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_source, ?, ?, ?, ?, ?, ?, ?, ?))

			l_column := l_grid.column (column_tags)
			l_column.set_title (interface_names.l_tags)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_tags, ?, ?, ?, ?, ?, ?, ?, ?))

			l_column := l_grid.column (column_override)
			l_column.set_title (interface_names.l_override)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_override, ?, ?, ?, ?, ?, ?, ?, ?))

			l_column := l_grid.column (column_parameters)
			l_column.set_title (interface_names.l_parameters)
			register_action (l_column.header_item.pointer_button_press_actions, agent on_grid_header_click (column_parameters, ?, ?, ?, ?, ?, ?, ?, ?))
		end

	setup_grid_from_component
			-- Fill data into the displaying grid from given `component'.
		do
			create extracted_entries.make_from_array (new_extractor.eis_entries.linear_representation.to_array)
			cached_column := sorting_column
			cached_descend := descend_order
			new_sorter.sort (extracted_entries)
			compute_grid_rows
		ensure
			extracted_entries_not_void: extracted_entries /= Void
		end

	compute_grid_rows
			-- Compute number of grid rows
		local
			l_total_row: INTEGER
		do
			if extracted_entries /= Void then
				l_total_row := extracted_entries.count
			end
			if new_entry_possible then
				l_total_row := l_total_row + 1 -- Plus 1, the last row to add new entry which will be handled at `on_item_display'.
			end
			eis_grid.set_row_count_to (l_total_row)
		ensure
			eis_grid_row_count_set: (new_entry_possible implies eis_grid.row_count = extracted_entries.count + 1) and
									(not new_entry_possible implies eis_grid.row_count = extracted_entries.count)
		end

	new_extractor: ES_EIS_EXTRACTOR
			-- Create extractor
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Events

	on_grid_header_click (a_column_index: INTEGER; a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- On pointer pressed on grid header
		local
			l_session: SESSION_I
			l_column: INTEGER
			l_descend_order: BOOLEAN
		do
			if attached session_manager.service as l_session_service then
				l_session := l_session_service.retrieve (False)
				l_column := sorting_column
				l_descend_order := descend_order
				if l_column = a_column_index then
					l_session.set_value (not l_descend_order, eis_entry_grid_sorting_order_session_id)
				else
					l_session.set_value (a_column_index, eis_entry_grid_sorting_column_session_id)
					l_session.set_value (False, eis_entry_grid_sorting_order_session_id)
				end
			end
			refresh_grid
		end

	on_key_pressed (ev_key: EV_KEY)
			-- On `en_key' pressed
		do
			if ev_key.code = {EV_KEY_CONSTANTS}.key_enter then
				if
					new_entry_possible and then
					eis_grid.selected_rows.count = 1 and then
					eis_grid.row (eis_grid.row_count).is_selected
				then
					create_new_entry
				else
					if eis_grid.selected_rows.count = 1 then
						show_help
					end
				end
			elseif (ev_key.code = {EV_KEY_CONSTANTS}.key_left or ev_key.code = {EV_KEY_CONSTANTS}.key_right) and then component_editable then
				if
					eis_grid.has_selected_row and then
					attached eis_grid.selected_rows.first as l_row
				then
					l_row.item (1).activate
				end
			elseif ev_key.code = {EV_KEY_CONSTANTS}.key_delete then
				delete_selected_entries
			end
		end

	on_pointer_double_pressed (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER)
			-- process mouse click in the list
		do
			if new_entry_possible and then eis_grid.row (eis_grid.row_count).is_selected then
				create_new_entry
			else
				show_help
			end
		end

	on_item_display (a_column, a_row: INTEGER): EV_GRID_ITEM
			-- On item expose.
		local
			l_eis_entry: EIS_ENTRY
			l_entry_row_count: INTEGER
			l_editable: BOOLEAN
		do
			l_entry_row_count := eis_grid.row_count
			if new_entry_possible then
				l_entry_row_count := l_entry_row_count - 1
			end
			if a_row > 0 and a_row <= l_entry_row_count and attached extracted_entries as lt_entries then
					-- Retrieve corresponding EIS entry.
				l_eis_entry := lt_entries.item (a_row)
				check l_eis_entry_not_void: l_eis_entry /= Void end
					-- Connect the EIS entry to the line of the grid.
				if not attached {EIS_ENTRY} eis_grid.row (a_row).data as lt_entry then
					eis_grid.row (a_row).set_data (l_eis_entry)
				end

				l_editable := entry_editable (l_eis_entry, True)

				inspect a_column
				when column_target then
					Result := target_item_from_eis_entry (l_eis_entry, l_editable)
				when column_name then
					Result := name_item_from_eis_entry (l_eis_entry, l_editable)
				when column_protocol then
					Result := protocol_item_from_eis_entry (l_eis_entry, l_editable)
				when column_source then
					Result := source_item_from_eis_entry (l_eis_entry, l_editable)
				when column_tags then
						-- Tags
					Result := tags_item_from_eis_entry (l_eis_entry, l_editable)
				when column_override then
						-- Override
					Result := override_item_from_eis_entry (l_eis_entry, l_editable)
				when column_parameters then
						-- Parameters
					Result := parameters_item_from_eis_entry (l_eis_entry, l_editable)
				else
					check no_more_column: False end
				end
					-- Setup background colors
					-- Put a special backgroud color if the line of entry is from inherited.

				if attached background_color_of_entry (l_eis_entry) as lt_color then
					Result.set_background_color (lt_color)
				end
			elseif a_row = eis_grid.row_count and then new_entry_possible then
					-- New entry item in the last row.
				if a_column = column_target then
					create {EV_GRID_LABEL_ITEM}Result.make_with_text ("...")
				else
					create {EV_GRID_LABEL_ITEM}Result.make_with_text ("")
				end
			end
			if Result = Void then
				create Result
			end
		end

	activate_item (a_item: EV_GRID_ITEM; x, y, button: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32)
			-- Activate editable item.
		require
			a_item_not_void: a_item /= Void
			a_item_not_distoyed: not a_item.is_destroyed
			a_item_parented: a_item.is_parented
		do
			if a_item.is_selected then
				a_item.activate
			end
		end

feature {NONE} -- Item callbacks

	on_name_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On name changed
		do
		end

	on_protocol_changed (a_choice_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM; a_item: EB_GRID_LISTABLE_CHOICE_ITEM): BOOLEAN
			-- On protocol changed
		do
		end

	on_source_changed (a_value: READABLE_STRING_32; a_item: EV_GRID_ITEM)
			-- On source changed
		do
		end

	on_override_changed (a_item: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- On override changed
		do
		end

	on_tags_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On tags changed
		do
		end

	on_parameters_changed (a_item: EV_GRID_EDITABLE_ITEM)
			-- On parameters changed
		do
		end

feature {ES_EIS_COMPONENT_VIEW} -- Access

	component: G
			-- The focusing component

	background_color_of_entry (a_entry: EIS_ENTRY): EV_COLOR
			-- Background color of `a_entry'
		require
			a_entry_not_void: a_entry /= Void
		do
		end

feature {NONE} -- Access

	eis_grid: ES_EIS_ENTRY_GRID
			-- Grid to display EIS entries

	extracted_entries: DS_ARRAYED_LIST [EIS_ENTRY]
			-- Cached list of entries to display

	sorting_column: INTEGER
			-- Sorting column
		local
			l_session: SESSION_I
		do
			if attached session_manager.service as l_session_service then
				l_session := l_session_service.retrieve (False)
				if attached {INTEGER_REF} l_session.value_or_default (eis_entry_grid_sorting_column_session_id, False) as lt_column then
					Result := lt_column.item
				end
			end
			if Result = 0 then
					-- Default to target column
				Result := column_target
			end
		end

	descend_order: BOOLEAN
			-- Descend? Or ascend order
			-- Default is ascend
		local
			l_session: SESSION_I
		do
			if attached session_manager.service as l_session_service then
				l_session := l_session_service.retrieve (False)
				if attached {BOOLEAN_REF} l_session.value_or_default (eis_entry_grid_sorting_order_session_id, False) as lt_order then
					Result := lt_order.item
				end
			end
		end

	eis_widget: detachable ES_EIS_TOOL_WIDGET
			-- The widget for Info tool

feature {NONE} -- Recycling

	internal_recycle
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	tab_to_next (a_key: EV_KEY)
		local
			i, l_count, l_row_index: INTEGER
			l_found: BOOLEAN
			l_old_data: ANY
		do
			if
				a_key.code = {EV_KEY_CONSTANTS}.key_tab and then
				attached eis_grid.activated_item as l_item and then
				attached l_item.row as l_row
			then
				from
					l_count := l_row.count
					i := 1
				until
					i > l_count or l_found
				loop
					if l_row.item (i) = l_item then
						l_found := True
					end
					i := i + 1
				end
				if l_found then
					l_row_index := l_row.index
					l_old_data := l_row.data
					l_item.deactivate
						-- Do it on idle in order to make sure the tree has been refreshed completely.
						-- Otherwise the data could no be ready.
					ev_application.do_once_on_idle (
						agent (a_row_index: INTEGER; a_old_data: ANY; a_shift: BOOLEAN; a_item_index: INTEGER)
						local
							l_new_row: EV_GRID_ROW
							j, l_c_count: INTEGER
							l_activated: BOOLEAN
						do
								-- Get the new row instance, as the grid might be refreshed.
							if a_row_index <= eis_grid.row_count then
								l_new_row := eis_grid.row (a_row_index)
								l_c_count := l_new_row.count
								if
									attached {EIS_ENTRY} a_old_data as l_o and then
									attached {EIS_ENTRY}l_new_row.data as l_n and then
									l_o.same_entry (l_n)
								then
									j := a_item_index
									if a_shift then
										from
											j := j - 1
										until
											j < 1 or l_activated
										loop
											if
												attached {ES_EIS_GRID_EDITABLE_ITEM} l_new_row.item (j) or else
												attached {EB_GRID_LISTABLE_CHOICE_ITEM} l_new_row.item (j) or else
												attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_new_row.item (j)
											then
												l_new_row.item (j).activate
												l_activated := True
											end
											j := j - 1
										end
									else
										from
											j := j + 1
										until
											j > l_c_count or l_activated
										loop
											if
												attached {ES_EIS_GRID_EDITABLE_ITEM} l_new_row.item (j) or else
												attached {EB_GRID_LISTABLE_CHOICE_ITEM} l_new_row.item (j) or else
												attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_new_row.item (j)
											then
												l_new_row.item (j).activate
												l_activated := True
											end
											j := j + 1
										end
									end
								end
							end
						end (l_row_index, l_old_data, ev_application.shift_pressed, i - 1)
					)
				end
			end
		end

	update_tree_item
			-- Update tree item
		do
			if attached eis_widget as l_w and then attached l_w.tree as l_tree then
				l_tree.render_information_sign_for_selected_node
			end
		end

	frozen session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service {SESSION_MANAGER_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Validation

	is_name_valid (a_name: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN
			-- Can `a_name' be changed in `a_item'?
		do
			if a_item.is_parented and then attached {EIS_ENTRY} a_item.row.data as lt_entry then
				Result := entry_editable (lt_entry, False)
			end
		end

	is_protocol_valid (a_protocol: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN
			-- Can `a_protocol' be changed in `a_item'?
		do
			if a_item.is_parented and then attached {EIS_ENTRY} a_item.row.data as lt_entry then
				Result := entry_editable (lt_entry, False)
			end
		end

	is_source_valid (a_source: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN
			-- Can `a_source' be changed in `a_item'?
		do
			if a_item.is_parented and then attached {EIS_ENTRY} a_item.row.data as lt_entry then
				Result := entry_editable (lt_entry, False)
			end
		end

	is_tags_valid (a_tags: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN
			-- Can `a_tags' be changed in `a_item'?
		do
			if a_item.is_parented and then attached {EIS_ENTRY} a_item.row.data as lt_entry then
				Result := entry_editable (lt_entry, False)
			end
		end

	is_parameters_valid (a_parameters: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN
			-- Can `a_parameters' be changed in `a_item'?
		do
			if a_item.is_parented and then attached {EIS_ENTRY} a_item.row.data as lt_entry then
				Result := entry_editable (lt_entry, False)
			end
		end

	entry_editable (a_entry: EIS_ENTRY; a_use_cache: BOOLEAN): BOOLEAN
			-- If `a_entry' is editable through current view?
		require
			a_entry_not_void: a_entry /= Void
		do
		end

feature {NONE} -- Grid items

	name_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of name from an EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		local
			l_name: STRING_32
			l_editable_item: ES_EIS_GRID_EDITABLE_ITEM
		do
			l_name := a_entry.name
			if l_name = Void then
				create l_name.make_empty
			end
			if a_editable then
				create l_editable_item.make_with_text (l_name)
				l_editable_item.pointer_button_press_actions.extend (agent activate_item (l_editable_item, ?, ?, ?, ?, ?, ?, ?, ?))
				l_editable_item.set_text_validation_agent (agent is_name_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_name_changed (l_editable_item))
				l_editable_item.set_key_press_action (agent tab_to_next)
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_name)
			end
		ensure
			Result_not_void: Result /= Void
		end

	protocol_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of protocol from an EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		local
			l_protocol: STRING_32
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_item_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
			l_list: ARRAYED_LIST [EB_GRID_LISTABLE_CHOICE_ITEM_ITEM]
			l_selected: BOOLEAN
		do
			l_protocol := a_entry.protocol
			if l_protocol = Void then
				create l_protocol.make_empty
			end
			if a_editable then
				l_editable_item := new_listable_item
				l_editable_item.set_choice_list_key_press_action (agent tab_to_next)
				create l_list.make (known_protocols.count + 1)

					-- Create protocol choice list
				across
					known_protocols as l_c
				loop
					token_writer.new_line
					token_writer.process_basic_text (l_c.item)
					l_line := token_writer.last_line
					create l_e_com.make (l_line.content, 0)
					create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<l_e_com >>))
					l_item_item.set_data (l_c.item)
					l_list.extend (l_item_item)
						-- Set the selected item
					if l_protocol.is_case_insensitive_equal (l_c.item) then
						l_editable_item.set_list_item (l_item_item)
						l_selected := True
					end
				end

				if not l_selected then
						-- Extend the written protocol which is unknown
					token_writer.new_line
					token_writer.process_basic_text (l_protocol)
					l_line := Token_writer.last_line
					create l_e_com.make (l_line.content, 0)
					create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<l_e_com >>))
					l_item_item.set_data (l_protocol)
					l_list.put_front (l_item_item)
						-- Set the selected item
					l_editable_item.set_list_item (l_item_item)
				end

				l_editable_item.set_item_components (l_list)
				Result := l_editable_item
				if attached l_editable_item.item_components as c and then c.upper > c.lower then
					l_editable_item.pointer_button_press_actions.extend (agent activate_item (l_editable_item, ?, ?, ?, ?, ?, ?, ?, ?))
					l_editable_item.set_selection_changing_action (agent on_protocol_changed (?, l_editable_item))
				end
			else
				create {EV_GRID_LABEL_ITEM} Result.make_with_text (l_protocol)
			end
		ensure
			Result_not_void: Result /= Void
		end

	source_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of source from an EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		local
			l_source: STRING_32
			l_file_prop: ES_EIS_FILE_PROPERTY
		do
			l_source := a_entry.source
			if l_source = Void then
				create l_source.make_empty
			end
			if a_editable then
				create l_file_prop.make (once "", variable_provider_from_entry (a_entry))
				l_file_prop.set_value (l_source)
				l_file_prop.change_value_actions.extend (agent on_source_changed (?, l_file_prop))
				l_file_prop.set_text_validation_agent (agent is_source_valid (?, l_file_prop))
				l_file_prop.key_press_actions.extend (agent tab_to_next)
				Result := l_file_prop
			else
				create {EV_GRID_LABEL_ITEM} Result.make_with_text (l_source)
			end
		ensure
			Result_not_void: Result /= Void
		end

	tags_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of tags from an EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		local
			l_tags: STRING_32
			l_editable_item: ES_EIS_GRID_EDITABLE_ITEM
		do
			l_tags := eis_output.tags_as_code (a_entry)
			if a_editable then
				create l_editable_item.make_with_text (l_tags)
				l_editable_item.pointer_button_press_actions.extend (agent activate_item (l_editable_item, ?, ?, ?, ?, ?, ?, ?, ?))
				l_editable_item.set_text_validation_agent (agent is_tags_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_tags_changed (l_editable_item))
				l_editable_item.set_key_press_action (agent tab_to_next)
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_tags)
			end
		ensure
			Result_not_void: Result /= Void
		end

	override_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of override from an EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		do
			create {EV_GRID_LABEL_ITEM} Result.make_with_text ("-")
		ensure
			Result_not_void: Result /= Void
		end

	parameters_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of parameters from an EIS entry.
		require
			a_entry_not_void: a_entry /= Void
		local
			l_parameters: STRING_32
			l_editable_item: ES_EIS_GRID_EDITABLE_ITEM
		do
			l_parameters := eis_output.parameters_as_code (a_entry)
			if a_editable then
				create l_editable_item.make_with_text (l_parameters)
				l_editable_item.pointer_button_press_actions.extend (agent activate_item (l_editable_item, ?, ?, ?, ?, ?, ?, ?, ?))
				l_editable_item.set_text_validation_agent (agent is_parameters_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_parameters_changed (l_editable_item))
				l_editable_item.set_key_press_action (agent tab_to_next)
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_parameters)
			end
		ensure
			Result_not_void: Result /= Void
		end

	target_item_from_eis_entry (a_entry: EIS_ENTRY; a_editable: BOOLEAN): EV_GRID_ITEM
			-- Grid item of target from an EIS entry
		require
			a_entry_not_void: a_entry /= Void
		local
			l_type: NATURAL
			l_target: CONF_TARGET
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_feature: E_FEATURE
			l_editor_token_item: ES_GRID_LIST_ITEM
		do
			if attached a_entry.target_id as lt_id then
				token_writer.new_line
				l_type := id_solution.most_possible_type_of_id (lt_id)
				if l_type = id_solution.target_type then
					l_target := id_solution.target_of_id (lt_id)
					l_editor_token_item := target_editor_token_for_target (l_target)
				elseif l_type = id_solution.group_type then
					l_group := id_solution.group_of_id (lt_id)
					l_editor_token_item := group_editor_token_for_target (l_group)
				elseif l_type = id_solution.folder_type then
						-- Should never get a folder type here.
					l_folder := id_solution.folder_of_id (lt_id)
					l_editor_token_item := folder_editor_token_for_target (l_folder)
				elseif l_type = id_solution.class_type then
					if attached {CLASS_I} id_solution.class_of_id (lt_id) as l_class then
						l_editor_token_item := class_editor_token_for_target (l_class, not a_entry.is_auto)
					end
				elseif l_type = id_solution.feature_type then
					l_feature := id_solution.feature_of_id (lt_id)
					l_editor_token_item := feature_editor_token_for_target (l_feature, id_solution.last_feature_name, not a_entry.is_auto)
				end
				Result := l_editor_token_item
				if not attached Result then
					create {EV_GRID_LABEL_ITEM} Result
				end
			else
				create {EV_GRID_LABEL_ITEM} Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	new_listable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			-- New listable item
		do
			create Result
			Result.set_component_padding (1)
			Result.set_left_border (1)
			Result.set_bottom_border (1)
			Result.set_border_line_color (eis_grid.separator_color)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Target token

	target_editor_token_for_target (a_item: CONF_TARGET): ES_GRID_LIST_ITEM
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_item_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.process_target_name_text (a_item.name, a_item)
				l_editable_item := new_listable_item
				Result := l_editable_item
				create l_e_com.make (token_writer.last_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array ({ARRAY [ES_GRID_ITEM_COMPONENT]} <<target_pixmap_component, l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
				l_editable_item.set_choice_list_key_press_action (agent tab_to_next)
			else
				create Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	group_editor_token_for_target (a_item: CONF_GROUP): ES_GRID_LIST_ITEM
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_item_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.add_group (a_item, a_item.name)
				l_editable_item := new_listable_item
				create l_e_com.make (token_writer.last_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array ({ARRAY [ES_GRID_ITEM_COMPONENT]} <<group_pixmap_component (a_item), l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
				l_editable_item.set_choice_list_key_press_action (agent tab_to_next)
			end
			Result := l_editable_item
			if not attached Result then
				create Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	folder_editor_token_for_target (a_item: EB_FOLDER): ES_GRID_LIST_ITEM
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_item_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.process_folder_text (a_item.name, a_item.path, a_item.cluster)
				l_editable_item := new_listable_item
				Result := l_editable_item
				create l_e_com.make (token_writer.last_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array ({ARRAY [ES_GRID_ITEM_COMPONENT]} <<folder_pixmap_component, l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
				l_editable_item.set_choice_list_key_press_action (agent tab_to_next)
			else
				create Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	class_editor_token_for_target (a_item: CLASS_I; a_editable: BOOLEAN): ES_GRID_LIST_ITEM
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_item_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.add_class (a_item)
				l_editable_item := new_listable_item
				create l_e_com.make (token_writer.last_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array ({ARRAY [ES_GRID_ITEM_COMPONENT]} <<class_pixmap_component (a_item), l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
				l_editable_item.set_choice_list_key_press_action (agent tab_to_next)
			end
			Result := l_editable_item
			if not attached Result then
				create Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	feature_editor_token_for_target (a_item: E_FEATURE; a_name: STRING; a_editable: BOOLEAN): ES_GRID_LIST_ITEM
			-- Create editor token for loaction accordingly.
		require
			a_item_void_implies_a_name_not_void: a_item = Void implies a_name /= Void
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_item_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
			l_component: ES_GRID_PIXMAP_COMPONENT
		do
			if a_item /= Void then
				l_component := feature_pixmap_component (a_item)
			else
				l_component := uncompiled_feature_pixmap_component
			end
			token_writer.new_line
			if a_item /= Void then
				token_writer.add_sectioned_feature_name (a_item)
			else
				token_writer.process_basic_text (encoding_converter.utf8_to_utf32 (a_name))
			end
			l_editable_item := new_listable_item
			create l_e_com.make (token_writer.last_line.content, 0)
			create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array ({ARRAY [ES_GRID_ITEM_COMPONENT]} <<l_component, l_e_com>>))
			l_item_item.set_data (a_item)
			l_editable_item.set_list_item (l_item_item)
			l_editable_item.set_choice_list_key_press_action (agent tab_to_next)
			Result := l_editable_item
			if not attached Result then
				create Result
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Pixmap component

	target_pixmap_component: ES_GRID_PIXMAP_COMPONENT
			-- Target pixmap component
		do
			create Result.make (pixmaps.icon_pixmaps.folder_target_icon)
		ensure
			Result_not_void: Result /= Void
		end

	group_pixmap_component (a_group: CONF_GROUP): ES_GRID_PIXMAP_COMPONENT
			-- Group pixmap component
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (icon_factory.pixmap_from_group (a_group))
		ensure
			Result_not_void: Result /= Void
		end

	folder_pixmap_component: ES_GRID_PIXMAP_COMPONENT
			-- Folder pixmap component
		do
			create Result.make (pixmaps.icon_pixmaps.folder_blank_icon)
		ensure
			Result_not_void: Result /= Void
		end

	class_pixmap_component (a_class: CLASS_I): ES_GRID_PIXMAP_COMPONENT
			-- Class pixmap component
		do
			create Result.make (icon_factory.pixmap_from_class_i (a_class))
		ensure
			Result_not_void: Result /= Void
		end

	feature_pixmap_component (a_feature: E_FEATURE): ES_GRID_PIXMAP_COMPONENT
			-- Feature pixmap component
		require
			a_feature_not_void: a_feature /= Void
		do
			create Result.make (icon_factory.pixmap_from_e_feature (a_feature))
		ensure
			Result_not_void: Result /= Void
		end

	uncompiled_feature_pixmap_component: ES_GRID_PIXMAP_COMPONENT
			-- Uncompiled feature pixmap component
		do
			create Result.make (pixmaps.icon_pixmaps.feature_obsolete_routine_icon)
		end

feature {NONE} -- Session IDs

	eis_entry_grid_sorting_column_session_id: STRING_8 = "com.eiffel.eis_tool.entry_grid_sorting_column"

	eis_entry_grid_sorting_order_session_id: STRING_8 = "com.eiffel.eis_tool.entry_grid_sorting_order"

feature {NONE} -- Provider protocols

	variable_provider_from_entry (a_entry: EIS_ENTRY): COMPLETION_POSSIBILITIES_PROVIDER
			-- Completion possiblity provider from `a_entry'
		require
			a_entry_not_void: a_entry /= Void
		do
			create {ES_EIS_VARIABLE_PROVIDER} Result.make_from_entry (a_entry)
		end

	known_protocols: ARRAYED_LIST [STRING_32]
			-- Known EIS protocols
		once
			if {PLATFORM}.is_windows then
				create Result.make (3)
				Result.extend ({STRING_32} "URI")
				Result.extend ({STRING_32} "PDF")
				Result.extend ({STRING_32} "DOC")
			else
				create Result.make (1)
				Result.extend ({STRING_32} "URI")
			end
		end

feature {NONE} -- Column constants

	column_target: INTEGER = 1
	column_source: INTEGER = 2
	column_parameters: INTEGER = 3
	column_protocol: INTEGER = 4
	column_name: INTEGER = 5
	column_tags: INTEGER = 6
	column_override: INTEGER = 7
	numbers_of_column: INTEGER = 7;

invariant
	component_not_void: component /= Void
	eis_grid_not_void: eis_grid /= Void

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
