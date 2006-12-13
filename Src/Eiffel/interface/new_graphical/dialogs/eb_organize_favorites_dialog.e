indexing
	description	: "Dialog to organize a set of favorites classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_ORGANIZE_FAVORITES_DIALOG

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

	EB_SHARED_MANAGERS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_favorites_manager: EB_FAVORITES_MANAGER) is
			-- Initialize the dialog with the manager `a_favorites_manager'
		do
			favorites_manager := a_favorites_manager
			create favorites_tree.make (a_favorites_manager, False)
			favorites_tree.select_actions.extend (agent on_selection_change)
			favorites_tree.deselect_actions.extend (agent on_selection_change)
			default_create
			set_title (Interface_names.t_Organize_favorites)
			prepare
		end

	prepare is
			-- Create the controls and setup the layout
		local
			button: EV_BUTTON
			buttons_box: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			cell: EV_CELL
		do
				-- Create the button box
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.set_border_width (Layout_constants.Small_padding_size)

			create button.make_with_text_and_action (Interface_names.b_New_favorite_class, agent new_favorite_class)
			extend_no_expand (buttons_box, button)
			create button.make_with_text_and_action (Interface_names.b_Create_folder, agent create_folder)
			extend_no_expand (buttons_box, button)
			create move_button.make_with_text_and_action (Interface_names.b_Move_to_folder, agent move_to_folder)
			move_button.disable_sensitive
			extend_no_expand (buttons_box, move_button)
			create remove_button.make_with_text_and_action (Interface_names.b_Remove, agent remove)
			remove_button.disable_sensitive
			extend_no_expand (buttons_box, remove_button)
			create cell
			cell.set_minimum_height (Layout_constants.dialog_unit_to_pixels(20))
			buttons_box.extend (cell)
			create close_button.make_with_text_and_action (Interface_names.b_Close, agent close)
			extend_no_expand (buttons_box, close_button)

				-- Pack the buttons_box and the favorites tree
			create hb
			hb.set_border_width (Layout_constants.Small_border_size)
			hb.extend (favorites_tree)
			favorites_tree.set_minimum_width (Layout_constants.dialog_unit_to_pixels(200))
			favorites_tree.set_minimum_height (Layout_constants.dialog_unit_to_pixels(300))
			extend_no_expand (hb, buttons_box)
			extend (hb)
			set_default_cancel_button (close_button)
			show_actions.extend (agent button.set_focus)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
		end

feature {EB_FAVORITES_MANAGER} -- Status Setting

	refresh is
			-- Update `Current's display.
		do
			favorites_tree.refresh
		end

feature {NONE} -- Implementation

	close is
			-- Terminate the dialog
		do
			hide
		end

	remove is
			-- Remove the current selected class.
		require
			at_least_one_item_selected: favorites_tree.selected_item /= Void
		local
			source: EB_FAVORITES_ITEM_LIST
			item_to_remove: EB_FAVORITES_ITEM
		do
				-- Retrieve item to move
			item_to_remove ?= favorites_tree.selected_item.data
			source := item_to_remove.parent
			source.start
			source.prune (item_to_remove)
			move_button.disable_sensitive
			remove_button.disable_sensitive
		end

	new_favorite_class is
			-- Create a new "favorite class" and add it to the
			-- end of the root list.
		local
			choose_class_dialog: EB_CHOOSE_CLASS_DIALOG
			class_name: STRING
		do
			create choose_class_dialog.make
			choose_class_dialog.show_modal_to_window (Current)
			if choose_class_dialog.selected then
				class_name := choose_class_dialog.class_name
				favorites.add_class (class_name)
			end
		end

	create_folder is
			-- create a new folder and add it to the end of the
			-- root list.
		local
			folder_name_dialog: EB_TYPE_FOLDER_DIALOG
			folder_name: STRING
			wd: EB_WARNING_DIALOG
		do
			create folder_name_dialog.make
			folder_name_dialog.show_modal_to_window (Current)
			if folder_name_dialog.selected then
				folder_name := folder_name_dialog.folder_name
				if
					folder_name.has ('(')
					or folder_name.has (')')
					or folder_name.has ('*')
				then
					create wd.make_with_text (Warning_messages.w_Invalid_folder_name + "%N A favorite folder name cannot contain any ot the following characters: %N ( ) * ")
					wd.show_modal_to_window (Current)
				else
					favorites.add_folder (folder_name)
				end
			end
		end

	move_to_folder is
			-- Move the selected item to a given folder.
		require
			at_least_one_item_selected: favorites_tree.selected_item /= Void
		local
			choose_folder_dialog: EB_CHOOSE_FAVORITES_FOLDER_DIALOG
			destination: EB_FAVORITES_ITEM_LIST
			source: EB_FAVORITES_ITEM_LIST
			item_to_move: EB_FAVORITES_ITEM
			conv_folder: EB_FAVORITES_FOLDER
			conv_item: EB_FAVORITES_ITEM
			wd: EB_WARNING_DIALOG
		do
				-- Retrieve item to move
			item_to_move ?= favorites_tree.selected_item.data
			if item_to_move.is_feature then
				create wd.make_with_text (Warning_messages.w_Cannot_move_feature_alone)
				wd.show_modal_to_window (Current)
			else
				source := item_to_move.parent

					-- Retrieve destination
				create choose_folder_dialog.make (favorites_manager)
				choose_folder_dialog.show_modal_to_window (Current)

					-- Move item.
				if choose_folder_dialog.selected then
					destination := choose_folder_dialog.chosen_folder
					conv_folder ?= item_to_move
					conv_item ?= destination
					if
						conv_folder /= Void and then
						conv_item /= Void and then
						conv_folder.has_recursive_child (conv_item)
					then
						create wd.make_with_text (Warning_messages.w_Cannot_move_favorite_to_a_child)
						wd.show_modal_to_window (Current)
					else
						source.prune_all (item_to_move)
						destination.extend (item_to_move)
						item_to_move.set_parent (destination)
					end
				end
				if favorites_tree.selected_item = Void then
					move_button.disable_sensitive
					remove_button.disable_sensitive
				end
			end
		end

feature {NONE} -- Vision2 events

	on_selection_change is
			-- The selection in the tree has changed
		do
			if favorites_tree.selected_item /= Void then
				move_button.enable_sensitive
				remove_button.enable_sensitive
			else
				move_button.disable_sensitive
				remove_button.disable_sensitive
			end
		end

feature {NONE} -- Attributes

	favorites_manager: EB_FAVORITES_MANAGER
			-- Associated manager.

feature {NONE} -- Controls

	remove_button: EV_BUTTON
			-- "Remove" button

	move_button: EV_BUTTON
			-- "Move to Folder" button

	close_button: EV_BUTTON
			-- "Close" button.

	favorites_tree: EB_FAVORITES_TREE;
			-- Tree representing the favorites

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

end -- class EB_ORGANIZE_FAVORITES_DIALOG

