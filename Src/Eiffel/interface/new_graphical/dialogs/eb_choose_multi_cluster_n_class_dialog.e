note
	description: "Dialog to choose multi classes and clusters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tedf"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CHOOSE_MULTI_CLUSTER_N_CLASS_DIALOG

inherit
	EB_DIALOG

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
	make,
	make_with_targets

feature {NONE} -- Initialization

	make (a_factory: EB_CONTEXT_MENU_FACTORY)
			-- Initialize the dialog.			
		do
			default_create
			set_title (Interface_names.t_Add_search_scope)
			prepare (a_factory)
		end

	make_with_targets (a_factory: EB_CONTEXT_MENU_FACTORY)
			-- Initialize the dialog and make sure targets are displayed in current dialog.
		do
			show_targets := True
			make (a_factory)
		end

	prepare (a_factory: EB_CONTEXT_MENU_FACTORY)
			-- Create the controls and setup the layout
		local
			buttons_box: EV_HORIZONTAL_BOX
			controls_box: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
		do
			set_width (260)

				-- Create the button box.
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.set_border_width (Layout_constants.Small_padding_size)

			buttons_box.extend (create {EV_CELL})

			create add_button.make_with_text_and_action (Interface_names.b_add, agent on_add)
			extend_button (buttons_box, add_button)

			create ok_button.make_with_text_and_action (Interface_names.b_close, agent on_ok)
			extend_button (buttons_box, ok_button)

				-- Create the controls.
			if show_targets then
				create classes_tree.make (a_factory)
			else
				create classes_tree.make_without_targets (a_factory)
			end
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
		end

feature -- Access

	selected: BOOLEAN
			-- Has the user selected a class (True) or pushed
			-- the cancel button (False)?

	show_targets: BOOLEAN
			-- Will targets be shown in curernt dialog?

	class_name: STRING
			-- class selected by the user, if any.
		require
			selected: selected
		do
			Result := selected_class_name
		end

	classes_tree: EB_CLASSES_TREE
			-- Tree where the user can choose its class.

feature -- Element Change

	set_class_add_action (action: like on_class_add)
			-- set class add action
		require
			action_not_void: action /= Void
		do
			on_class_add := action
		end

	set_cluster_add_action (action: like on_cluster_add)
			-- set cluster add action
		require
			action_not_void: action /= Void
		do
			on_cluster_add := action
		end

	set_folder_add_action (action: like on_folder_add)
		require
			action_not_void: action /= Void
		do
			on_folder_add := action
		end

	set_target_add_action (action: like on_target_add)
			-- Set `on_target_add' with `action'.
		require
			a_action_attached: action /= Void
		do
			on_target_add := action
		ensure
			on_target_add_set: on_target_add = action
		end

feature {NONE} -- Implementation

	selected_class_name: STRING
			-- name of the selected class, if any.

	object: ANY
			-- operations can be committed on this object

feature {NONE} -- Vision2 events

	on_add
			-- add a do add operations to object.
		require
			on_class_add_set: on_class_add /= Void
			on_folder_add_set: on_folder_add /= Void
			on_cluster_add_set: on_cluster_add /= Void
		local
			l_class: CLASS_I
			l_cluster: EB_SORTED_CLUSTER
			l_item : EB_CLASSES_TREE_FOLDER_ITEM
			l_conf_cluster: CONF_CLUSTER
			l_target: EB_CLASSES_TREE_TARGET_ITEM
		do
			if classes_tree.selected_item /= Void then
				l_class ?= classes_tree.selected_item.data
				l_cluster ?= classes_tree.selected_item.data
				l_item ?= classes_tree.selected_item
				l_target ?= classes_tree.selected_item
				if l_class /= Void then
					on_class_add.call ([l_class])
				elseif l_target /= Void and then on_target_add /= Void then
					on_target_add.call ([l_target.stone.target])
				elseif l_cluster /= Void and then l_cluster.actual_group /= Void then
					if l_item /= Void and then not l_item.path.is_empty then
						l_conf_cluster ?= l_cluster.actual_group
						check
							l_conf_cluster_not_void: l_conf_cluster /= Void
						end
						on_folder_add.call ([create {EB_FOLDER}.make_with_name (l_conf_cluster, l_item.path, l_item.name)])
					else
						on_cluster_add.call ([l_cluster.actual_group])
					end
				end
			end
		end

	on_class_add: PROCEDURE [ANY, TUPLE [CLASS_I]]

	on_cluster_add: PROCEDURE [ANY, TUPLE [CONF_GROUP]]

	on_folder_add: PROCEDURE [ANY, TUPLE [EB_FOLDER]]

	on_target_add: PROCEDURE [ANY, TUPLE [CONF_TARGET]]

	on_ok
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			hide
		end

	on_class_double_click (	x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER )
			-- Call on_ok through an agent compatible with double click actions.
		do
			on_ok
		end

feature {NONE} -- Controls

	add_button: EV_BUTTON
			-- "Add button"

	ok_button: EV_BUTTON;
			-- "Ok" button.

note
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

