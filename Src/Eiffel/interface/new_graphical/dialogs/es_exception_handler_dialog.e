note
	description : "Dialog to handle exception handling ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EXCEPTION_HANDLER_DIALOG

inherit
	ES_DIALOG

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	DEBUGGER_COMPILER_UTILITIES
		export
			{NONE} all
		end

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			f: EV_FRAME
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
				--| Checkbox frame
			create f
			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			vb.set_border_width ({ES_UI_CONSTANTS}.frame_border)


			create disable_catcall_console_warning_checkbox.make_with_text (interface_names.b_Disable_catcall_console_warnings)
			extend_non_expandable_to (vb, disable_catcall_console_warning_checkbox)

			create disable_catcall_debugger_warning_checkbox.make_with_text (interface_names.b_Disable_catcall_debugger_warnings)
			extend_non_expandable_to (vb, disable_catcall_debugger_warning_checkbox)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create handling_checkbox.make_with_text (interface_names.b_Filter_exceptions_question)
			create button_ignore_external_exception.make_with_text (interface_names.b_Ignore_external_exception)
			button_ignore_external_exception.select_actions.extend (agent ignore_external_exception)
			button_ignore_external_exception.disable_sensitive

			extend_non_expandable_to (hb, handling_checkbox)
			extend_expandable_to (hb, create {EV_CELL})
			extend_non_expandable_to (hb, button_ignore_external_exception)

			extend_non_expandable_to (vb, hb)

			f.extend (vb)
			extend_non_expandable_to (a_container, f)


				--| Main frame
			create main_frame

			create grid
			grid.hide_header
			grid.set_minimum_size (150, 250)
			grid.set_column_count_to (2)
			grid.enable_single_row_selection
			grid.column (1).set_title ("Action")
			grid.column (2).set_title ("Name")
			grid.column (1).set_width (60)
			grid.column (2).set_width (400)
			grid.enable_last_column_use_all_width
			grid.row_select_actions.extend (agent row_selected)
			grid.row_deselect_actions.extend (agent row_deselected)
			grid.key_press_actions.extend (agent (akey: EV_KEY)
					do
						if akey.code = {EV_KEY_CONSTANTS}.key_delete then
							on_del
						end
					end)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			extend_non_expandable_to (hb, create {EV_LABEL}.make_with_text ("Pattern"))
			create tf_pattern
			extend_expandable_to (hb, tf_pattern)

			create button_add.make_with_text ("Add")
			create button_del.make_with_text ("Remove")
			extend_non_expandable_to (hb, button_add)
			extend_non_expandable_to (hb, button_del)

			create vb
			vb.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			vb.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			extend_expandable_to (vb, grid)
			extend_non_expandable_to (vb, hb)
			main_frame.extend (vb)
			extend_expandable_to (a_container, main_frame)

			button_add.select_actions.extend (agent on_add)
			button_del.select_actions.extend (agent on_del)
			handling_checkbox.select_actions.extend (agent on_handling_changed)

			button_close := dialog_window_buttons.item (dialog_buttons.cancel_button)

			set_button_text (dialog_buttons.ok_button, interface_names.b_ok)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_cancel)

			set_button_action_before_close (dialog_buttons.ok_button, agent on_apply)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_close)
		end

feature -- Properties

	grid: ES_GRID
			-- Associated grid

	exception_handler: DBG_EXCEPTION_HANDLER
			-- Associated exception handler

feature -- Widgets

	button_close: EV_BUTTON
			-- Dialog's button for Close.

	disable_catcall_console_warning_checkbox: EV_CHECK_BUTTON
			-- Button to ignore catcall console warning.

	disable_catcall_debugger_warning_checkbox: EV_CHECK_BUTTON
			-- Button to ignore catcall debugger warning.			

	button_ignore_external_exception: EV_BUTTON
			-- Button to ignore external exception.

	button_add, button_del: EV_BUTTON
	handling_checkbox: EV_CHECK_BUTTON
	tf_pattern: EV_TEXT_FIELD
	main_frame: EV_FRAME

feature -- Change

	set_handler (eh: DBG_EXCEPTION_HANDLER)
			-- Set Associated exception handler	
		require
			eh_not_void: eh /= Void
		do
			exception_handler := eh
			update
		end

	update
			-- Update grid
		require
			exception_handler_not_void: exception_handler /= Void
		local
			lst: detachable LIST [STRING]
			eh: DBG_EXCEPTION_HANDLER
			l_sorter: SORTER [STRING]
		do
			eh := exception_handler

			grid.wipe_out
			grid.set_row_count_to (0)

			lst := descendants_type_names (exception_class_c)
			if lst = Void then
				create {ARRAYED_LIST [STRING]} lst.make (0)
				lst.compare_objects
			end

			across
				eh.enabled_handled_exceptions_by_name as e
			loop
				if attached e.item as elt then
					lst.prune_all (elt.name)
					add_row_from_data (elt)
				end
			end
			across
				eh.disabled_handled_exceptions_by_name as e
			loop
				if
					attached e.item as elt and then
					not lst.has (elt.name)
				then
					lst.force (elt.name)
				end
			end
			create {QUICK_SORTER [STRING]} l_sorter.make (create {COMPARABLE_COMPARATOR [STRING]})
			l_sorter.sort (lst)
			across
				lst as c
			loop
				add_row_from_data ([{DBG_EXCEPTION_HANDLER}.Role_disabled , c.item])
			end

			if exception_handler.enabled then
				handling_checkbox.enable_select
			else
				handling_checkbox.disable_select
			end

			if exception_handler.catcall_console_warning_disabled then
				disable_catcall_console_warning_checkbox.enable_select
			else
				disable_catcall_console_warning_checkbox.disable_select
			end
			if exception_handler.catcall_debugger_warning_disabled then
				disable_catcall_debugger_warning_checkbox.enable_select
			else
				disable_catcall_debugger_warning_checkbox.disable_select
			end
		end

	add_row_from_data (elt: TUPLE [role: INTEGER; name: STRING])
			-- Row associated to `elt'.
		require
			elt /= Void
		local
			role: INTEGER
			pat: STRING
			row: EV_GRID_ROW
			cell_lab: EV_GRID_LABEL_ITEM
			cell_combo: EV_GRID_COMBO_ITEM
		do
			pat := elt.name
			role := elt.role

			grid.insert_new_row (grid.row_count + 1)
			row := grid.row (grid.row_count)
			row.set_data (pat)

			create cell_combo
			cell_combo.set_item_strings (Status_id)
			cell_combo.set_text (Status_id[role])

			cell_combo.activate_actions.extend (agent activate_combo (cell_combo, ?))
			cell_combo.deactivate_actions.extend (agent refresh_row (row, Void))
			cell_combo.pointer_double_press_actions.extend (agent (c: EV_GRID_COMBO_ITEM; x, y, button: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32) do c.activate end (cell_combo, ?, ?, ?, ?, ?, ?, ?, ?))
			row.set_item (1, cell_combo)

			create cell_lab.make_with_text (pat)
			row.set_item (2, cell_lab)

			cell_lab.pointer_double_press_actions.extend (agent (arow: EV_GRID_ROW; x, y, button: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32)
				local
					r: INTEGER
				do
					if arow /= Void and then arow.parent /= Void then
						r := role_pattern_from_row (arow).role
						if r = {DBG_EXCEPTION_HANDLER}.Role_continue then
							r := {DBG_EXCEPTION_HANDLER}.Role_stop
						else
							r := {DBG_EXCEPTION_HANDLER}.Role_continue
						end
						set_role_on_row (r, arow)
					end
				end (row, ?, ?, ?, ?, ?, ?, ?, ?)
			)

			refresh_row (row, elt)
		end

	set_role_on_row (r: INTEGER; a_row: EV_GRID_ROW)
			-- Set role `r' on row `a_row'
		do
			if
				attached a_row and then
				attached a_row.parent and then
				attached {EV_GRID_LABEL_ITEM} a_row.item (1) as lab
			then
				lab.set_text (Status_id[r])
				refresh_row (a_row, Void)
			end
		end

	refresh_row	(a_row: detachable EV_GRID_ROW; a_details: like role_pattern_from_row)
			-- Refresh `a_row'
		local
			t: like role_pattern_from_row
		do
			if a_row /= Void and then a_row.parent /= Void then
				t := a_details
				if t = Void then
					t := role_pattern_from_row (a_row)
				end
				if
					attached t and then
					attached {EV_GRID_LABEL_ITEM} a_row.item (1) as item
				then
					if attached Status_pixmaps [t.role] as p then
						item.set_pixmap (p)
					else
						item.remove_pixmap
					end
				end
			end
		end

	activate_combo (ci: EV_GRID_COMBO_ITEM; a_dlg: EV_POPUP_WINDOW)
			-- Activate combo grid item `ci'
		local
			t: like {EV_COMBO_BOX}.text
			cbox: detachable EV_COMBO_BOX
			found: BOOLEAN
		do
			cbox := ci.combo_box
			if cbox /= Void then
				t := ci.text
				cbox.disable_edit
				from
					cbox.start
				until
					cbox.after or found
				loop
					if cbox.item.text.same_string (t) then
						found := True
						cbox.item.enable_select
					end
					cbox.forth
				end
			end
		end

	Status_id: ARRAY [STRING]
			-- Potential status ids
		once
			create Result.make_filled ("Disabled", {DBG_EXCEPTION_HANDLER}.Role_disabled, {DBG_EXCEPTION_HANDLER}.Role_stop)
			--| already added during creation. -- Result.put ("Disabled", {DBG_EXCEPTION_HANDLER}.Role_disabled)
			Result.put ("Ignore", {DBG_EXCEPTION_HANDLER}.Role_continue)
			Result.put ("Catch", {DBG_EXCEPTION_HANDLER}.Role_stop)
		end

	Status_pixmaps: ARRAY [detachable EV_PIXMAP]
			-- Potential status ids pixmap
		once
			create Result.make_filled (Void, {DBG_EXCEPTION_HANDLER}.Role_disabled, {DBG_EXCEPTION_HANDLER}.Role_stop)
			Result.put (Void, {DBG_EXCEPTION_HANDLER}.Role_disabled)
			Result.put (stock_pixmaps.debug_run_icon, {DBG_EXCEPTION_HANDLER}.Role_continue)
			Result.put (stock_pixmaps.debug_pause_icon, {DBG_EXCEPTION_HANDLER}.Role_stop)
		end

feature {NONE} -- Implementation

	row_selected (r: EV_GRID_ROW)
		do
			selected_row := r
			selected_data := if attached {like selected_data} r.data as s then s else Void end
			tf_pattern.set_text (selected_data)
		end

	row_deselected (r: EV_GRID_ROW)
		do
			selected_row := Void
			selected_data := Void
		end

	selected_row: detachable EV_GRID_ROW

	selected_data: detachable STRING

	apply_changes
		local
			r: INTEGER
			t: like role_pattern_from_row
		do
			exception_handler.wipe_out
			if grid.row_count > 1 then
				from
					r := 1
				until
					r > grid.row_count
				loop
					t := role_pattern_from_row (grid.row (r))
					inspect
						t.role
					when {DBG_EXCEPTION_HANDLER}.role_stop then
						exception_handler.catch_exception_by_name (t.pattern)
					when {DBG_EXCEPTION_HANDLER}.role_continue then
						exception_handler.ignore_exception_by_name (t.pattern)
					else -- case: {DBG_EXCEPTION_HANDLER}.role_disabled
						exception_handler.disable_exception_by_name (t.pattern)
					end
					r := r + 1
				end
			end
			if handling_checkbox.is_selected then
				exception_handler.enable_exception_handling
			else
				exception_handler.disable_exception_handling
			end
			debugger_manager.set_catcall_detection_mode (not disable_catcall_console_warning_checkbox.is_selected, not disable_catcall_debugger_warning_checkbox.is_selected)
		end

	role_pattern_from_row (a_row: EV_GRID_ROW): TUPLE [role: INTEGER; pattern: STRING]
			-- Role,Pattern contained by `a_row' if any
		require
			a_row_not_void: a_row /= Void
		local
			l_st: like {EV_GRID_LABEL_ITEM}.text
			l_pat: STRING
			r: INTEGER
		do
			if attached {EV_GRID_LABEL_ITEM} a_row.item (1) as cell then
				l_st := cell.text
				if l_st.same_string_general (status_id [{DBG_EXCEPTION_HANDLER}.role_stop]) then
					r := {DBG_EXCEPTION_HANDLER}.role_stop
				elseif l_st.same_string_general (status_id [{DBG_EXCEPTION_HANDLER}.role_continue]) then
					r := {DBG_EXCEPTION_HANDLER}.role_continue
				elseif l_st.same_string_general (status_id [{DBG_EXCEPTION_HANDLER}.role_disabled]) then
					r := {DBG_EXCEPTION_HANDLER}.role_disabled
				end
			end

			if
				attached {EV_GRID_LABEL_ITEM} a_row.item (2) as cell and then
				attached cell.text as t and then
				t.is_valid_as_string_8
			then
				l_pat := t.to_string_8
			end

			Result := [r, l_pat]
		end

feature {NONE} -- events

	ignore_external_exception
			-- Ignore external exceptions
		local
			lst: detachable LIST [STRING]
			t: like role_pattern_from_row
			r: INTEGER
		do
			lst := exception_handler.external_exception_names
			if lst /= Void then
				from
					r := 1
				until
					r > grid.row_count
				loop
					t := role_pattern_from_row (grid.row (r))
					if lst.has (t.pattern) then
						set_role_on_row ({DBG_EXCEPTION_HANDLER}.role_continue, grid.row (r))
						lst.prune_all (t.pattern)
					end
					r := r + 1
				end
				across
					lst as c
				loop
					add_row_from_data ([{DBG_EXCEPTION_HANDLER}.role_continue, c.item])
				end
			end
		end

	on_del
		local
			r: INTEGER
		do
			if
				selected_row /= Void and
				selected_data /= Void and then
				selected_data.same_string_general (tf_pattern.text)
			then
				r := selected_row.index
				grid.remove_row (r)
				if grid.row_count > 0 then
					if r <= grid.row_count then
						grid.select_row (r)
					else
						grid.select_row (grid.row_count)
					end
				end
			end
		end

	on_add
		do
			add_row_from_data ([{DBG_EXCEPTION_HANDLER}.role_disabled, tf_pattern.text.to_string_8])
		end

	on_apply
			-- Called by `select_actions' of `ok_button'.
		do
			apply_changes
		end

	on_close
			-- Called by `select_actions' of `cancel_button'.
		do
		end

	on_handling_changed
			-- Handling data changed
		do
			if handling_checkbox.is_selected then
				main_frame.enable_sensitive
				grid.set_default_colors
				button_ignore_external_exception.enable_sensitive
			else
				main_frame.disable_sensitive
				grid.set_background_color ((create {EV_STOCK_COLORS}).Color_read_only)
				grid.set_foreground_color ((create {EV_STOCK_COLORS}).Color_3d_shadow )
				button_ignore_external_exception.disable_sensitive
			end
		end

feature {NONE} -- Helpers

	extend_non_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, False)
		end

	extend_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, True)
		end

	extend_to (b: EV_BOX; w: EV_WIDGET; is_expandable: BOOLEAN)
			-- Extend `w' to `b', and keep expand enabled (default)
		do
			b.extend (w)
			if not is_expandable then
				b.disable_item_expand (w)
			end
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.m_dbg_exception_handler
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.ok_button
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
