indexing
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OBJECTS_GRID_LINE

inherit

	ES_GRID_ROW_CONTROLLER
		rename
			item_pebble as item_stone,
			item_pebble_details as item_stone_details
		redefine
			item_stone_details
		end

	VALUE_TYPES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	SHARED_DEBUG
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		undefine
			default_create, copy, is_equal
		end

	EB_VISION2_FACILITIES
		undefine
			default_create, copy, is_equal
		end

	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end

	DEBUG_OUTPUT
		undefine
			default_create, copy, is_equal
		end

	DEBUG_VALUE_EXPORTER
		undefine
			default_create, copy, is_equal
		end

	EB_SHARED_DEBUGGER_MANAGER
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	make_with_grid (g: like parent_grid) is
			-- Make current object
		do
			default_create
			display := False
			display_attributes := True
			display_onces := False

			set_object_spec_slices (min_slice_ref.item, max_slice_ref.item)

			create compute_grid_row_completed_action
			parent_grid := g
		end

feature -- Recycling

	debug_output: STRING is
		do
			Result := generating_type
			if object_name /= Void then
				Result.append_string (" name=[")
				Result.append_string (object_name.as_string_8)
				Result.append_string ("] ")
			end
		end

	recycle is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			unattach
			if attributes_row /= Void then
				attributes_row.set_data (Void)
				if attributes_row.parent /= Void then
					attributes_row.clear
				end
				attributes_row := Void
			end
			if onces_row /= Void then
				onces_row.set_data (Void)
				if onces_row.parent /= Void then
					onces_row.clear
				end
				onces_row := Void
			end
			row_items_filled := False
			row_attributes_filled := False
			row_onces_filled := False

			internal_items_stone_data := Void
			last_dump_value := Void
		ensure
			item_stone_properties_not_computed : not items_stone_properties_computed
		end

feature {ES_OBJECTS_GRID, ES_OBJECTS_GRID_MANAGER} -- Grid and row attachement

	relocate_to_parent_grid (a_parent_grid: like parent_grid) is
			-- relocate current line to `a_parent_grid'.
		require
			is_not_attached_to_row: not is_attached_to_row
		do
			parent_grid := a_parent_grid
		end

	attach_to_row (a_row: EV_GRID_ROW) is
		require
			row_not_void: a_row /= Void
			is_not_attached_to_row: not is_attached_to_row
		do
			row := a_row
			check parent_grid = row.parent end

			row.set_data (Current)

			row_items_filled := False
			row_attributes_filled := False
			row_onces_filled := False
			if row.parent /= Void then
				row.clear
				row.set_background_color (Void)
			end
			compute_grid_display_done := False
		ensure
			attached_to_row: row /= Void
		end

	unattach is
		require
			is_attached_to_row: is_attached_to_row
		do
			if row.parent /= Void then
				check row.parent = parent_grid end
				grid_remove_and_clear_subrows_from (row)
				row.clear
			end
			row.set_data (Void)
			reset_row_actions
			row := Void
			compute_grid_display_done := False
		ensure
			is_not_attached_to_row: not is_attached_to_row
		end

	refresh is
		require
			is_attached_to_row: is_attached_to_row
		do
			if row.parent /= Void then
				grid_remove_and_clear_subrows_from (row)
				row.ensure_non_expandable
				row.clear
				row.set_background_color (Void)
			end

			set_expand_action (Void)
			set_collapse_action (Void)

			row_items_filled := False
			row_attributes_filled := False
			row_onces_filled := False

			attributes_row := Void
			onces_row := Void

			internal_items_stone_data := Void
			compute_grid_display_done := False
			compute_grid_display
		ensure
			is_attached_to_row: is_attached_to_row
		end

feature -- Status

	is_attached_to_row: BOOLEAN is
		do
			Result := row /= Void
		end

feature -- Properties

	row: EV_GRID_ROW

	parent_grid: ES_OBJECTS_GRID

	object_is_special_value: BOOLEAN

	object_name: STRING_32 is
		deferred
		end

	object_address: STRING is
		deferred
		end

	object_dynamic_class: CLASS_C is
		deferred
		end

	object_spec_lower: INTEGER

	object_spec_upper: INTEGER

	object_spec_capacity: INTEGER is
		deferred
		end

feature -- Bridge to parent ES_OBJECTS_GRID

	generating_type_evaluation_enabled: BOOLEAN is
		require
			parent_grid /= Void
		do
			Result := parent_grid.generating_type_evaluation_enabled
		end

feature -- Query

	text_data_for_clipboard: STRING_32 is
		local
			dv: DUMP_VALUE
		do
			create Result.make (10)
			if object_name /= Void then
				Result.append_string (object_name.as_string_32 + ": ")
			end
			dv := associated_dump_value
			if dv /= Void then
				Result.append_string (": " + dv.generating_type_representation (generating_type_evaluation_enabled))
				Result.append_string (" = ")
				Result.append_string (dv.full_output)
			end
		end

	has_attributes_values: BOOLEAN is
		deferred
		end

	has_once_functions: BOOLEAN is
		local
			list: LIST [ANY]
		do
			list := sorted_once_functions
			Result := list /= Void and then not list.is_empty
		end

	reset_special_attributes_values is
		do
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		deferred
		end

	sorted_once_functions: LIST [E_FEATURE] is
		deferred
		end

	associated_dump_value: DUMP_VALUE is
		deferred
		end

feature -- Status

	display: BOOLEAN
			-- Should we expand the associated object at all?

	display_attributes: BOOLEAN
			-- Should attributes be displayed or not?

	display_onces: BOOLEAN
			-- Should once functions be displayed or not?

feature -- Pick and Drop

	item_stone_details (i: INTEGER): like internal_item_stone_data_i_th is
		do
			if not items_stone_properties_computed then
				get_items_stone_properties
			end
			Result := internal_item_stone_data_i_th (i)
		end

feature {NONE} -- Pick and Drop implementation

	items_stone_properties_computed: BOOLEAN is
		do
			Result := internal_items_stone_data /= Void
		end

	get_items_stone_properties is
		require
			not items_stone_properties_computed
		local
			clst: CLASSC_STONE
			ost: OBJECT_STONE
			ostn: STRING_32
			ocl: CLASS_C
			t: like internal_item_stone_data_i_th
		do
			create internal_items_stone_data.make (row.count + 1) -- FIXME: upper value ?
			if object_address /= Void then
					--| For now we don't support this for external type
				ostn := object_name
				if ostn = Void then
					ostn := object_address
				end
				create ost.make (object_address, ostn, object_dynamic_class)
				ost.set_associated_ev_item (row)
				create t
				t.stone := ost
				t.accept_cursor := ost.stone_cursor
				t.deny_cursor := ost.X_stone_cursor
				--When compiler is fixed use: t := [ost, ost.stone_cursor, ost.X_stone_cursor]
				internal_items_stone_data[col_value_index] := t
				internal_items_stone_data[col_type_index] := t
			else
				ocl := object_dynamic_class
				if ocl /= Void then
					create {CLASSC_STONE} clst.make (ocl)
					create t
					t.stone := clst
					t.accept_cursor := clst.stone_cursor
					t.deny_cursor := clst.X_stone_cursor
					--When compiler is fixed use: t := [clst, clst.stone_cursor, clst.X_stone_cursor]
					internal_items_stone_data[col_type_index] := t
				end
			end

			check internal_items_stone_data[0] = Void end
			if internal_items_stone_data[col_value_index] /= Void then
				internal_items_stone_data[0] := internal_items_stone_data[col_value_index]
			elseif internal_items_stone_data[col_type_index] /= Void then
				internal_items_stone_data[0] := internal_items_stone_data[col_type_index]
			end
		ensure
			item_stone_properties_computed: items_stone_properties_computed
		end

	internal_item_stone_data_i_th (i: INTEGER): TUPLE [stone: STONE; accept_cursor: EV_POINTER_STYLE; deny_cursor: EV_POINTER_STYLE] is
			-- Internal data related to `i_th' cell of current row.
		do
			if internal_items_stone_data /= Void then
				if internal_items_stone_data.count >= i then
					Result := internal_items_stone_data[i]
				end
				if Result = Void then
					Result := internal_items_stone_data[0]
				end
			end
		end

	internal_items_stone_data: SPECIAL [like internal_item_stone_data_i_th]
			-- Internal data about pebble value of current row's item
			-- index 0 is used for default pebble value

feature -- Record layout

	record_layout is
		do
			-- do nothing for now
		end

feature {ES_OBJECTS_TOOL} -- Status change

	set_display (b: BOOLEAN) is
			-- Should attributes be displayed in the future?
		do
			display := b
		end

	set_display_attributes (b: BOOLEAN) is
			-- Should attributes be displayed in the future?
		do
			display_attributes := b
		end

	set_display_onces (b: BOOLEAN) is
			-- Should onces be displayed in the future?
		do
			display_onces := b
		end

feature -- Properties change

	set_object_spec_slices (vl, vu: INTEGER) is
			-- Set `data_spec_lower' to `vl'
			-- and Set `data_spec_upper' to `vu'
		do
			object_spec_lower := vl
			object_spec_upper := vu
		end

	refresh_spec_items (vl, vu: INTEGER) is
			-- Refresh special items with new slices range [vl:vu]
		local
			g: EV_GRID
			old_r: INTEGER
		do
			g := row.parent
			old_r := g.first_visible_row.index
			set_object_spec_slices (vl, vu)
			if row /= Void then
				row_attributes_filled := False
				reset_special_attributes_values
				if attributes_row /= Void then
					fill_attributes (attributes_row)
				end
			end
			if old_r <= g.row_count then
				g.set_first_visible_row (old_r)
			end
		end

feature -- Graphical changes

	compute_grid_display_done: BOOLEAN
			-- is `compute_grid_display' called and done ?

	reset_compute_grid_display_done is
			-- Reset value of `compute_grid_display_done'
		do
			internal_items_stone_data := Void
			compute_grid_display_done := False
		end

	computed_grid_item (c: INTEGER): EV_GRID_ITEM is
		do
			if not compute_grid_display_done then
				if application.is_running and then application.is_stopped then
					compute_grid_row
				else
--					set_name (object_name)
--					ev_application.idle_actions.extend_kamikaze (agent parent_grid.remove_and_clear_all_rows)
				end
			end
			if row /= Void and then c <= row.count then
				Result := row.item (c)
				if Result = Void then
					create Result
				end
			end
		ensure
			result_not_void_if_stopped: (application.is_running and then application.is_stopped) implies Result /= Void
		end

	compute_grid_row is
		do
			compute_grid_display
			compute_grid_row_completed_action.call (Void) -- call ([Current])
		end

	compute_grid_row_completed_action: EV_NOTIFY_ACTION_SEQUENCE -- [TUPLE [ES_OBJECTS_GRID_LINE]]

	compute_grid_display is
			-- Compute the grid display related to current Line
		require
			not_computed: not compute_grid_display_done
		deferred
		end

	title: STRING_32
			-- `title' value overwrite name's value.

	set_title (v: STRING_GENERAL) is
		local
			li: EV_GRID_LABEL_ITEM
		do
			title := v
			if row /= Void then
				set_name (title)
				li ?= row.item (Col_name_index)
				if li /= Void then
					apply_cell_title_properties_on (li)
				end
			end
		end

	apply_cell_title_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
			if a_item.font /= Title_font then
				a_item.set_font (Title_font)
			end
		ensure
			a_item.font = Title_font
		end

	set_name (v: STRING_GENERAL) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if title = Void then
				title := v
			end

			glab ?= cell (Col_name_index)
			if glab = Void then
				glab := new_cell_name
				set_cell (Col_name_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_type (v: STRING) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab ?= cell (Col_type_index)
			if glab = Void then
				glab := new_cell_type
				set_cell (Col_type_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_address (v: STRING) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab ?= cell (Col_address_index)
			if glab = Void then
				glab := new_cell_address
				set_cell (Col_address_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_value (v: STRING_GENERAL) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab ?= cell (Col_value_index)
			if glab = Void then
				glab := new_cell_value
				set_cell (Col_value_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_context (v: STRING) is
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab ?= cell (Col_context_index)
			if glab = Void then
				glab := new_cell_context
				set_cell (Col_context_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	value_cell: EV_GRID_ITEM is
		do
			Result := cell (Col_value_index)
		end

	new_cell_title: ES_OBJECTS_GRID_CELL is
		do
			create Result
			Result.set_font (Title_font)
		end

	new_cell_name: ES_OBJECTS_GRID_CELL is
		do
			create Result
		end

	new_cell_type: ES_OBJECTS_GRID_CELL is
		do
			create Result
		end

	new_cell_value: ES_OBJECTS_GRID_VALUE_CELL is
		do
			create Result
		end

	new_cell_address: ES_OBJECTS_GRID_CELL is
		do
			create Result
		end

	new_cell_context: EV_GRID_LABEL_ITEM is
		do
			create Result
		end

	set_pixmap (v: EV_PIXMAP) is
		require
			is_attached_to_row: is_attached_to_row
			row.count > 0
		local
			gi: EV_GRID_ITEM
		do
			gi := row.item (Col_pixmap_index)
			grid_cell_set_pixmap (gi, v)
		end

feature -- Column index

	Col_pixmap_index: INTEGER is
		do
			Result := parent_grid.Col_pixmap_index
		end

	Col_name_index: INTEGER is
		do
			Result := parent_grid.Col_name_index
		end

	Col_address_index: INTEGER is
		do
			Result := parent_grid.Col_address_index
		end

	Col_value_index: INTEGER is
		do
			Result := parent_grid.Col_value_index
		end

	Col_type_index: INTEGER is
		do
			Result := parent_grid.Col_type_index
		end

	Col_context_index: INTEGER is
		do
			Result := parent_grid.Col_context_index
		end

feature -- Updating

	update is
		do
			update_value
		end

	update_value is
			-- Update numerical value
		local
			l_dmp: DUMP_VALUE
			l_text: STRING_32
		do
			l_dmp := last_dump_value
			if l_dmp /= Void then
				inspect l_dmp.type
						--| We only change the "Hexa"isable value
					when
						{DUMP_VALUE_CONSTANTS}.Type_integer_32,
						{DUMP_VALUE_CONSTANTS}.Type_integer_64,
						{DUMP_VALUE_CONSTANTS}.Type_natural_32,
						{DUMP_VALUE_CONSTANTS}.Type_natural_64,
						{DUMP_VALUE_CONSTANTS}.Type_character_8,
						{DUMP_VALUE_CONSTANTS}.Type_character_32
					then
						if hexa_mode_enabled then
							l_text := l_dmp.hexa_output_for_debugger
						else
							l_text := l_dmp.output_for_debugger
					 	end
						set_value (l_text)
					else
						-- Skip
				end
			end
		end

	last_dump_value: DUMP_VALUE

feature {NONE} -- Implementation

	icons: ARRAY [EV_PIXMAP] is
			-- List of available icons for objects.
		once
			create Result.make (Immediate_value, Error_message_value)

			Result.put (pixmaps.icon_pixmaps.debugger_object_immediate_icon, Immediate_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_void_icon, Void_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_eiffel_icon, Reference_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_expanded_icon, Expanded_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_eiffel_icon, Special_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_dotnet_icon, External_reference_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_dotnet_static_icon, Static_external_reference_value)
			Result.put (pixmaps.icon_pixmaps.debugger_object_static_icon, Static_reference_value)
			Result.put (pixmaps.icon_pixmaps.general_mini_error_icon, Exception_message_value)
			Result.put (pixmaps.icon_pixmaps.general_mini_error_icon, Error_message_value)
		end

	hexa_mode_enabled: BOOLEAN is
		do
			Result := parent_grid.hexadecimal_mode_enabled
		end

feature {NONE} -- Filling

	attributes_row: EV_GRID_ROW
	onces_row: EV_GRID_ROW

	row_items_filled: BOOLEAN
			-- are the items (attributes and onces row) already filled ?
	row_attributes_filled: BOOLEAN
			-- Attributes values already filled ?
	row_onces_filled: BOOLEAN
			-- Onces values already filled ?

	on_row_expand (a_row: EV_GRID_ROW) is
			-- Action performed when row is expanding
		do
			if a_row = row then
				display := True
				if not row_items_filled then
					fill_items (row)
				end
			elseif a_row = attributes_row then
				display_attributes := True
				if not row_attributes_filled then
					fill_attributes (attributes_row)
				end
			elseif a_row = onces_row then
				display_onces := True
				if not row_onces_filled then
					fill_onces (onces_row)
				end
			end
		end

	on_row_collapse (a_row: EV_GRID_ROW) is
			-- Action performed when row is collapsing
		do
			if a_row = row then
				display := False
			elseif a_row = attributes_row then
				display_attributes := False
			elseif a_row = onces_row then
				display_onces := False
			end
		end

	on_slice_double_click is
			-- Action triggered by double clicking on the slice limit row
		local
			os: OBJECT_STONE
			cmd: ES_OBJECTS_GRID_SLICES_CMD
		do
			cmd := parent_grid.slices_cmd
			if cmd /= Void then
				os ?= item_stone (col_value_index)
				if os /= Void then
					cmd.drop_object_stone (os)
				end
			end
		end

	fill_items (a_row: EV_GRID_ROW) is
			-- If a tree item was expandable, fill it with its children. (Not the onces)
		require
			items_not_filled_yet: not row_items_filled
		local
			i: INTEGER
			grid: EV_GRID
			glab: EV_GRID_LABEL_ITEM
		do
			row_items_filled := True
			grid_remove_and_clear_subrows_from (a_row)
			grid := a_row.parent
			if has_attributes_values then
				glab := folder_label_item (Interface_names.l_Object_attributes)
				grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.feature_attribute_icon)

				i := a_row.index + a_row.subrow_count_recursive + 1
				grid.insert_new_row_parented (i, a_row)
				attributes_row := grid.row (i)
				attributes_row.set_item (1, glab)

					--| Add expand actions.
				attributes_row.expand_actions.extend (agent on_row_expand (attributes_row))
				attributes_row.collapse_actions.extend (agent on_row_collapse (attributes_row))
				attributes_row.ensure_expandable
			end
			if has_once_functions then
				glab := folder_label_item (Interface_names.l_Once_functions)
				grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.feature_once_icon)

				i := a_row.index + a_row.subrow_count_recursive + 1
				grid.insert_new_row_parented (i, a_row)
				onces_row := grid.row (i)
				onces_row.set_item (1, glab)

					--| Add expand actions.
				onces_row.expand_actions.extend (agent on_row_expand (onces_row))
				onces_row.collapse_actions.extend (agent on_row_collapse (onces_row))
				onces_row.ensure_expandable
			end
			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
			if a_row.is_expanded then
				if
					display_attributes
					and attributes_row /= Void
					and then attributes_row.parent /= Void
					and then attributes_row.is_expandable
					and then not attributes_row.is_expanded
				then
					attributes_row.expand
				end
				if
					display_onces
					and onces_row /= Void
					and then onces_row.parent /= Void
					and then onces_row.is_expandable
					and then not onces_row.is_expanded
				then
					onces_row.expand
				end
			end
		end

	fill_attributes (a_row: EV_GRID_ROW) is
			-- Fill attributes_row with the attributes related to Current	
		require
			a_row = attributes_row
			attributes_not_filled_yet: not row_attributes_filled
		local
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]

			i: INTEGER
			grid: EV_GRID
			es_glab: EV_GRID_LABEL_ITEM

			vlist: DS_LIST [ABSTRACT_DEBUG_VALUE]
			l_row_index: INTEGER
			dcl: like object_dynamic_class
		do
			row_attributes_filled := True
				-- We remove the dummy item.
			grid_remove_and_clear_subrows_from (a_row)
			vlist := sorted_attributes_values
			if vlist /= Void and then not vlist.is_empty then
					--| better being sure it won't happen |--
				check
					vlist /= Void
				end
				grid := attributes_row.parent

				from
					l_row_index := a_row.index
					a_row.insert_subrows (vlist.count, 1)
					list_cursor := vlist.new_cursor
					list_cursor.start
				until
					list_cursor.after
				loop
					l_row_index := l_row_index + 1
					attach_debug_value_from_line_to_grid_row (grid.row (l_row_index), list_cursor.item, Current, Void)
					list_cursor.forth
				end
				if object_is_special_value then
					if object_spec_lower > 0 then
						es_glab := slice_label_item (Interface_names.l_More_items)
						if object_spec_lower > object_spec_capacity then
							es_glab.set_text (es_glab.text + " (" + object_spec_lower.out + ")")
						end
						es_glab.pointer_double_press_actions.force_extend (agent on_slice_double_click)
						i := attributes_row.index + 1
						grid.insert_new_row_parented (i, attributes_row)
						grid.set_item (Col_name_index, i, es_glab)
					end
					if
						0 <= object_spec_upper and then
						object_spec_upper < object_spec_capacity - 1
					then
						es_glab := slice_label_item (Interface_names.l_More_items)
						es_glab.pointer_double_press_actions.force_extend (agent on_slice_double_click)
						i := attributes_row.index + attributes_row.subrow_count_recursive + 1
						grid.insert_new_row_parented (i, attributes_row)
						grid.set_item (Col_name_index, i, es_glab)
					end
				end
				dcl := object_dynamic_class
				if
					dcl /= Void
					and then Eb_debugger_manager.display_agent_details
					and then dcl.conform_to (Application.Eiffel_system.System.routine_class.compiled_class)
				then
					fill_extra_attributes_for_agent (a_row, list_cursor)
				end
			end
			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
		end

	fill_onces (a_row: EV_GRID_ROW) is
			-- Fill onces_row with the onces related to Current
		require
			a_row = onces_row
			onces_not_filled_yet: not row_onces_filled
		local
			flist: LIST [E_FEATURE]
			l_once_values: ARRAY [ABSTRACT_DEBUG_VALUE]
		do
			row_onces_filled := True

			-- We remove the dummy item.
			grid_remove_and_clear_subrows_from (a_row)
			flist := sorted_once_functions
			check
				flist /= Void and then not flist.is_empty
			end

			if not flist.is_empty then
					--| Nota: address and class are used only for classic implementation
					--| maybe optimize this call by testing if we are on classic or dotnet
					--| but the benefit would be small compared to the gain of lisibility
				l_once_values := application.onces_values (flist, object_address, object_dynamic_class)
				fill_onces_with_values (a_row, l_once_values)
			end

			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
		end

	fill_onces_with_values (a_row: EV_GRID_ROW; a_once_values: ARRAY [ABSTRACT_DEBUG_VALUE]) is
		local
			i, r: INTEGER
			grid: EV_GRID
			odv: ABSTRACT_DEBUG_VALUE
		do
			if a_once_values /= Void and then not a_once_values.is_empty then
				grid := a_row.parent
				from
					r := a_row.subrow_count + 1
					a_row.insert_subrows (a_once_values.count, r)
					r := a_row.index + r
					i := a_once_values.lower
				until
					i > a_once_values.upper
				loop
					odv := a_once_values [i]
						--| Add the once's value to the grid.
					check odv /= Void end
					attach_debug_value_from_line_to_grid_row (grid.row (r), odv, Current, Void)
					i := i + 1
					r := r + 1
				end
			end
		end

	attach_debug_value_from_line_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_line: ES_OBJECTS_GRID_LINE; a_title: STRING_GENERAL) is
			-- attach `dv' to row `a_row'
		require
			debug_value_not_void: dv /= Void
		do
			parent_grid.attach_debug_value_from_line_to_grid_row (a_row, dv, a_line, a_title)
		end

	attach_debug_value_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_title: STRING_GENERAL) is
			-- attach `dv' to row `a_row'
			-- if `a_title' is not Void, use this string as name.
		require
			debug_value_not_void: dv /= Void
		do
			attach_debug_value_from_line_to_grid_row (a_row, dv, Void, a_title)
		end

feature {NONE} -- Agent filling

	Grid_feature_style: EB_NAME_SIGNATURE_FEATURE_STYLE is
		once
			create Result
		end

	fill_extra_attributes_for_agent (a_row: EV_GRID_ROW; list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]) is
		require
			a_row /= Void
			list_cursor /= Void
		local
			lrow: EV_GRID_ROW
			vitem: DEBUG_VALUE [INTEGER]
			grid: EV_GRID
			ag_ct_id: INTEGER
			ag_fe_id: INTEGER
			ag_ct: CLASS_TYPE
			ag_ecc: EIFFEL_CLASS_C
			ag_fe: E_FEATURE
			ag_fi: FEATURE_I
			r: INTEGER
			glab: EV_GRID_LABEL_ITEM
			gf: EB_GRID_FEATURE_ITEM
		do
			grid := a_row.parent
			from
				list_cursor.start
			until
				list_cursor.after or ag_fe /= Void
			loop
				vitem ?= list_cursor.item
				if
					vitem /= Void
					and then vitem.name /= Void
				then
					if ag_ct_id = 0 and then vitem.name.is_equal ("class_id") then
						ag_ct_id := vitem.value + 1
						ag_ct := application.eiffel_system.system.class_type_of_static_type_id (ag_ct_id)
					elseif ag_fe_id = 0 and then vitem.name.is_equal ("feature_id") then
						ag_fe_id := vitem.value
						if ag_ct /= Void and then ag_fe_id /= 0 then
							ag_fe := ag_ct.associated_class.feature_with_feature_id (ag_fe_id)
							if ag_fe = Void then
								ag_ecc ?= ag_ct.associated_class
								if ag_ecc /= Void then
									ag_fi := ag_ecc.inline_agent_of_id (ag_fe_id)
									if ag_fi /= Void then
										ag_fe := ag_fi.api_feature (ag_ecc.class_id)
									end
								end
							end
						end
					end
				end
				list_cursor.forth
			end
			if ag_fe /= Void then
				r := 1
				a_row.insert_subrow (r)
				lrow := a_row.subrow (r)

				create glab.make_with_text ("Agent")
				glab.set_pixmap (pixmaps.mini_pixmaps.general_search_icon)
				lrow.set_item (Col_name_index, glab)

				create gf.make (create {QL_REAL_FEATURE}.make (ag_fe), Grid_feature_style)
				lrow.set_item (Col_value_index, gf)
			end
		end

feature {NONE} -- Implementation

	title_font: EV_FONT is
		once
			Result := parent_grid.Title_font
		end

	folder_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			Result := parent_grid.folder_label_item (s)
		end

	slice_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result
			grid_cell_set_text (Result, s)
			Result.set_foreground_color (parent_grid.slice_row_fg_color)
		end

	name_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			Result := parent_grid.name_label_item (s)
		end

	type_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result
			grid_cell_set_text (Result, s)
		end

	cell (c: INTEGER): EV_GRID_ITEM is
		require
			row_not_void: row /= Void
		do
			if c > 0 and c <= row.count then
				Result := row.item (c)
			end
		end

	set_cell (c: INTEGER; v: EV_GRID_ITEM) is
		require
			row_not_void: row /= Void
		do
			row.set_item (c, v)
		end

invariant
	parent_grid_not_void: parent_grid /= Void
	parent_grid_related_to_attached_row: (row /= Void and then row.parent /= Void) implies parent_grid = row.parent

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
