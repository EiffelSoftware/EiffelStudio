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
			pebble as object_stone,
			pnd_accept_cursor as object_stone_accept_cursor,
			pnd_deny_cursor as object_stone_deny_cursor
		redefine
			object_stone,
			object_stone_accept_cursor,
			object_stone_deny_cursor
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

	SHARED_EIFNET_DEBUGGER
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
				Result.append_string (" name=[" + object_name + "] ")
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

			internal_object_stone := Void
			internal_object_stone_accept_cursor := Void
			internal_object_stone_deny_cursor := Void
			object_stone_properties_computed := False
			last_dump_value := Void
		end

feature {ES_OBJECTS_GRID, ES_OBJECTS_GRID_MANAGER} -- Row attachement

	attach_to_row (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
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

			expand_actions.wipe_out
			collapse_actions.wipe_out

			row_items_filled := False
			row_attributes_filled := False
			row_onces_filled := False

			attributes_row := Void
			onces_row := Void

			object_stone_properties_computed := False
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

--	tool: ES_OBJECTS_GRID_MANAGER

	row: EV_GRID_ROW

	parent_grid: ES_OBJECTS_GRID

	object_is_special_value: BOOLEAN

	object_name: STRING is
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

feature -- Query

	text_data_for_clipboard: STRING is
		local
			dv: DUMP_VALUE
		do
			create Result.make (10)
			if object_name /= Void then
				Result.append_string (object_name + ": ")
			end
			dv := associated_dump_value
			if dv /= Void then
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

	object_stone_properties_computed: BOOLEAN

	get_object_stone_properties is
		require
			not object_stone_properties_computed
		local
			ost: OBJECT_STONE
			ostn: STRING
		do
			object_stone_properties_computed := True

			internal_object_stone := Void
			internal_object_stone_accept_cursor := Void
			internal_object_stone_deny_cursor := Void

			if object_address /= Void then
					--| For now we don't support this for external type
				ostn := object_name
				if ostn = Void then
					ostn := object_address
				end
				create ost.make (object_address, ostn, object_dynamic_class)
				ost.set_associated_ev_item (row)
				internal_object_stone_accept_cursor := ost.stone_cursor
				internal_object_stone_deny_cursor := ost.X_stone_cursor
				internal_object_stone := ost
			end
		end

	object_stone: STONE is
		do
			if not object_stone_properties_computed then
				get_object_stone_properties
			end
			Result := internal_object_stone
		end

	object_stone_accept_cursor: EV_CURSOR is
		do
			if not object_stone_properties_computed then
				get_object_stone_properties
			end
			Result := internal_object_stone_accept_cursor
		end

	object_stone_deny_cursor: EV_CURSOR is
		do
			if not object_stone_properties_computed then
				get_object_stone_properties
			end
			Result := internal_object_stone_deny_cursor
		end

	internal_object_stone_accept_cursor: like object_stone_accept_cursor

	internal_object_stone_deny_cursor: like object_stone_deny_cursor

	internal_object_stone: like object_stone

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
			object_stone_properties_computed := False
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

	title: STRING
			-- `title' value overwrite name's value.

	set_title (v: STRING) is
		local
			cell:EV_GRID_LABEL_ITEM
		do
			title := v
			if row /= Void then
				set_name (title)
				cell ?= row.item (Col_name_index)
				if cell /= Void then
					apply_cell_title_properties_on (cell)
				end
			end
		end

	set_name (v: STRING) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			title := v
			glab := cell_text_updated (v, Col_name_index)
			apply_cell_name_properties_on (glab)
		end

	set_type (v: STRING) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab := cell_text_updated (v, Col_type_index)
			apply_cell_type_properties_on (glab)
		end

	set_address (v: STRING) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab := cell_text_updated (v, Col_address_index)
			apply_cell_address_properties_on (glab)
		end

	set_value (v: STRING) is
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab := cell_text_updated (v, Col_value_index)
			apply_cell_value_properties_on (glab)
		end

	set_context (v: STRING) is
		local
			glab: EV_GRID_LABEL_ITEM
		do
			glab := cell_text_updated (v, Col_context_index)
			apply_cell_context_properties_on (glab)
		end

	apply_cell_title_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
			a_item.set_font (Title_font)
		end

	apply_cell_name_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
		end
	apply_cell_type_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
		end
	apply_cell_value_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
		end
	apply_cell_address_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
		end
	apply_cell_context_properties_on (a_item: EV_GRID_LABEL_ITEM) is
		require
			a_item_not_void: a_item /= Void
		do
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
			l_text: STRING
			l_integer32_value: INTEGER
			l_integer64_value: INTEGER_64
			l_natural32_value: NATURAL_32
			l_natural64_value: NATURAL_64
		do
			l_dmp := last_dump_value
			if l_dmp /= Void then
				inspect l_dmp.type
						-- NOTA: we should factorize this .. maybe having to_hex_string, in NUMERIC would help
					when {DUMP_VALUE_CONSTANTS}.Type_integer_32 then
						l_integer32_value := l_dmp.value_integer_32
						if hexa_mode_enabled then
							l_text := "0x" + l_integer32_value.to_hex_string
						else
							l_text := l_integer32_value.out
					 	end
						set_value (l_text)
					when {DUMP_VALUE_CONSTANTS}.Type_integer_64 then
						l_integer64_value := l_dmp.value_integer_64
						if hexa_mode_enabled then
							l_text := "0x" + l_integer64_value.to_hex_string
						else
							l_text := l_integer64_value.out
						end
						set_value (l_text)
					when {DUMP_VALUE_CONSTANTS}.Type_natural_32 then
						l_natural32_value := l_dmp.value_natural_32
						if hexa_mode_enabled then
							l_text := "0x" + l_natural32_value.to_hex_string
						else
							l_text := l_natural32_value.out
						end
						set_value (l_text)
					when {DUMP_VALUE_CONSTANTS}.Type_natural_64 then
						l_natural64_value := l_dmp.value_natural_64
						if hexa_mode_enabled then
							l_text := "0x" + l_natural64_value.to_hex_string
						else
							l_text := l_natural64_value.out
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

			Result.put (Pixmaps.Icon_immediate_value, Immediate_value)
			Result.put (Pixmaps.Icon_void_object, Void_value)
			Result.put (Pixmaps.Icon_object_symbol, Reference_value)
			Result.put (Pixmaps.Icon_expanded_object, Expanded_value)
			Result.put (Pixmaps.Icon_object_symbol, Special_value)
			Result.put (Pixmaps.Icon_external_symbol, External_reference_value)
			Result.put (Pixmaps.Icon_static_external_symbol, Static_external_reference_value)
			Result.put (Pixmaps.Icon_static_object_symbol, Static_reference_value)
			Result.put (pixmaps.small_pixmaps.icon_dbg_error, Exception_message_value)
			Result.put (pixmaps.small_pixmaps.icon_dbg_error, Error_message_value)
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
				os ?= object_stone
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
			ctler: ES_GRID_ROW_CONTROLLER
			glab: EV_GRID_LABEL_ITEM
		do
			row_items_filled := True
			grid_remove_and_clear_subrows_from (a_row)
			grid := a_row.parent
			if has_attributes_values then
				glab := folder_label_item (Interface_names.l_Object_attributes)
				grid_cell_set_pixmap (glab, Pixmaps.Icon_attributes)

				i := a_row.index + a_row.subrow_count_recursive + 1
				grid.insert_new_row_parented (i, a_row)
				attributes_row := grid.row (i)
				attributes_row.set_item (1, glab)

					--| Add expand actions.
				create ctler
				ctler.expand_actions.extend (agent on_row_expand)
				ctler.collapse_actions.extend (agent on_row_collapse)

				attributes_row.set_data (ctler)
				attributes_row.ensure_expandable
			end
			if has_once_functions then
				glab := folder_label_item (Interface_names.l_Once_functions)
				grid_cell_set_pixmap (glab, Pixmaps.Icon_once_objects)

				i := a_row.index + a_row.subrow_count_recursive + 1
				grid.insert_new_row_parented (i, a_row)
				onces_row := grid.row (i)
				onces_row.set_item (1, glab)

					--| Add expand actions.
				create ctler
				ctler.expand_actions.extend (agent on_row_expand)
				ctler.collapse_actions.extend (agent on_row_collapse)
				onces_row.set_data (ctler)
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
					attach_debug_value_from_line_to_grid_row (grid.row (l_row_index), list_cursor.item, Current)
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
					attach_debug_value_from_line_to_grid_row (grid.row (r), odv, Current)
					i := i + 1
					r := r + 1
				end
			end
		end

	attach_debug_value_from_line_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_line: ES_OBJECTS_GRID_LINE) is
			-- attach `dv' to row `a_row'
		require
			debug_value_not_void: dv /= Void
		do
			parent_grid.attach_debug_value_from_line_to_grid_row (a_row, dv, a_line)
		end

	attach_debug_value_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE) is
			-- attach `dv' to row `a_row'
		require
			debug_value_not_void: dv /= Void
		do
			attach_debug_value_from_line_to_grid_row (a_row, dv, Void)
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

	es_cell (c: INTEGER): ES_OBJECTS_GRID_CELL is
		local
			l_item: EV_GRID_ITEM
		do
			if c > 0 and c <= row.count then
				l_item := row.item (c)
			end
			if l_item = Void then
				create Result
			else
				Result ?= l_item
			end
			if l_item = Void then
				row.set_item (c, Result)
			end
		ensure
			Result /= Void
		end

	cell_text_updated (v: STRING; c: INTEGER): ES_OBJECTS_GRID_CELL is
		do
			Result := es_cell (c)
			if v /= Void then
				grid_cell_set_text (Result, v)
			else
				grid_cell_set_text (Result, "")
			end
		ensure
			Result /= Void
		end

invariant
	parent_grid_not_void: parent_grid /= Void
	parent_grid_related_to_attached_row: (row /= Void and then row.parent /= Void) implies parent_grid = row.parent

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
