indexing
	description	: "Dialog to class in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHOOSE_CLASS_DIALOG

inherit
	EV_DIALOG

	EB_CONSTANTS
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

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the dialog.
		do
			default_create
			set_title (Interface_names.t_Choose_class)
			set_icon_pixmap (pixmaps.icon_dialog_window)
			prepare
		end

	prepare is
			-- Create the controls and setup the layout
		local
			buttons_box: EV_VERTICAL_BOX
			controls_box: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
				-- Create the button box.
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.set_border_width (Layout_constants.Small_padding_size)
	
			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent on_ok)
			extend_button (buttons_box, ok_button)

			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			extend_button (buttons_box, cancel_button)

			buttons_box.extend (create {EV_CELL})

				-- Create the controls.
			create class_name_entry.make
			create classes_tree.make
			classes_tree.set_minimum_width (Layout_constants.dialog_unit_to_pixels(200))
			classes_tree.set_minimum_height (Layout_constants.dialog_unit_to_pixels(300))
			classes_tree.refresh
			
				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding (Layout_constants.small_padding_size)
			controls_box.set_border_width (Layout_constants.small_padding_size)
			extend_no_expand (controls_box, class_name_entry)
			controls_box.extend (classes_tree)

				-- Pack the buttons_box and the controls.
			create hb
			hb.extend (controls_box)
			extend_no_expand (hb, buttons_box)
			extend (hb)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			classes_tree.associate_textable_with_classes (class_name_entry)
			classes_tree.add_double_click_action_to_classes (agent on_class_double_click)
			show_actions.extend (agent class_name_entry.set_focus)
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
				loclist := Eiffel_universe.classes_with_name (selected_class_name)
				if loclist.is_empty then -- No class has such a name.
					class_name_entry.set_text (Interface_names.l_Unknown_class_name)
					class_name_entry.set_focus
					class_name_entry.select_all
				else
					destroy
				end
			else
				class_name_entry.set_focus
			end
		end

	on_cancel is
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			destroy
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

feature {NONE} -- Controls

	ok_button: EV_BUTTON
			-- "Ok" button.

	cancel_button: EV_BUTTON
			-- "Cancel" button.

	class_name_entry: EB_CHOOSE_CLASS_COMBO_BOX
			-- Combo box where the user can type its class name.

	classes_tree: EB_CLASSES_TREE;
			-- Tree where the user can choose its class.

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

end -- class EB_CHOOSE_CLASS_DIALOG
	
