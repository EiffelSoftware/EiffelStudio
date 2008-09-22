indexing
	description	: "Facade to access, manipulate, organize, .. the favorites."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_MANAGER

inherit
	EB_CONSTANTS

	EB_SHARED_MANAGERS

	EB_RECYCLABLE

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: EB_TOOL_MANAGER) is
			-- Initialization: build the widget and the menu.
		do
			development_window ?= a_parent
			create widget.make (Current, True)
			create menu.make (Current)
		end

feature -- Access

	widget: EB_FAVORITES_TREE
			-- Widget corresponding to the tree of favorites.

	menu: EB_FAVORITES_MENU
			-- Menu corresponding to the favorites.

feature -- Status setting

	go_to_class (a_favorite_class: EB_FAVORITES_CLASS) is
			-- `a_favorite_class' has been selected, the associated class
			-- window should load the class corresponding to `a_favorite_class'.
		local
			class_stone: CLASSI_STONE
		do
			class_stone := a_favorite_class.associated_class_stone
			if class_stone /= Void then
				development_window.set_stone (class_stone)
			end
		end

	go_to_feature (a_favorite_feat: EB_FAVORITES_FEATURE) is
			-- `a_favorite_feat' has been selected, the associated feature
			-- window should load the class corresponding to `a_favorite_feat'.
		local
			feat_stone: FEATURE_STONE
		do
			feat_stone := a_favorite_feat.associated_feature_stone
			if feat_stone /= Void then
				development_window.set_stone (feat_stone)
			end
		end

feature -- Status report

	veto_pebble_function (a_pebble: ANY): BOOLEAN is
			-- Veto pebble function
		local
			l_class_stone: CLASSI_STONE
		do
			l_class_stone ?= a_pebble
			Result := l_class_stone /= Void
		end

feature -- Basic Operations

	cleanup is
			-- Routine to be called when this manager has became useless.
		do
			if favorites /= Void then
				favorites.remove_observer (widget)
				favorites.remove_observer (menu)
			end
		end

	add_class is
			-- Add current class in `class_window' to the favorites.
		local
			development_window_class_name: STRING
		do
			development_window_class_name := development_window.class_name
			if development_window_class_name /= Void then
				favorites.add_class (development_window_class_name.as_upper)
			end
		end

	add_stone (a_stone: STONE) is
			-- Add `a_stone' to favorites.
		do
			if widget /= Void then
				widget.add_stone (a_stone)
			end
		end

	organize_favorites is
			-- Display a dialog to organize the favorites.
		do
				-- Show the dialog if not already shown, otherwise raise the dialog topmost.
			organize_favorites_dialog.raise
		end

	remove (a_item: EB_FAVORITES_ITEM) is
			-- Remove `a_item' from favorites.
		require
			a_item_not_void: a_item /= Void
		local
			source: EB_FAVORITES_ITEM_LIST
		do
			source := a_item.parent
			source.start
			source.prune (a_item)
		end

	new_favorite_class (a_window: EV_WINDOW) is
			-- Create a new "favorite class" and add it to the
			-- end of the root list.
		local
			choose_class_dialog: EB_CHOOSE_CLASS_DIALOG
			class_name: STRING
			l_window: EB_DEVELOPMENT_WINDOW
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			l_window := development_window
			l_factory := l_window.menus.context_menu_factory
			create choose_class_dialog.make
			choose_class_dialog.show_on_active_window

			if choose_class_dialog.selected then
				class_name := choose_class_dialog.class_name
				favorites.add_class (class_name)
			end
		end

	create_folder (a_window: EV_WINDOW) is
			-- create a new folder and add it to the end of the
			-- root list.
		local
			folder_name_dialog: EB_TYPE_FOLDER_DIALOG
			folder_name: STRING
		do
			create folder_name_dialog.make
			if a_window /= Void then
				folder_name_dialog.show_modal_to_window (a_window)
			else
				folder_name_dialog.show_modal_to_window (development_window.window)
			end
			if folder_name_dialog.selected then
				folder_name := folder_name_dialog.folder_name
				if
					folder_name.has ('(')
					or folder_name.has (')')
					or folder_name.has ('*')
				then
					prompts.show_error_prompt (Warning_messages.w_Invalid_folder_name.as_string_32 + warning_messages.w_Folder_name_cannot_contain, a_window, Void)
				else
					favorites.add_folder (folder_name)
				end
			end
		end

	move_to_folder (a_item: EB_FAVORITES_ITEM; a_window: EV_WINDOW) is
			-- Move the selected item to a given folder.
		require
			a_item_not_void: a_item /= Void
		local
			choose_folder_dialog: EB_CHOOSE_FAVORITES_FOLDER_DIALOG
			destination: EB_FAVORITES_ITEM_LIST
			source: EB_FAVORITES_ITEM_LIST
			conv_folder: EB_FAVORITES_FOLDER
			conv_item: EB_FAVORITES_ITEM
			l_window: EV_WINDOW
		do
			if a_window /= Void then
				l_window := a_window
			else
				l_window := development_window.window
			end
			if a_item.is_feature then
				prompts.show_error_prompt (Warning_messages.w_Cannot_move_feature_alone, l_window, Void)
			else
				source := a_item.parent

					-- Retrieve destination
				create choose_folder_dialog.make (Current)
				choose_folder_dialog.show_modal_to_window (l_window)

					-- Move item.
				if choose_folder_dialog.selected then
					destination := choose_folder_dialog.chosen_folder
					conv_folder ?= a_item
					conv_item ?= destination
					if
						conv_folder /= Void and then
						conv_item /= Void and then
						conv_folder.has_recursive_child (conv_item)
					then
						prompts.show_error_prompt (Warning_messages.w_Cannot_move_favorite_to_a_child, l_window, Void)
					else
						source.prune_all (a_item)
						destination.extend (a_item)
						a_item.set_parent (destination)
					end
				end
			end
		end


feature -- Load / Save / Reset...

	reset is
			-- Reset the favorites.
		do
			favorites.wipe_out
		end

	refresh is
			-- Update `Current's display.
		do
			widget.refresh
			menu.refresh
			organize_favorites_dialog.refresh
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if widget /= Void then
				widget.recycle
			end
			if menu /= Void then
				menu.recycle
			end
			cleanup
			menu := Void
			widget := Void
			development_window := Void
		end

feature {EB_FAVORITES_MENU, EB_FAVORITES_TREE} -- Implementation

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window.

	organize_favorites_dialog: EB_ORGANIZE_FAVORITES_DIALOG is
			-- Dialog window to organize the favorites.
		once
			create Result.make (Current)
		ensure
			result_not_void: Result /= Void
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

end -- class EB_FAVORITES
