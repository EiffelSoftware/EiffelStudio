indexing
	description	: "Facade to access, manipulate, organize, .. the favorites."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_MANAGER

inherit
	EB_CONSTANTS

	EB_SHARED_MANAGERS

	EB_RECYCLABLE
	
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

	go_to (a_favorite_class: EB_FAVORITES_CLASS) is
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

feature -- Basic Operations

	cleanup is
			-- Routine to be called when this manager has became useless.
		do
			favorites.remove_observer (widget)
			favorites.remove_observer (menu)
		end

	add_class is
			-- Add current class in `class_window' to the favorites.
		local
			class_name: STRING
			development_window_class_name: STRING
		do
			development_window_class_name := development_window.class_name
			if development_window_class_name /= Void then
				class_name := clone (development_window_class_name)
				class_name.to_upper
				favorites.add_class (class_name)
			end
		end

	organize_favorites is
			-- Display a dialog to organize the favorites.
		do
			create organize_favorites_dialog.make (Current)

				-- Disable all windows sensitivity (to avoid pick&drop pbs).
			window_manager.disable_all

				-- Show the dialog.
			organize_favorites_dialog.show_modal_to_window (window_manager.last_focused_development_window.window)

				-- Enable all windows sensitivity back.
			window_manager.enable_all
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
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			widget.recycle
			menu.recycle
			cleanup
			menu := Void
			widget := Void
		end

feature {EB_FAVORITES_MENU} -- Implementation
		
	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window.

	organize_favorites_dialog: EB_ORGANIZE_FAVORITES_DIALOG
			-- Dialog window to organize the favorites.

end -- class EB_FAVORITES
