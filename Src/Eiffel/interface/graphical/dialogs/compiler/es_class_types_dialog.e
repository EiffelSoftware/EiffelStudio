note
	description: "[
		Dialog used to display internal class types for user-selected disambiguation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS_TYPES_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog,
			make_with_window as make_dialog_with_window
		redefine
			on_after_initialized
		end

create
	make,
	make_with_window

feature {NONE} -- Initialization

	make (a_class: like associated_class)
			-- Initialize the class types dialog.
			--
			-- `a_class': The class to show all class types for.
		require
			a_class_attached: attached a_class
		do
			associated_class := a_class
			make_dialog
		ensure
			associated_class_set: associated_class = a_class
		end

	make_with_window (a_class: like associated_class; a_window: like development_window)
			-- Initialize the class types dialog using a specific development window.
			-- Note: There is typically no need to use use this routine unless access to the window is
			--       required during `build_dialog_interface'/`on_after_initialize'.
			--
			-- `a_class': The class to show all class types for.
			-- `a_window': A window to show use to show the dialog relative to.
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			associated_class := a_class
			make_dialog_with_window (a_window)
		ensure
			associated_class_set: associated_class = a_class
			development_window_set: development_window = a_window
		end

feature {NONE} -- Initialization: User interface

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_label: EVS_LABEL
			l_border: ES_BORDERED_WIDGET [ES_GRID]
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			create l_label
			l_label.is_text_wrapped := True
			l_label.set_text (locale_formatter.formatted_translation (lb_info, [associated_class.name_in_upper]))
			a_container.extend (l_label)
			a_container.disable_item_expand (l_label)

			create class_types_list
			class_types_list.set_minimum_width (300)
			class_types_list.enable_single_row_selection
			class_types_list.enable_selection_key_handling
			class_types_list.enable_always_selected
			class_types_list.hide_header
			class_types_list.set_column_count_to (class_column)
			register_action (class_types_list.row_select_actions, agent on_row_selected)
			register_action (class_types_list.key_release_actions,
				agent (ia_key: EV_KEY)
					do
						if ia_key.code = {EV_KEY_CONSTANTS}.key_enter then
							on_dialog_button_pressed (default_confirm_button)
						end
					end)
			register_action (class_types_list.pointer_double_press_item_actions,
				agent (ia_x: INTEGER; ia_y: INTEGER; ia_button: INTEGER; ia_item: EV_GRID_ITEM)
					do
						if ia_button = 1 then
							on_dialog_button_pressed (default_confirm_button)
						end
					end)
			register_action (class_types_list.resize_actions, agent (ia_1, ia_2, ia_width, ia_4: INTEGER)
				do
					class_types_list.column (class_column).set_width (ia_width)
				end)

			register_action (class_types_list.dpi_changed_actions, agent (a_dpi: NATURAL_32; ia_1, ia_2, ia_width, ia_4: INTEGER)
				do
					class_types_list.column (class_column).set_width (ia_width)
				end)


			grid_token_support.synchronize_color_or_font_change_with_editor
			grid_token_support.enable_grid_item_pnd_support
			grid_token_support.enable_ctrl_right_click_to_open_new_window
			grid_token_support.set_context_menu_factory_function (agent (development_window.menus).context_menu_factory)

			create l_border.make (class_types_list)
			a_container.extend (l_border)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			populate_class_types (associated_class)
			set_button_text (dialog_buttons.ok_button, interface_names.b_open)
			set_button_icon (dialog_buttons.ok_button, stock_pixmaps.general_open_icon)
		end

feature -- Access

	associated_class: CLASS_C
			-- Associated class to display all class types for.

	selected_class_type: detachable CLASS_TYPE
			-- Last selected class type.

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			Result := dialog_buttons.ok_cancel_buttons
		end

feature {NONE} -- Access: User interface

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.class_normal_icon_buffer
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_dialog_title)
		end

	default_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.cancel_button
		end

	class_types_list: ES_GRID
			-- Grid used to list the associated class' class types.

feature {NONE} -- Helpers

	frozen grid_token_support: EB_EDITOR_TOKEN_GRID_SUPPORT
			-- Support for using `grid_events' with editor token-based items
		require
			is_interface_usable: is_interface_usable
			is_initializing_or_is_initialized: is_initializing or is_initialized
		do
			Result := internal_grid_token_support
			if Result = Void then
				create Result.make_with_grid (class_types_list)
				internal_grid_token_support := Result
				auto_recycle (Result)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = grid_token_support
		end

feature {NONE} -- Basic operations

	populate_class_types (a_class: CLASS_C)
			-- Populate the class types from the specified class
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_list: like class_types_list
			l_row: EV_GRID_ROW
			l_types: TYPE_LIST
			l_cursor: ARRAYED_LIST_CURSOR
			l_count: INTEGER
		do
			l_list := class_types_list
			l_list.clear

			l_types := a_class.types
			l_count := l_types.count
			l_list.set_row_count_to (l_count)
			l_cursor := l_types.cursor
			from l_types.start until l_types.after loop
				l_row := l_list.row (l_types.index)
				if attached l_types.item as l_class_type then
					populate_class_type_row (l_class_type, l_row)
					check data_not_set: not attached l_row.data end
					l_row.set_data (l_class_type)
				end
				class_types_list.grid_row_fill_empty_cells (l_row)
				l_types.forth
			end
			l_types.go_to (l_cursor)

			l_list.set_minimum_height (l_list.row_height * (l_count.min (15)))
			if l_count > 0 then
				l_list.row (1).enable_select
			end
		end

	populate_class_type_row (a_class_type: CLASS_TYPE; a_row: EV_GRID_ROW)
			-- Populate a class types row.
			--
			-- `a_class_type': The class to populate a row for.
			-- `a_row': A row to populate a class type representation for.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_generator: EB_EDITOR_TOKEN_GENERATOR
			l_type: CL_TYPE_A
			l_generics: ARRAYED_LIST [TYPE_A]
			i, l_upper: INTEGER
		do
			l_type := a_class_type.type
			create l_generator.make
			l_generator.add_class (associated_class.lace_class)
			if attached {GEN_TYPE_A} l_type as l_gen_type then
				l_generator.process_symbol_text (" [")
				l_generics := l_gen_type.generics
				from
					i := l_generics.lower
					l_upper := l_generics.upper
				until
					i > l_upper
				loop
					if attached {CL_TYPE_A} l_generics[i] as l_sub_type then
						l_generator.add_class (l_sub_type.base_class.lace_class)
					else
						l_generator.add (l_generics[i].dump)
					end
					if i < l_upper then
						l_generator.process_symbol_text (", ")
					end
					i := i + 1
				end
				l_generator.process_symbol_text ("]")
			end

			create l_item
			l_item.set_pixmap (pixmap_factory.pixmap_from_class_i (associated_class.lace_class))
			l_item.set_text_with_tokens (l_generator.tokens (0))
			l_item.set_is_pick_on_text (True)

			a_row.set_item (class_column, l_item)
		end

feature {NONE} -- Basic operations

	on_row_selected (a_row: EV_GRID_ROW)
			-- Called when a row is selected in the classes list.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: attached a_row
		do
			if attached {CLASS_TYPE} a_row.data as l_class_type then
				selected_class_type := 	l_class_type
			else
				selected_class_type := Void
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_grid_token_support: detachable like grid_token_support
			-- Cache version of `grid_token_support'.
			-- Note: Do not use directly!

feature {NONE} -- Constants

	class_column: INTEGER = 1

feature {NONE} -- Initialization

	t_dialog_title: STRING = "Select Class Type"
	lb_info: STRING = "The selected class $1 has multiple internal representations associated with it. Please select the appropriate representation to open:"

invariant
	associated_class_attached: attached associated_class

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
