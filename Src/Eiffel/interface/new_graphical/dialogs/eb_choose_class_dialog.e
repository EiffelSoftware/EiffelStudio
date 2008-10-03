indexing
	description	: "Dialog to class in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHOOSE_CLASS_DIALOG

inherit
	ES_DIALOG

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature -- Access

	default_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.class_normal_icon_buffer
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.cancel_button
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := Interface_names.t_Choose_class
		end

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

feature {NONE} -- Initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
			l_win: like development_window
		do
			create l_shared
			l_win := l_shared.window_manager.last_focused_development_window
			check not_void: l_win /= Void end

			prepare (l_win.menus.context_menu_factory, a_container)

			on_class_name_entry_changed
		ensure then
		end

	prepare (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_container: EV_VERTICAL_BOX) is
			-- Create the controls and setup the layout
		local
			controls_box: EV_VERTICAL_BOX
			l_layouts: EV_LAYOUT_CONSTANTS
		do
			create l_layouts

			set_button_action_before_close ({ES_DIALOG_BUTTONS}.ok_button, agent on_ok)
			set_button_action ({ES_DIALOG_BUTTONS}.cancel_button, agent on_cancel)

				-- Create the controls.
			create class_name_entry.make
			class_name_entry.change_actions.extend (agent on_class_name_entry_changed)
			create classes_tree.make_without_targets (a_context_menu_factory)
			classes_tree.set_minimum_width (l_layouts.dialog_unit_to_pixels(300))
			classes_tree.set_minimum_height (l_layouts.dialog_unit_to_pixels(200))

			classes_tree.add_double_click_action_to_classes (agent on_class_double_click)

			classes_tree.refresh
			classes_tree.associate_textable_recursively  (class_name_entry, classes_tree)

			show_actions.extend (agent class_name_entry.set_focus)

				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			controls_box.set_border_width ({ES_UI_CONSTANTS}.dialog_border)
			controls_box.extend (class_name_entry)
			controls_box.disable_item_expand (class_name_entry)

			controls_box.extend (classes_tree)

				-- Pack the buttons_box and the controls.
			a_container.extend (controls_box)
		end

feature -- Access

	selected: BOOLEAN
			-- Has the user selected a class (True) or pushed
			-- the cancel button (False)?

	class_name: STRING is
			-- class selected by the user, if any.
		require
			selected: selected
		do
			Result := selected_class_name
		end

feature {NONE} -- Implementation

	selected_class_name: STRING
			-- name of the selected class, if any.

feature {NONE} -- Vision2 events

	on_ok is
			-- Terminate the dialog.
		local
			loclist: LIST [CLASS_I]
		do
			selected_class_name := class_name_entry.text.as_upper
			selected := not selected_class_name.is_empty
			if selected then -- User typed a class name.
				if eiffel_universe.target /= Void then
					loclist := Eiffel_universe.classes_with_name (selected_class_name.as_upper)
				end
				if loclist /= Void and then loclist.is_empty then -- No class has such a name.
					class_name_entry.set_text (Interface_names.l_Unknown_class_name)
					class_name_entry.set_focus
					class_name_entry.select_all

					veto_close
				else
				end
			else
				class_name_entry.set_focus
			end
		end

	on_cancel is
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			dialog.destroy
		end

	on_class_double_click (	x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER ) is
			-- Call on_ok through an agent compatible with double click actions.
		do
			on_ok
		end

	on_class_name_entry_changed is
			-- Handler for class name entry just changed
		local
			l_button: EV_BUTTON
			l_class_i: CLASS_I
		do
			l_button := dialog_window_buttons.item (default_button)
			check not_void: l_button /= Void end
			l_class_i ?= class_name_entry.data
			if l_class_i /= Void then
				l_button.enable_sensitive
			else
				l_button.disable_sensitive
			end
		end

feature {NONE} -- Controls

	class_name_entry: EB_CHOOSE_CLASS_COMBO_BOX
			-- Combo box where the user can type its class name.

	classes_tree: EB_CLASSES_TREE;
			-- Tree where the user can choose its class.

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

end -- class EB_CHOOSE_CLASS_DIALOG

