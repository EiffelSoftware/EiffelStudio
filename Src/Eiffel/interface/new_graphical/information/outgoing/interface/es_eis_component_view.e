indexing
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
			help_provider,
			is_help_available
		end

	ES_EIS_HELP_PROVIDER_HELPER

	ES_EIS_NOTE_PICKER

	ES_HELP_REQUEST_BINDER

	EB_RECYCLABLE

feature -- HELP_CONTEXT_I, Access

	help_context_id: !STRING_GENERAL
			-- <Precursor>
		local
			l_eis_entry: EIS_ENTRY
		do
			l_eis_entry ?= eis_grid.selected_rows.i_th (1).data
			if l_eis_entry /= Void and then {lt_src: STRING_GENERAL}l_eis_entry.source and then not lt_src.is_empty then
				Result := lt_src
			else
					-- Looks like the post condition is too strict.
				Result := "No source specified."
			end
		end

	help_context_section: ?HELP_CONTEXT_SECTION_I
			-- <Precursor>
		do
			if {lt_entry: EIS_ENTRY}eis_grid.selected_rows.i_th (1).data then
				Result := create {HELP_SECTION_EIS_ENTRY}.make (lt_entry)
			else
				check entry_not_attached: False end
			end
		end

	help_context_description: ?STRING_GENERAL
			-- An optional description of the context.
		do
			if {lt_entry: EIS_ENTRY}eis_grid.selected_rows.i_th (1).data then
				eis_output.process (lt_entry)
				Result := eis_output.last_output_code
			end
		end

	help_provider: !UUID
			-- <Precursor>
			-- Help provider computed from selected eis entry
		local
			l_eis_entry: EIS_ENTRY
		do
			l_eis_entry ?= eis_grid.selected_rows.i_th (1).data
			if l_eis_entry /= Void then
				Result := help_provider_from_protocol (l_eis_entry.protocol)
			else
				check entry_not_attached: False end
			end
		end

feature -- Operation

	display is
			-- Display EIS entries in `eis_grid'.
		do
			wipe_out
			setup_base_grid
			setup_grid_from_component
		end

	wipe_out is
			-- Wipe out current view.
		do
			eis_grid.wipe_out
		end

	destroy is
			-- Destroy the view
			-- Leave the EIS grid along.
		do
			recycle
		end

	refresh_grid is
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

	refresh_grid_without_sorting is
			-- Refresh the grid without sorting.
		do
			eis_grid.remove_and_clear_all_rows
			compute_grid_rows
			eis_grid.redraw
		end

	rebuild_and_refresh_grid is
			-- Rebuild table from the component and refresh the grid.
		do
			eis_grid.remove_and_clear_all_rows
			setup_grid_from_component
			eis_grid.redraw
		end

	create_new_entry is
			-- Create new EIS entry based on current component at the last row.
			-- Default to do nothing.
		do
		end

	delete_selected_entries is
			-- Delete selected entries.
		do
		end

feature {NONE} -- Sorting

	new_sorter: DS_QUICK_SORTER [EIS_ENTRY] is
			-- New sorter
		local
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EIS_ENTRY]
		do
			create l_agent_sorter.make (agent sort_entry)
			create Result.make (l_agent_sorter)
		end

	sort_entry (u, v: EIS_ENTRY): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
			cached_column_set: cached_column > 0 and then cached_column <= eis_grid.column_count
		local
			type_u, type_v: NATURAL
		do
			inspect cached_column
			when column_location then
				if {lt_id_u: STRING}u.id then
					if {lt_id_v: STRING}v.id then
						type_u := id_solution.most_possible_type_of_id (lt_id_u)
						type_v := id_solution.most_possible_type_of_id (lt_id_v)
						if type_u = type_v then
								-- Type is the same, compare the name
							if type_u = id_solution.target_type then
								if {lt_target_u: CONF_TARGET}id_solution.target_of_id (lt_id_u) and then {lt_target_v: CONF_TARGET}id_solution.target_of_id (lt_id_v) then
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
				if {lt_name_u: STRING_32}u.name then
					if {lt_name_v: STRING_32}v.name then
						Result := lt_name_u < lt_name_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_protocol then
				if {lt_protocol_u: STRING_32}u.protocol then
					if {lt_protocol_v: STRING_32}v.protocol then
						Result := lt_protocol_u < lt_protocol_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_source then
				if {lt_source_u: STRING_32}u.source then
					if {lt_source_v: STRING_32}v.source then
						Result := lt_source_u < lt_source_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_tags then
				if {lt_tags_u: STRING_32}u.tags_as_string then
					if {lt_tags_v: STRING_32}v.tags_as_string then
						Result := lt_tags_u < lt_tags_v
					else
						Result := True
					end
				end
				if descend_order then
					Result := not Result
				end
			when column_others then
				if {lt_others_u: STRING_32}u.others_as_string then
					if {lt_others_v: STRING_32}v.others_as_string then
						Result := lt_others_u < lt_others_v
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

	is_help_available: BOOLEAN is
			--
		do
			Result := Precursor {HELP_CONTEXT_I} and then not eis_grid.selected_rows.is_empty
		end

	same_view (a_view: like Current): BOOLEAN is
			-- Is current view focusing the same component as `a_view'?
		do
			if a_view /= Void then
				if component.same_type (a_view.component) then
					Result := component.is_equal (a_view.component)
				end
			end
		end

	component_editable: BOOLEAN is
			-- Is component editable?
		do
		end

feature {NONE} -- Initialization

	setup_base_grid is
			-- Setup basic attributes of the displaying grid.
		local
			l_grid: like eis_grid
		do
			l_grid := eis_grid
			l_grid.enable_multiple_row_selection
			register_action (l_grid.key_release_actions, agent on_key_released)
			register_action (l_grid.pointer_double_press_actions, agent on_pointer_double_pressed)
			l_grid.enable_partial_dynamic_content
			l_grid.set_dynamic_content_function (agent on_item_display)

			l_grid.set_column_count_to (numbers_of_column)
			l_grid.set_auto_resizing_column (column_location, True)
			l_grid.set_auto_resizing_column (column_name, True)
			l_grid.set_auto_resizing_column (column_protocol, True)

			l_grid.column (column_location).set_title (interface_names.l_location)
			register_action (l_grid.column (column_location).header_item.pointer_button_press_actions, agent on_grid_header_click (column_location, ?, ?, ?, ?, ?, ?, ?, ?))
			l_grid.column (column_name).set_title (interface_names.l_name)
			register_action (l_grid.column (column_name).header_item.pointer_button_press_actions, agent on_grid_header_click (column_name, ?, ?, ?, ?, ?, ?, ?, ?))
			l_grid.column (column_protocol).set_title (interface_names.l_protocol)
			register_action (l_grid.column (column_protocol).header_item.pointer_button_press_actions, agent on_grid_header_click (column_protocol, ?, ?, ?, ?, ?, ?, ?, ?))
			l_grid.column (column_source).set_title (interface_names.l_source)
			register_action (l_grid.column (column_source).header_item.pointer_button_press_actions, agent on_grid_header_click (column_source, ?, ?, ?, ?, ?, ?, ?, ?))
			l_grid.column (column_tags).set_title (interface_names.l_tags)
			register_action (l_grid.column (column_tags).header_item.pointer_button_press_actions, agent on_grid_header_click (column_tags, ?, ?, ?, ?, ?, ?, ?, ?))
			l_grid.column (column_others).set_title (interface_names.l_others)
			register_action (l_grid.column (column_others).header_item.pointer_button_press_actions, agent on_grid_header_click (column_others, ?, ?, ?, ?, ?, ?, ?, ?))
		end

	setup_grid_from_component is
			-- Fill data into the displaying grid from given `component'.
		do
			create extracted_entries.make_from_array (new_extractor.eis_entries.linear_representation)
			cached_column := sorting_column
			cached_descend := descend_order
			new_sorter.sort (extracted_entries)
			compute_grid_rows
		ensure
			extracted_entries_not_void: extracted_entries /= Void
		end

	compute_grid_rows is
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

	new_extractor: !ES_EIS_EXTRACTOR is
			-- Create extractor
		deferred
		end

feature {NONE} -- Events

	on_grid_header_click (a_column_index: INTEGER; a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- On pointer pressed on grid header
		local
			l_session: SESSION_I
			l_column: INTEGER
			l_descend_order: BOOLEAN
		do
			if session_manager.is_service_available then
				l_session := session_manager.service.retrieve (False)
				l_column := sorting_column
				l_descend_order := descend_order
				if l_column = a_column_index then
					l_session.set_value ((not l_descend_order), eis_entry_grid_sorting_order_session_id)
				else
					l_session.set_value (a_column_index, eis_entry_grid_sorting_column_session_id)
					l_session.set_value (False, eis_entry_grid_sorting_order_session_id)
				end
			end
			refresh_grid
		end

	on_key_released (ev_key: EV_KEY) is
			-- On `en_key' released
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
			elseif ev_key.code = {EV_KEY_CONSTANTS}.key_delete then
				delete_selected_entries
			end
		end

	on_pointer_double_pressed (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- process mouse click in the list
		do
			if new_entry_possible and then eis_grid.row (eis_grid.row_count).is_selected then
				create_new_entry
			else
				show_help
			end
		end

	on_item_display (a_column, a_row: INTEGER): EV_GRID_ITEM is
			-- On item expose.
		local
			l_eis_entry: !EIS_ENTRY
			l_entry_row_count: INTEGER
		do
			l_entry_row_count := eis_grid.row_count
			if new_entry_possible then
				l_entry_row_count := l_entry_row_count - 1
			end
			if a_row > 0 and a_row <= l_entry_row_count and {lt_entries: DS_ARRAYED_LIST [!EIS_ENTRY]}extracted_entries then
					-- Retrieve corresponding EIS entry.
				l_eis_entry := lt_entries.item (a_row)
					-- Connect the EIS entry to the line of the grid.
				if not {lt_entry: EIS_ENTRY}eis_grid.row (a_row).data then
					eis_grid.row (a_row).set_data (l_eis_entry)
				end
				inspect a_column
				when column_location then
					Result := location_item_from_eis_entry (l_eis_entry)
				when column_name then
					Result := name_item_from_eis_entry (l_eis_entry)
				when column_protocol then
					Result := protocol_item_from_eis_entry (l_eis_entry)
				when column_source then
					Result := source_item_from_eis_entry (l_eis_entry)
				when column_tags then
						-- Tags
					Result := tags_item_from_eis_entry (l_eis_entry)
				when column_others then
						-- Others
					Result := others_item_from_eis_entry (l_eis_entry)
				else
					check no_more_column: False end
				end
					-- Setup background colors
					-- Put a special backgroud color if the line of entry is from inherited.

				if {lt_color: EV_COLOR}background_color_of_entry (l_eis_entry) then
					Result.set_background_color (lt_color)
				end
			elseif a_row = eis_grid.row_count and then new_entry_possible then
					-- New entry item in the last row.
				if a_column = column_name then
					create {EV_GRID_LABEL_ITEM}Result.make_with_text ("...")
				else
					create {EV_GRID_LABEL_ITEM}Result.make_with_text ("")
				end
			end
			eis_grid.request_columns_auto_resizing
		end

	activate_item (a_item: EV_GRID_ITEM) is
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

	on_name_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On name changed
		do
		end

	on_protocol_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On protocol changed
		do
		end

	on_source_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On source changed
		do
		end

	on_tags_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On tags changed
		do
		end

	on_others_changed (a_item: EV_GRID_EDITABLE_ITEM) is
			-- On others changed
		do
		end

feature {ES_EIS_COMPONENT_VIEW} -- Access

	component: !G
			-- The focusing component

	background_color_of_entry (a_entry: !EIS_ENTRY): EV_COLOR is
			-- Background color of `a_entry'
		do
		end

feature {NONE} -- Access

	eis_grid: !ES_EIS_ENTRY_GRID
			-- Grid to display EIS entries

	extracted_entries: DS_ARRAYED_LIST [EIS_ENTRY]
			-- Cached list of entries to display

	sorting_column: INTEGER is
			-- Sorting column
		local
			l_session: SESSION_I
		do
			if session_manager.is_service_available then
				l_session := session_manager.service.retrieve (False)
				if {lt_column: !INTEGER_REF} l_session.value_or_default (eis_entry_grid_sorting_column_session_id, False) then
					Result := lt_column.item
				end
			end
			if Result = 0 then
					-- Default to location column
				Result := column_location
			end
		end

	descend_order: BOOLEAN is
			-- Descend? Or ascend order
			-- Default is ascend
		local
			l_session: SESSION_I
		do
			if session_manager.is_service_available then
				l_session := session_manager.service.retrieve (False)
				if {lt_order: !BOOLEAN_REF} l_session.value_or_default (eis_entry_grid_sorting_order_session_id, False) then
					Result := lt_order.item
				end
			end
		end

	new_entry_possible: BOOLEAN
			-- Is new entry possible for current view?		

feature {NONE} -- Recycling

	internal_recycle is
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	frozen session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service {SESSION_MANAGER_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Validation

	is_name_valid (a_name: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN is
			-- Can `a_name' be changed in `a_item'?
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data then
				Result := entry_editable (lt_entry)
			end
		end

	is_protocol_valid (a_protocol: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN is
			-- Can `a_protocol' be changed in `a_item'?
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data then
				Result := entry_editable (lt_entry)
			end
		end

	is_source_valid (a_source: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN is
			-- Can `a_source' be changed in `a_item'?
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data then
				Result := entry_editable (lt_entry)
			end
		end

	is_tags_valid (a_tags: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN is
			-- Can `a_tags' be changed in `a_item'?
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data then
				Result := entry_editable (lt_entry)
			end
		end

	is_others_valid (a_others: STRING_32; a_item: EV_GRID_EDITABLE_ITEM): BOOLEAN is
			-- Can `a_others' be changed in `a_item'?
		do
			if {lt_entry: EIS_ENTRY}a_item.row.data then
				Result := entry_editable (lt_entry)
			end
		end

	entry_editable (a_entry: !EIS_ENTRY): BOOLEAN is
			-- If `a_entry' is editable through current view?
		do
		end

feature {NONE} -- Grid items

	name_item_from_eis_entry (a_entry: !EIS_ENTRY): !EV_GRID_ITEM is
			-- Grid item of name from an EIS entry.
		local
			l_name: STRING_32
			l_editable_item: !EV_GRID_EDITABLE_ITEM
		do
			l_name := a_entry.name
			if l_name = Void then
				create l_name.make_empty
			end
			if entry_editable (a_entry) then
				create l_editable_item.make_with_text (l_name)
				l_editable_item.pointer_button_press_actions.force_extend (agent activate_item (l_editable_item))
				l_editable_item.set_text_validation_agent (agent is_name_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_name_changed (l_editable_item))
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_name)
			end
		end

	protocol_item_from_eis_entry (a_entry: !EIS_ENTRY): !EV_GRID_ITEM is
			-- Grid item of protocol from an EIS entry.
		local
			l_protocol: STRING_32
			l_editable_item: !EV_GRID_EDITABLE_ITEM
		do
			l_protocol := a_entry.protocol
			if l_protocol = Void then
				create l_protocol.make_empty
			end
			if entry_editable (a_entry) then
				create l_editable_item.make_with_text (l_protocol)
				l_editable_item.pointer_button_press_actions.force_extend (agent activate_item (l_editable_item))
				l_editable_item.set_text_validation_agent (agent is_protocol_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_protocol_changed (l_editable_item))
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_protocol)
			end
		end

	source_item_from_eis_entry (a_entry: !EIS_ENTRY): !EV_GRID_ITEM is
			-- Grid item of source from an EIS entry.
		local
			l_source: STRING_32
			l_editable_item: !EV_GRID_EDITABLE_ITEM
		do
			l_source := a_entry.source
			if l_source = Void then
				create l_source.make_empty
			end
			if entry_editable (a_entry) then
				create l_editable_item.make_with_text (l_source)
				l_editable_item.pointer_button_press_actions.force_extend (agent activate_item (l_editable_item))
				l_editable_item.set_text_validation_agent (agent is_source_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_source_changed (l_editable_item))
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_source)
			end
		end

	tags_item_from_eis_entry (a_entry: !EIS_ENTRY): !EV_GRID_ITEM is
			-- Grid item of tags from an EIS entry.
		local
			l_tags: STRING_32
			l_editable_item: !EV_GRID_EDITABLE_ITEM
		do
			l_tags := eis_output.tags_as_code (a_entry)
			if entry_editable (a_entry) then
				create l_editable_item.make_with_text (l_tags)
				l_editable_item.pointer_button_press_actions.force_extend (agent activate_item (l_editable_item))
				l_editable_item.set_text_validation_agent (agent is_tags_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_tags_changed (l_editable_item))
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_tags)
			end
		end

	others_item_from_eis_entry (a_entry: !EIS_ENTRY): !EV_GRID_ITEM is
			-- Grid item of others from an EIS entry.
		local
			l_others: !STRING_32
			l_editable_item: !EV_GRID_EDITABLE_ITEM
		do
			l_others := eis_output.others_as_code (a_entry)
			if entry_editable (a_entry) then
				create l_editable_item.make_with_text (l_others)
				l_editable_item.pointer_button_press_actions.force_extend (agent activate_item (l_editable_item))
				l_editable_item.set_text_validation_agent (agent is_others_valid (?, l_editable_item))
				l_editable_item.deactivate_actions.extend (agent on_others_changed (l_editable_item))
				Result := l_editable_item
			else
				create {EV_GRID_LABEL_ITEM}Result.make_with_text (l_others)
			end
		end

	location_item_from_eis_entry (a_entry: !EIS_ENTRY): !EV_GRID_ITEM is
			-- Grid item of location from an EIS entry
		local
			l_type: NATURAL
			l_target: CONF_TARGET
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_editor_token_item: ES_GRID_LIST_ITEM
		do
			if {lt_id: STRING}a_entry.id then
				token_writer.new_line
				l_type := id_solution.most_possible_type_of_id (lt_id)
				if l_type = id_solution.target_type then
					l_target := id_solution.target_of_id (lt_id)
					l_editor_token_item := target_editor_token_for_location (l_target)
				elseif l_type = id_solution.group_type then
					l_group := id_solution.group_of_id (lt_id)
					l_editor_token_item := group_editor_token_for_location (l_group)
				elseif l_type = id_solution.folder_type then
						-- Should never get a folder type here.
					l_folder := id_solution.folder_of_id (lt_id)
					l_editor_token_item := folder_editor_token_for_location (l_folder)
				elseif l_type = id_solution.class_type then
					l_class ?= id_solution.class_of_id (lt_id)
					l_editor_token_item := class_editor_token_for_location (l_class)
				elseif l_type = id_solution.feature_type then
					l_feature := id_solution.feature_of_id (lt_id)
					l_editor_token_item := feature_editor_token_for_location (l_feature, id_solution.last_feature_name)
				end
				if {lt_item: ES_GRID_LIST_ITEM}l_editor_token_item then
					Result := lt_item
				else
					create {EV_GRID_LABEL_ITEM}Result
				end
			else
				create {EV_GRID_LABEL_ITEM}Result
			end
		end

	new_listable_item: !EB_GRID_LISTABLE_CHOICE_ITEM is
			-- New listable item
		do
			create Result
			Result.set_component_padding (1)
			Result.set_left_border (1)
			Result.set_bottom_border (1)
			Result.set_border_line_color (eis_grid.separator_color)
		end

feature {NONE} -- Location token

	target_editor_token_for_location (a_item: CONF_TARGET): !ES_GRID_LIST_ITEM is
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_item_item: !EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.process_target_name_text (a_item.name, a_item)
				l_editable_item := new_listable_item
				l_line := token_writer.last_line
				create l_e_com.make (l_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<target_pixmap_component, l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
			end
			if {lt_item: EB_GRID_LISTABLE_CHOICE_ITEM}l_editable_item then
				Result := lt_item
			else
				create Result
			end
		end

	group_editor_token_for_location (a_item: CONF_GROUP): !ES_GRID_LIST_ITEM is
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_item_item: !EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.add_group (a_item, a_item.name)
				l_editable_item := new_listable_item
				l_line := token_writer.last_line
				create l_e_com.make (l_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<group_pixmap_component (a_item), l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
			end
			if {lt_item: EB_GRID_LISTABLE_CHOICE_ITEM}l_editable_item then
				Result := lt_item
			else
				create Result
			end
		end

	folder_editor_token_for_location (a_item: EB_FOLDER): !ES_GRID_LIST_ITEM is
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_item_item: !EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.process_folder_text (a_item.name, a_item.path, a_item.cluster)
				l_editable_item := new_listable_item
				l_line := token_writer.last_line
				create l_e_com.make (l_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<folder_pixmap_component, l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
			end
			if {lt_item: EB_GRID_LISTABLE_CHOICE_ITEM}l_editable_item then
				Result := lt_item
			else
				create Result
			end
		end

	class_editor_token_for_location (a_item: CLASS_I): !ES_GRID_LIST_ITEM is
			-- Create editor token for loaction accordingly.
		local
			l_editable_item: !EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_item_item: !EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
			l_e_com: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			if a_item /= Void then
				token_writer.new_line
				token_writer.add_class (a_item)
				l_editable_item := new_listable_item
				l_line := token_writer.last_line
				create l_e_com.make (l_line.content, 0)
				create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<class_pixmap_component (a_item), l_e_com>>))
				l_item_item.set_data (a_item)
				l_editable_item.set_list_item (l_item_item)
			end
			if {lt_item: EB_GRID_LISTABLE_CHOICE_ITEM}l_editable_item then
				Result := lt_item
			else
				create Result
			end
		end

	feature_editor_token_for_location (a_item: E_FEATURE; a_name: STRING): !ES_GRID_LIST_ITEM is
			-- Create editor token for loaction accordingly.
		require
			a_item_void_implies_a_name_not_void: a_item = Void implies a_name /= Void
		local
			l_editable_item: !EB_GRID_LISTABLE_CHOICE_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_item_item: !EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
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
				token_writer.process_basic_text (a_name)
			end
			l_editable_item := new_listable_item
			l_line := token_writer.last_line
			create l_e_com.make (l_line.content, 0)
			create l_item_item.make (create {ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]}.make_from_array (<<l_component, l_e_com>>))
			l_item_item.set_data (a_item)
			l_editable_item.set_list_item (l_item_item)
			if {lt_item: EB_GRID_LISTABLE_CHOICE_ITEM}l_editable_item then
				Result := lt_item
			else
				create Result
			end
		end

feature {NONE} -- Pixmap component

	target_pixmap_component: !ES_GRID_PIXMAP_COMPONENT is
			-- Target pixmap component
		do
			create Result.make (pixmaps.icon_pixmaps.folder_target_icon)
		end

	group_pixmap_component (a_group: CONF_GROUP): !ES_GRID_PIXMAP_COMPONENT is
			-- Group pixmap component
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (icon_factory.pixmap_from_group (a_group))
		end

	folder_pixmap_component: !ES_GRID_PIXMAP_COMPONENT is
			-- Folder pixmap component
		do
			create Result.make (pixmaps.icon_pixmaps.folder_blank_icon)
		end

	class_pixmap_component (a_class: CLASS_I): !ES_GRID_PIXMAP_COMPONENT is
			-- Class pixmap component
		do
			create Result.make (icon_factory.pixmap_from_class_i (a_class))
		end

	feature_pixmap_component (a_feature: E_FEATURE): !ES_GRID_PIXMAP_COMPONENT is
			-- Feature pixmap component
		require
			a_feature_not_void: a_feature /= Void
		do
			create Result.make (icon_factory.pixmap_from_e_feature (a_feature))
		end

	uncompiled_feature_pixmap_component: !ES_GRID_PIXMAP_COMPONENT is
			-- Uncompiled feature pixmap component
		do
			create Result.make (pixmaps.icon_pixmaps.feature_obsolete_routine_icon)
		end

feature {NONE} -- Session IDs

	eis_entry_grid_sorting_column_session_id: !STRING_8 = "com.eiffel.eis_tool.entry_grid_sorting_column"

	eis_entry_grid_sorting_order_session_id: !STRING_8 = "com.eiffel.eis_tool.entry_grid_sorting_order"

feature {NONE} -- Column constants

	column_location: INTEGER = 1
	column_name: INTEGER = 2
	column_protocol: INTEGER = 3
	column_source: INTEGER = 4
	column_tags: INTEGER = 5
	column_others: INTEGER = 6
	numbers_of_column: INTEGER = 6;

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
