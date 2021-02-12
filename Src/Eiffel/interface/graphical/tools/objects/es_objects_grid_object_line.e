note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OBJECTS_GRID_OBJECT_LINE

inherit
	ES_OBJECTS_GRID_LINE
		rename
			item_pebble as item_stone,
			item_pebble_details as item_stone_details
		redefine
			item_stone_details,
			attach_to_row,
			reset_compute_grid_display_done,
			compute_grid_row,
			refresh, reset,
			make
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		undefine
			default_create, copy, is_equal
		end

	DEBUG_VALUE_EXPORTER
		undefine
			default_create, copy, is_equal
		end

	EB_SHARED_WRITER
		undefine
			default_create, copy, is_equal
		end

	DEBUGGER_COMPILER_UTILITIES
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	make
			-- Make current object
		do
			Precursor {ES_OBJECTS_GRID_LINE}
			display := False
			display_onces := False
			display_constants := False
			set_object_spec_slices (debugger_manager.min_slice, debugger_manager.max_slice)
		end

feature -- Recycling

	debug_output: STRING_32
		do
			Result := generating_type.name_32.as_string_32
			if object_name /= Void then
				Result.append_string ({STRING_32} " name=[")
				Result.append_string (object_name)
				Result.append_string ({STRING_32} "] ")
			end
		end

	reset
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor {ES_OBJECTS_GRID_LINE}
			if onces_row /= Void then
				onces_row.set_data (Void)
				if onces_row.parent /= Void then
					onces_row.clear
				end
				onces_row := Void
			end
			if constants_row /= Void then
				constants_row.set_data (Void)
				if constants_row.parent /= Void then
					constants_row.clear
				end
				constants_row := Void
			end
			row_items_filled := False
			row_attributes_filled := False
			row_onces_filled := False

			clear_items_stone_properties
			last_dump_value := Void
		ensure then
			item_stone_properties_not_computed : not items_stone_properties_computed
		end

feature {ES_OBJECTS_GRID, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_MANAGER, ES_DEBUGER_TOOLTIP_HANDLER} -- Grid and row attachement

	attach_to_row (a_row: EV_GRID_ROW)
		do
			Precursor {ES_OBJECTS_GRID_LINE} (a_row)
			row_items_filled := False
			row_attributes_filled := False
			row_onces_filled := False
		end

	refresh
		do
			row_items_filled := False
			row_attributes_filled := False

			row_onces_filled := False
			onces_row := Void

			row_constants_filled := False
			constants_row := Void

			internal_items_stone_data := Void
			Precursor {ES_OBJECTS_GRID_LINE}
		end

feature {NONE} -- Helpers

	is_valid_and_known_object_address (addr: DBG_ADDRESS): BOOLEAN
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application.is_valid_and_known_object_address (addr)
		end

feature -- Properties

	object_is_special_value: BOOLEAN

	object_name: STRING_32
		deferred
		end

	object_address: DBG_ADDRESS
		deferred
		end

	object_dynamic_class: CLASS_C
		deferred
		end

	object_spec_lower: INTEGER

	object_spec_upper: INTEGER

	object_spec_count_and_capacity: TUPLE [spec_count, spec_capacity: INTEGER]
		require
			object_is_special_value: object_is_special_value
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Bridge to parent ES_OBJECTS_GRID

	generating_type_evaluation_enabled: BOOLEAN
		require
			parent_grid /= Void
		do
			Result := parent_grid.generating_type_evaluation_enabled
		end

feature -- Query

	text_data_for_clipboard: detachable STRING_32
		local
			dv: DUMP_VALUE
		do
			dv := last_dump_value
			if dv = Void and  debugger_manager.application_is_executing then
				dv := associated_dump_value
			end
			if dv /= Void then
				create Result.make (10)
				if object_name /= Void then
					Result.append (object_name + ": ")
				end
				Result.append (dv.generating_type_representation (generating_type_evaluation_enabled))
				Result.append (" = ")
				Result.append (dv.full_output)
			end
		end

	has_attributes_values: BOOLEAN
		deferred
		end

	has_once_routine: BOOLEAN
			-- Current value has once feature?
		do
			Result := attached sorted_once_routines as list and then not list.is_empty
		end

	has_constant: BOOLEAN
			-- Current value has constant feature?
		do
			Result := attached sorted_constant_features as list and then not list.is_empty
		end

	reset_special_attributes_values
		do
		end

	sorted_attributes_values: DEBUG_VALUE_LIST
			-- Sorted list of attribute values
		deferred
		end

	sorted_once_routines: LIST [E_FEATURE]
			-- Sorted list of once features
		deferred
		end

	sorted_constant_features: LIST [E_CONSTANT]
			-- Sorted list of constants features	
		deferred
		end

	associated_dump_value: DUMP_VALUE
		require
			application_is_executing: debugger_manager.application_is_executing
		deferred
		end

feature -- Status

	display: BOOLEAN
			-- Should we expand the associated object at all?

	display_attributes: BOOLEAN = True
			-- Should attributes be displayed or not?

	display_onces: BOOLEAN
			-- Should once functions be displayed or not?

	display_constants: BOOLEAN
			-- Should constant functions be displayed or not?			

feature -- Pick and Drop

	item_stone_details (i: INTEGER): like internal_item_stone_data_i_th
		do
			if not items_stone_properties_computed then
				get_items_stone_properties
			end
			Result := internal_item_stone_data_i_th (i)
		end

feature {NONE} -- Pick and Drop implementation

	items_stone_properties_computed: BOOLEAN
		do
			Result := internal_items_stone_data /= Void
		end

	clear_items_stone_properties
			-- Clear items stone properties
		do
			internal_items_stone_data := Void
		end

	get_items_stone_properties
		require
			not items_stone_properties_computed
		local
			st: STONE
			ost: OBJECT_STONE
			ostn: STRING_32
			t: like internal_item_stone_data_i_th
		do
			create internal_items_stone_data.make_filled (Void, row.count + 1) -- FIXME: upper value ?
			if attached object_address as oadd and then not oadd.is_void then
					--| For now we don't support this for external type
				ostn := object_name
				if ostn = Void then
					ostn := object_address.output
				end
				create ost.make (object_address, ostn, object_dynamic_class)
				ost.set_associated_ev_item (row)
				st := ost

				create t
				t.pebble := st
				t.accept_cursor := st.stone_cursor
				t.deny_cursor := st.X_stone_cursor
					-- When compiler is fixed use: t := [st, st.stone_cursor, st.X_stone_cursor]

				internal_items_stone_data.put (t, col_value_index)
				internal_items_stone_data.put (t, col_type_index)
			elseif attached object_dynamic_class as ocl then
				st := create {CLASSC_STONE}.make (ocl)
				create t
				t.pebble := st
				t.accept_cursor := st.stone_cursor
				t.deny_cursor := st.X_stone_cursor
					-- When compiler is fixed use: t := [st, st.stone_cursor, st.X_stone_cursor]
				internal_items_stone_data[col_type_index] := t
			else
				st := create {DATA_STONE}
				create t
				t.pebble := st
				t.accept_cursor := st.stone_cursor
				t.deny_cursor := st.X_stone_cursor
					-- When compiler is fixed use: t := [st, st.stone_cursor, st.X_stone_cursor]
				internal_items_stone_data[col_type_index] := t
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

	internal_item_stone_data_i_th (i: INTEGER): TUPLE [pebble: STONE; accept_cursor: EV_POINTER_STYLE; deny_cursor: EV_POINTER_STYLE]
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

feature {ES_OBJECTS_TOOL_PANEL, ES_OBJECTS_GRID_LINE} -- Status change

	set_display (b: BOOLEAN)
			-- Should attributes be displayed in the future?
		do
			display := b
		end

--	set_display_onces (b: BOOLEAN) is
--			-- Should onces be displayed in the future?
--		do
--			display_onces := b
--		end

--	set_display_constants (b: BOOLEAN) is
--			-- Should constants be displayed in the future?
--		do
--			display_constants := b
--		end

feature -- Properties change

	set_object_spec_slices (vl, vu: INTEGER)
			-- Set `data_spec_lower' to `vl'
			-- and Set `data_spec_upper' to `vu'
		do
			object_spec_lower := vl
			object_spec_upper := vu
		end

	refresh_spec_items (vl, vu: INTEGER)
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
				if row /= Void and display_attributes then
						-- We remove the dummy item.
					if onces_row /= Void then
						grid_remove_and_clear_subrows_from_until (row, onces_row)
					else
						grid_remove_and_clear_subrows_from (row)
					end
					fill_attributes (row)
					if old_r <= g.row_count then
						g.set_first_visible_row (old_r)
					end
				end
			end
		end

feature -- Graphical computation

	reset_compute_grid_display_done
			-- Reset value of `compute_grid_display_done'
		do
			Precursor {ES_OBJECTS_GRID_LINE}
			internal_items_stone_data := Void
		end

	compute_grid_row
		do
			clear_items_stone_properties
			Precursor {ES_OBJECTS_GRID_LINE}
		end

	title: STRING_32
			-- `title' value overwrite name's value.

	set_title (v: STRING_GENERAL)
		do
			title := v
			if row /= Void then
				set_name (title)
				if attached {EV_GRID_LABEL_ITEM} row.item (Col_name_index) as li then
					apply_cell_title_properties_on (li)
				end
			end
		end

	apply_cell_title_properties_on (a_item: EV_GRID_LABEL_ITEM)
		require
			a_item_not_void: a_item /= Void
		do
			if a_item.font /= Title_font then
				a_item.set_font (Title_font)
			end
		ensure
			a_item.font = Title_font
		end

	set_name (v: STRING_GENERAL)
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if title = Void then
				title := v
			end

			if attached {EV_GRID_LABEL_ITEM} cell (Col_name_index) as i then
				glab := i
			else
				glab := new_cell_name
				set_cell (Col_name_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_type (v: STRING_GENERAL)
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if attached {EV_GRID_LABEL_ITEM} cell (Col_type_index) as i then
				glab := i
			else
				glab := new_cell_type
				set_cell (Col_type_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_address (v: detachable DBG_ADDRESS)
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if attached {EV_GRID_LABEL_ITEM} cell (Col_address_index) as i then
				glab := i
			else
				glab := new_cell_address
				set_cell (Col_address_index, glab)
			end
			if v /= Void then
				grid_cell_set_text (glab, v.output)
			else
				grid_cell_set_text (glab, Void)
			end
		end

	set_value (v: STRING_GENERAL)
		require
			is_attached_to_row: is_attached_to_row
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if attached {EV_GRID_LABEL_ITEM} cell (Col_value_index) as i then
				glab := i
			else
				glab := new_cell_value
				set_cell (Col_value_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_context (v: STRING_GENERAL)
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if attached {EV_GRID_LABEL_ITEM} cell (Col_context_index) as i then
				glab := i
			else
				glab := new_cell_context
				set_cell (Col_context_index, glab)
			end
			grid_cell_set_text (glab, v)
		end

	set_scoop_pid_value (a_scp_pid: NATURAL_16)
		local
			glab: detachable EV_GRID_LABEL_ITEM
			v: like scoop_pid_to_text
		do
			v := scoop_pid_to_text (a_scp_pid)
			if attached {EV_GRID_LABEL_ITEM} cell (Col_scoop_pid_index) as i then
				glab := i
			else
				if v /= Void then
					glab := new_cell_context
					set_cell (Col_scoop_pid_index, glab)
				end
			end
			if glab /= Void then
				grid_cell_set_text (glab, v)
			end
		end

	scoop_pid_to_text (a_scp_pid: NATURAL_16): detachable STRING
			-- String representation for `a_scp_pid'.
		do
			if a_scp_pid > 0 then
				Result := a_scp_pid.out
			end
		end

	value_cell: EV_GRID_ITEM
		do
			Result := cell (Col_value_index)
		end

	new_cell_title: ES_OBJECTS_GRID_CELL
		do
			create Result
			Result.set_font (Title_font)
		end

	new_cell_name: ES_OBJECTS_GRID_CELL
		do
			create Result
			Result.set_font (parent_grid.grid_font)
		end

	new_cell_type: ES_OBJECTS_GRID_CELL
		do
			create Result
			Result.set_font (parent_grid.grid_font)
		end

	new_cell_value: ES_OBJECTS_GRID_VALUE_CELL
		do
			create Result
			Result.set_font (parent_grid.grid_font)
		end

	new_cell_address: ES_OBJECTS_GRID_CELL
		do
			create Result
			Result.set_font (parent_grid.grid_font)
		end

	new_cell_context: EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_font (parent_grid.grid_font)
		end

	set_pixmap (v: EV_PIXMAP)
		require
			is_attached_to_row: is_attached_to_row
			row.count > 0
		do
			grid_cell_set_pixmap (row.item (Col_pixmap_index), v)
		end

feature -- Column index

	Col_pixmap_index: INTEGER
		do
			Result := parent_grid.Col_pixmap_index
		end

	Col_name_index: INTEGER
		do
			Result := parent_grid.Col_name_index
		end

	Col_address_index: INTEGER
		do
			Result := parent_grid.Col_address_index
		end

	Col_value_index: INTEGER
		do
			Result := parent_grid.Col_value_index
		end

	Col_type_index: INTEGER
		do
			Result := parent_grid.Col_type_index
		end

	Col_context_index: INTEGER
		do
			Result := parent_grid.Col_context_index
		end

	Col_scoop_pid_index: INTEGER
		do
			Result := parent_grid.Col_scoop_pid_index
		end

feature -- Updating

	update
		do
			update_value
		end

	update_value
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
						{DUMP_VALUE_CONSTANTS}.Type_integer_8,
						{DUMP_VALUE_CONSTANTS}.Type_integer_16,
						{DUMP_VALUE_CONSTANTS}.Type_integer_32,
						{DUMP_VALUE_CONSTANTS}.Type_integer_64,
						{DUMP_VALUE_CONSTANTS}.Type_natural_8,
						{DUMP_VALUE_CONSTANTS}.Type_natural_16,
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

feature {NONE} -- Icons

	icons: ARRAY [EV_PIXMAP]
			-- List of available icons for objects.
		local
			l_icons: like pixmaps.icon_pixmaps
		once
			l_icons := pixmaps.icon_pixmaps
			create Result.make_filled (l_icons.debugger_object_immediate_icon, {VALUE_TYPES}.Immediate_value, {VALUE_TYPES}.Error_message_value)
--			Result.put (l_icons.debugger_object_immediate_icon, {VALUE_TYPES}.Immediate_value)
			Result.put (l_icons.debugger_object_void_icon, {VALUE_TYPES}.Void_value)
			Result.put (l_icons.debugger_object_eiffel_icon, {VALUE_TYPES}.Reference_value)
			Result.put (l_icons.debugger_object_expanded_icon, {VALUE_TYPES}.Expanded_value)
			Result.put (l_icons.debugger_object_eiffel_icon, {VALUE_TYPES}.Special_value)
			Result.put (l_icons.debugger_object_dotnet_icon, {VALUE_TYPES}.External_reference_value)
			Result.put (l_icons.debugger_object_dotnet_static_icon, {VALUE_TYPES}.Static_external_reference_value)
			Result.put (l_icons.debugger_object_static_icon, {VALUE_TYPES}.Static_reference_value)
			Result.put (l_icons.general_mini_error_icon, {VALUE_TYPES}.Exception_message_value)
			Result.put (l_icons.debugger_value_routine_return_icon, {VALUE_TYPES}.Procedure_return_message_value)
			Result.put (l_icons.general_mini_error_icon, {VALUE_TYPES}.Error_message_value)
		end

	hexa_mode_enabled: BOOLEAN
		do
			Result := parent_grid.hexadecimal_mode_enabled
		end

feature {NONE} -- Filling

	onces_row: EV_GRID_ROW
			-- Row to hold the "once" features data

	constants_row: EV_GRID_ROW
			-- Row to hold the "constant" features data

	row_items_filled: BOOLEAN
			-- are the items (attributes and onces row) already filled ?

	row_attributes_filled: BOOLEAN
			-- Attributes values already filled ?

	row_onces_filled: BOOLEAN
			-- Onces values already filled ?

	row_constants_filled: BOOLEAN
			-- Constant values already filled ?

	on_row_expand (a_row: EV_GRID_ROW)
			-- Action performed when row is expanding
		do
			if a_row = row then
				display := True
				if not row_items_filled then
					fill_items (row)
				elseif not row_attributes_filled then
					fill_attributes (row)
				end
			elseif a_row = onces_row then
				display_onces := True
				if not row_onces_filled then
					fill_onces (onces_row)
				end
			elseif a_row = constants_row then
				display_constants := True
				if not row_constants_filled then
					fill_constants (constants_row)
				end
			end
		end

	on_row_collapse (a_row: EV_GRID_ROW)
			-- Action performed when row is collapsing
		do
			if a_row = row then
				display := False
			elseif a_row = onces_row then
				display_onces := False
			elseif a_row = constants_row then
				display_constants := False
			end
		end

	on_slice_double_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Action triggered by double clicking on the slice limit row
		do
			if
				attached parent_grid.slices_cmd as cmd and then
				attached {OBJECT_STONE} item_stone (col_value_index) as os
			then
				cmd.drop_object_stone (os)
			end
		end

	fill_items (a_row: EV_GRID_ROW)
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

				--| Attributes
			if display_attributes then
				fill_attributes (a_row)
			end

				--| Onces
			if has_once_routine then
				glab := folder_label_item (Interface_names.l_Once_routines)
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
				--| Constants			
			if has_constant then
				glab := folder_label_item (Interface_names.l_Constant_features)
				grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.feature_once_icon)

				i := a_row.index + a_row.subrow_count_recursive + 1
				grid.insert_new_row_parented (i, a_row)
				constants_row := grid.row (i)
				constants_row.set_item (1, glab)

					--| Add expand actions.
				constants_row.expand_actions.extend (agent on_row_expand (constants_row))
				constants_row.collapse_actions.extend (agent on_row_collapse (constants_row))
				constants_row.ensure_expandable
			end

			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
			if
				a_row.is_expanded and then
				display_onces
				and onces_row /= Void
				and then onces_row.parent /= Void
				and then onces_row.is_expandable
				and then not onces_row.is_expanded
			then
				onces_row.expand
			end
		end

	fill_attributes (a_row: EV_GRID_ROW)
			-- Fill attributes_row with the attributes related to Current	
		require
			a_row = row
			attributes_not_filled_yet: not row_attributes_filled
		local
			val: ABSTRACT_DEBUG_VALUE
			l_is_hidden, l_is_tuple: BOOLEAN
			i: INTEGER
			grid: EV_GRID
			es_glab: EV_GRID_LABEL_ITEM

			vlist: DEBUG_VALUE_LIST

			l_row_index: INTEGER
			dcl: like object_dynamic_class
		do
			row_attributes_filled := True
			vlist := sorted_attributes_values
			if vlist /= Void and then not vlist.is_empty then
					--| better being sure it won't happen |--
				from
					vlist.start
				until
					vlist.after
				loop
					val := vlist.item_for_iteration
					l_is_hidden := attached val.name as l_val_name and then
								not l_val_name.is_empty and then
								val.name.item (1) = '_'
					debug ("debugger_interface")
						l_is_hidden := False
					end
					if l_is_hidden then
						vlist.remove
					else
						vlist.forth
					end
				end

				if not vlist.is_empty then
					dcl := object_dynamic_class
					if dcl /= Void then
						l_is_tuple := dcl.conform_to (debugger_manager.compiler_data.tuple_class_c)
					end
					grid := a_row.parent
					l_row_index := a_row.index
					across
						vlist as c
					from
						if l_is_tuple then
								-- We do not display the first elements at position `0' in the TUPLE because
								-- it corresponds to `object_comparison' encoded as the value at position 0. This
								-- is added in `fill_extra_attributes_for_tuple' below.
							if vlist.count > 1 then
									-- Only insert more rows if TUPLE has some actual generics.
								a_row.insert_subrows (vlist.count - 1, 1)
							end
							c.forth
						else
							a_row.insert_subrows (vlist.count, 1)
						end
					loop
						l_row_index := l_row_index + 1
						attach_debug_value_from_line_to_grid_row (grid.row (l_row_index), c.item, Current, Void)
					end
					if object_is_special_value then
						if object_spec_lower > 0 then
							es_glab := slice_label_item (Interface_names.l_More_items)
							if object_spec_lower > object_spec_count_and_capacity.spec_capacity then
								es_glab.set_text (es_glab.text + " (" + object_spec_lower.out + ")")
							end
							es_glab.pointer_double_press_actions.extend (agent on_slice_double_click)
							i := a_row.index + 1
							grid.insert_new_row_parented (i, a_row)
							grid.set_item (Col_name_index, i, es_glab)
						end
						if
							0 <= object_spec_upper and then
							object_spec_upper < object_spec_count_and_capacity.spec_capacity - 1
						then
							es_glab := slice_label_item (Interface_names.l_More_items)
							es_glab.pointer_double_press_actions.extend (agent on_slice_double_click)
							if onces_row /= Void then
								i := onces_row.index
							else
								i := a_row.index + a_row.subrow_count_recursive + 1
							end

							grid.insert_new_row_parented (i, a_row)
							grid.set_item (Col_name_index, i, es_glab)
						end
					end
					if dcl /= Void then
						if
							--| FIXME jfiat [2009-06-03]: check the implementation for dotnet, related to count and capacity
							debugger_manager.is_classic_project and then
							dcl.conform_to (debugger_manager.compiler_data.special_class_c)
						then
							fill_extra_attributes_for_special (a_row, vlist)
						elseif l_is_tuple then
							fill_extra_attributes_for_tuple (a_row, vlist)
						elseif
							Eb_debugger_manager.display_agent_details
							and then dcl.conform_to (debugger_manager.compiler_data.routine_class_c)
						then
							fill_extra_attributes_for_agent (a_row, vlist)
						end
					end
				end
			end
			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
		end

	fill_onces (a_row: EV_GRID_ROW)
			-- Fill onces_row with the onces related to Current
		require
			a_row = onces_row
			onces_not_filled_yet: not row_onces_filled
			application_is_executing: debugger_manager.application_is_executing
		local
			flist: LIST [E_FEATURE]
		do
			row_onces_filled := True

			-- We remove the dummy item.
			grid_remove_and_clear_subrows_from (a_row)
			flist := sorted_once_routines
			check
				flist /= Void and then not flist.is_empty
			end

			if not flist.is_empty then
					--| Nota: address and class are used only for classic implementation
					--| maybe optimize this call by testing if we are on classic or dotnet
					--| but the benefit would be small compared to the gain of lisibility
				fill_onces_with_values (a_row, debugger_manager.application.onces_values (flist, object_address, object_dynamic_class))
			end

			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
		end

	fill_onces_with_values (a_row: EV_GRID_ROW; a_once_values: SPECIAL [ABSTRACT_DEBUG_VALUE])
		local
			i, r: INTEGER
			grid: EV_GRID
			odv: ABSTRACT_DEBUG_VALUE
		do
			if a_once_values /= Void and then a_once_values.count > 0 then
				grid := a_row.parent
				from
					r := a_row.subrow_count + 1
					a_row.insert_subrows (a_once_values.count, r)
					r := a_row.index + r
					i := 0
				until
					i >= a_once_values.count
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

	fill_constants (a_row: EV_GRID_ROW)
			-- Fill constants_row with the constant related to Current
		require
			a_row = constants_row
			constants_not_filled_yet: not row_constants_filled
			application_is_executing: debugger_manager.application_is_executing
		local
			flist: LIST [E_CONSTANT]
			c: E_CONSTANT
			csts: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			r: INTEGER
			grid: EV_GRID
			deval: DBG_EVALUATOR
		do
			row_constants_filled := True

			-- We remove the dummy item.
			grid_remove_and_clear_subrows_from (a_row)
			flist := sorted_constant_features
			deval := debugger_manager.dbg_evaluator
			check
				flist /= Void and then not flist.is_empty
			end

			if not flist.is_empty then
				create csts.make (flist.count)
				across
					flist as f
				loop
					c := f.item
					if
						attached {CONSTANT_I} c.associated_feature_i as ci and then
						attached deval.value_from_constant_i (ci) as cdv
					then
							-- TODO: Handle Unicode
						cdv.set_name ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (f.item.name_32))
						csts.extend (cdv)
					end
				end
				if not csts.is_empty then
					from
						grid := a_row.parent
						r := a_row.subrow_count + 1
						a_row.insert_subrows (csts.count, r)
						csts.start
						r := a_row.index + r
					until
						csts.after
					loop
						attach_debug_value_from_line_to_grid_row (grid.row (r), csts.item, Current, Void)
						csts.forth
						r := r + 1
					end
				end
			end
			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
			end
		end


	attach_debug_value_from_line_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_line: ES_OBJECTS_GRID_OBJECT_LINE; a_title: STRING_GENERAL)
			-- attach `dv' to row `a_row'
		require
			debug_value_not_void: dv /= Void
		do
			parent_grid.attach_debug_value_from_line_to_grid_row (a_row, dv, a_line, a_title)
		end

	attach_debug_value_to_grid_row (a_row: EV_GRID_ROW; dv: ABSTRACT_DEBUG_VALUE; a_title: STRING_GENERAL)
			-- attach `dv' to row `a_row'
			-- if `a_title' is not Void, use this string as name.
		require
			debug_value_not_void: dv /= Void
		do
			attach_debug_value_from_line_to_grid_row (a_row, dv, Void, a_title)
		end

feature {NONE} -- Agent filling

	Grid_feature_style: EB_FEATURE_EDITOR_TOKEN_STYLE
			-- Feature style to generate editor token informaton of feature
		once
			create Result
			Result.enable_argument
			Result.disable_comment
			Result.disable_class
			Result.disable_return_type
			Result.disable_value_for_constant
			Result.disable_use_overload_name
		ensure
			result_attached: Result /= Void
		end

	fill_extra_attributes_for_special (a_row: EV_GRID_ROW; lst: ITERABLE [ABSTRACT_DEBUG_VALUE])
		require
			a_row /= Void
			lst /= Void
		local
			lrow: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			list_cursor: ITERATION_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			list_cursor := lst.new_cursor

			a_row.insert_subrow (1)
			lrow := a_row.subrow (1)

			create glab.make_with_text ("count")
			glab.set_pixmap (pixmaps.mini_pixmaps.general_search_icon)
			lrow.set_item (col_name_index, glab)

			create glab.make_with_text (object_spec_count_and_capacity.spec_count.out)
			lrow.set_item (Col_value_index, glab)

			a_row.insert_subrow (2)
			lrow := a_row.subrow (2)

			create glab.make_with_text ("capacity")
			glab.set_pixmap (pixmaps.mini_pixmaps.general_search_icon)
			lrow.set_item (col_name_index, glab)

			create glab.make_with_text (object_spec_count_and_capacity.spec_capacity.out)
			lrow.set_item (Col_value_index, glab)
		end

	fill_extra_attributes_for_tuple (a_row: EV_GRID_ROW; lst: ITERABLE [ABSTRACT_DEBUG_VALUE])
		require
			a_row /= Void
			lst /= Void
		local
			lrow: EV_GRID_ROW
			r: INTEGER
			glab: EV_GRID_LABEL_ITEM
			gf: EB_GRID_EDITOR_TOKEN_ITEM
			f: E_FEATURE
			list_cursor: ITERATION_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			list_cursor := lst.new_cursor
			if
				not list_cursor.after and then
				attached {DEBUG_BASIC_VALUE [BOOLEAN]} list_cursor.item as vitem
			then
				r := 1
				a_row.insert_subrow (r)
				lrow := a_row.subrow (r)

				f := debugger_manager.compiler_data.tuple_class_c.feature_with_name_32 ("object_comparison")
				create gf
				if f /= Void then
					gf.set_pixmap (pixmap_from_e_feature (f))
					Grid_feature_style.set_e_feature (f)
					gf.set_text_with_tokens (Grid_feature_style.text)
				else
					gf.set_pixmap (pixmaps.icon_pixmaps.feature_routine_icon)
					gf.set_text ("object_comparison")
				end
				gf.set_overriden_fonts (label_font_table, label_font_height)
				lrow.set_item (Col_name_index, gf)

				create glab.make_with_text (vitem.output_value)
				glab.set_pixmap (pixmaps.mini_pixmaps.general_search_icon)
				lrow.set_item (Col_value_index, glab)
			end
		end

	fill_extra_attributes_for_agent (a_row: EV_GRID_ROW; lst: ITERABLE [ABSTRACT_DEBUG_VALUE])
		require
			a_row /= Void
			lst /= Void
		local
			lrow: EV_GRID_ROW
			v_routine_id: detachable DEBUG_BASIC_VALUE [INTEGER]
			rid: INTEGER
			ag_fe: E_FEATURE
			r: INTEGER
			glab: EV_GRID_LABEL_ITEM
			gf: EB_GRID_EDITOR_TOKEN_ITEM
		do
			across
				lst as ic
			until
				v_routine_id /= Void
			loop
				if attached ic.item as v_item and then
					attached v_item.name as n and then
					n.count > 3 and then
					attached {DEBUG_BASIC_VALUE [INTEGER]} v_item as vi and then
					vi.name /= Void and then
					v_routine_id = Void and then
					n.item (1) = 'r' and then
					n.same_string ("routine_id")
				then
					v_routine_id := vi
				end
			end
			if v_routine_id /= Void then
				rid := v_routine_id.value
				if rid > 0 then
					ag_fe := agent_feature_for_routine_id (rid)
					if ag_fe /= Void then
						ag_fe := real_feature (ag_fe)
						r := 1
						a_row.insert_subrow (r)
						lrow := a_row.subrow (r)

						create glab.make_with_text ("Agent")
						glab.set_pixmap (pixmaps.mini_pixmaps.general_search_icon)
						lrow.set_item (Col_name_index, glab)

						create gf
						gf.set_pixmap (pixmap_from_e_feature (ag_fe))
						gf.set_overriden_fonts (label_font_table, label_font_height)
						Grid_feature_style.set_e_feature (ag_fe)
						gf.set_text_with_tokens (Grid_feature_style.text)
						lrow.set_item (Col_value_index, gf)
					end
				end
			end
		end

feature {NONE} -- Implementation

	title_font: EV_FONT
		once
			Result := parent_grid.Title_font
		end

	slice_label_item (s: STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_font (parent_grid.grid_font)
			grid_cell_set_text (Result, s)
			Result.set_foreground_color (parent_grid.slice_row_fg_color)
		end

	name_label_item (s: STRING): EV_GRID_LABEL_ITEM
		do
			Result := parent_grid.name_label_item (s)
		end

	type_label_item (s: STRING): EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_font (parent_grid.grid_font)
			grid_cell_set_text (Result, s)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

