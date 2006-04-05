indexing
	description: "Dialog to manipulate exception handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EXCEPTION_HANDLER_DIALOG

inherit
	ES_EXCEPTION_HANDLER_DIALOG_IMP
		redefine
			grid
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			grid.set_minimum_size (100, 100)
			grid.set_column_count_to (2)
			grid.enable_single_row_selection
			grid.column (1).set_title ("Action")
			grid.column (2).set_title ("Name")
			grid.column (1).set_width (60)
			grid.column (2).set_width (400)
			grid.enable_last_column_use_all_width
			grid.row_select_actions.extend (agent row_selected)
			grid.row_deselect_actions.extend (agent row_deselected)

			handling_checkbox.set_text ("Exceptions handling enabled ?")
			handling_checkbox.select_actions.extend (agent on_handling_changed)

			handling_external_checking.select_actions.extend (agent on_external_handling_changed)
			set_default_cancel_button (cancel_button)
			set_icon_pixmap (pixmaps.icon_dialog_window)
		end

feature -- Properties

	grid: ES_GRID

feature -- Access

	exception_handler: DBG_EXCEPTION_HANDLER

	set_handler (eh: DBG_EXCEPTION_HANDLER) is
		local
			exceptions_handling: LIST [TUPLE [INTEGER, STRING]]
			elt: TUPLE [INTEGER, STRING]
		do
			exception_handler := eh
			from
				exceptions_handling := eh.handled_exceptions_by_name
				exceptions_handling.start
			until
				exceptions_handling.after
			loop
				elt := exceptions_handling.item
				if elt /= Void then
					add_row_from_data (elt)
				end
				exceptions_handling.forth
			end
			if exception_handler.exception_handling_enabled then
				handling_checkbox.enable_select
			else
				handling_checkbox.disable_select
			end
			if exception_handler.ignoring_external_exception then
				handling_external_checking.enable_select
			else
				handling_external_checking.disable_select
			end
			if exception_handler.ignoring_external_exception then
				handling_external_checking.enable_select
			else
				handling_external_checking.disable_select
			end
		end

	add_row_from_data (elt: TUPLE [INTEGER, STRING]) is
		require
			elt /= Void
		local
			role: INTEGER
			pat: STRING
			row: EV_GRID_ROW
			cell_lab: EV_GRID_LABEL_ITEM
			cell_combo: EV_GRID_COMBO_ITEM
		do
			pat := exception_handler.exception_name_value_from (elt)
			role := exception_handler.exception_name_role_from (elt)

			grid.insert_new_row (grid.row_count + 1)
			row := grid.row (grid.row_count)
			row.set_data (pat)

			create cell_combo
			cell_combo.set_item_strings (Status_id)
			if role = {DBG_EXCEPTION_HANDLER}.Role_stop then
				cell_combo.set_text (Status_id.item (1))
			elseif role = {DBG_EXCEPTION_HANDLER}.Role_continue then
				cell_combo.set_text (Status_id.item (2))
			elseif role = {DBG_EXCEPTION_HANDLER}.Role_disabled then
				cell_combo.set_text (Status_id.item (3))
			else
				check False end
			end
			cell_combo.activate_actions.extend (agent activate_combo (cell_combo, ?))
			cell_combo.pointer_double_press_actions.force_extend (agent cell_combo.activate)
			row.set_item (1, cell_combo)

			create cell_lab.make_with_text (pat)
			row.set_item (2, cell_lab)
		end

	activate_combo (ci: EV_GRID_COMBO_ITEM; a_dlg: EV_POPUP_WINDOW) is
		local
			t: STRING
			cbox: EV_COMBO_BOX
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
					if cbox.item.text.is_equal (t) then
						found := True
						cbox.item.enable_select
					end
					cbox.forth
				end
			end
		end

	Status_id: ARRAY [STRING] is
		once
			Result := <<"Catch", "Ignore", "Disabled">>
		end

feature {NONE} -- Implementation

	row_selected (r: EV_GRID_ROW) is
		do
			selected_row := r
			selected_data ?= r.data
			tf_pattern.set_text (selected_data)
		end

	row_deselected (r: EV_GRID_ROW) is
		do
			selected_row := Void
			selected_data := Void
		end

	selected_row: EV_GRID_ROW

	selected_data: STRING

	on_del is
		do
			if selected_row /= Void and selected_data /= Void then
				if selected_data.is_equal (tf_pattern.text) then
					grid.remove_row (selected_row.index)
				end
			end
		end

	on_add is
		do
			add_row_from_data ([{DBG_EXCEPTION_HANDLER}.role_disabled, tf_pattern.text.to_string_8])
		end

	on_cancel is
			-- Called by `select_actions' of `cancel_button'.
		do
			destroy
		end

	on_apply is
			-- Called by `select_actions' of `apply_button'.
		local
			r: INTEGER
			row: EV_GRID_ROW
			l_st: STRING
			l_pat: STRING
			cell: EV_GRID_LABEL_ITEM
		do
			exception_handler.wipe_out
			if grid.row_count > 1 then
				from
					r := 1
				until
					r > grid.row_count
				loop
					row := grid.row (r)
					cell ?= row.item (2)
					l_pat := cell.text

					cell ?= row.item (1)
					l_st := cell.text
					if l_st.is_equal (status_id.item (1)) then
						exception_handler.catch_exception_by_name (l_pat)
					elseif l_st.is_equal (status_id.item (2)) then
						exception_handler.ignore_exception_by_name (l_pat)
					elseif l_st.is_equal (status_id.item (3)) then
						exception_handler.disable_exception_by_name (l_pat)
					end
					r := r + 1
				end
			end
			if handling_checkbox.is_selected then
				exception_handler.enable_exception_handling
			else
				exception_handler.disable_exception_handling
			end
			exception_handler.ignore_external_exceptions (handling_external_checking.is_selected)
		end

	on_ok is
			-- Called by `select_actions' of `ok_button'.
		do
			on_apply
			destroy
		end

	on_handling_changed is
		do
			if handling_checkbox.is_selected then
				main_frame.enable_sensitive
				grid.set_default_colors
			else
				main_frame.disable_sensitive
				grid.set_background_color ((create {EV_STOCK_COLORS}).Color_read_only)
				grid.set_foreground_color ((create {EV_STOCK_COLORS}).Color_3d_shadow )
			end
		end

	on_external_handling_changed is
		do
			exception_handler.ignore_external_exceptions (handling_external_checking.is_selected)
		end

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

end -- class ES_EXCEPTION_HANDLER_DIALOG
