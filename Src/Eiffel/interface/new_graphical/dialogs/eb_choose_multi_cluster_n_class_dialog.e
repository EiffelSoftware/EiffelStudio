indexing
	description: "Dialog to choose multi classes and clusters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tedf"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOOSE_MULTI_CLUSTER_N_CLASS_DIALOG

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
			set_title (Interface_names.t_Add_search_scope)
			prepare
		end

	prepare is
			-- Create the controls and setup the layout
		local
			buttons_box: EV_HORIZONTAL_BOX
			controls_box: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
		do
				-- Create the button box.
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.set_border_width (Layout_constants.Small_padding_size)

			create add_button.make_with_text_and_action (Interface_names.b_add, agent on_add)
			extend_button (buttons_box, add_button)

			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent on_ok)
			extend_button (buttons_box, ok_button)

			buttons_box.extend (create {EV_CELL})

				-- Create the controls.
			create classes_tree.make
			classes_tree.set_minimum_width (Layout_constants.dialog_unit_to_pixels(200))
			classes_tree.set_minimum_height (Layout_constants.dialog_unit_to_pixels(300))
			classes_tree.refresh

				-- Create the top panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding (Layout_constants.small_padding_size)
			controls_box.set_border_width (Layout_constants.small_padding_size)
			controls_box.extend (classes_tree)

				-- Pack the buttons_box and the controls.
			create vb
			vb.extend (controls_box)
			extend_no_expand (vb, buttons_box)
			extend (vb)
			set_default_push_button (add_button)
			set_default_cancel_button (ok_button)
--			classes_tree.add_double_click_action_to_classes (agent on_class_double_click)
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

feature -- Element Change

	set_class_add_action (action: PROCEDURE [ANY, TUPLE [CLASS_I]]) is
			-- set class add action
		do
			on_class_add := action
		end

	set_cluster_add_action (action: PROCEDURE [ANY, TUPLE [CONF_GROUP]]) is
			-- set cluster add action
		do
			on_cluster_add := action
		end

feature {NONE} -- Implementation

	selected_class_name: STRING
			-- name of the selected class, if any.

	object: ANY
			-- operations can be committed on this object

feature {NONE} -- Vision2 events

	on_add is
			-- add a do add operations to object.
		local
			l_class: CLASS_I
			l_cluster: EB_SORTED_CLUSTER
		do
			if classes_tree.selected_item /= Void then
				l_class ?= classes_tree.selected_item.data
				l_cluster ?= classes_tree.selected_item.data
				if l_class /= Void then
					on_class_add.call ([l_class])
				end
				if l_cluster /= Void and then l_cluster.actual_group /= Void then
					on_cluster_add.call ([l_cluster.actual_group])
				end
			end
		end

	on_class_add: PROCEDURE [ANY, TUPLE [CLASS_I]]

	on_cluster_add: PROCEDURE [ANY, TUPLE [CONF_GROUP]]

	on_ok is
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

	add_button: EV_BUTTON
			-- "Add button"

	ok_button: EV_BUTTON
			-- "Ok" button.

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

