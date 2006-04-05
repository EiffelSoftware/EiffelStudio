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
			development_window_class_name: STRING
		do
			development_window_class_name := development_window.class_name
			if development_window_class_name /= Void then
				favorites.add_class (development_window_class_name.as_upper)
			end
		end

	organize_favorites is
			-- Display a dialog to organize the favorites.
		do
				-- Show the dialog if not already shown, otherwise raise the dialog topmost.
			if not organize_favorites_dialog.is_displayed then
				organize_favorites_dialog.show
			else
				organize_favorites_dialog.raise
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
