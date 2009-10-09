note
	description:
		"Access to GUI elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make
			-- Initialize object.
		do
			create {GUI_IMP}implementation
		end

feature -- Access

	application_under_test: EV_APPLICATION
			-- Application under test
		do
			Result := implementation.application_under_test
		end

	screen: EV_SCREEN
			-- Screen
		do
			Result := implementation.screen
		end

	active_window: EV_WINDOW
			-- Window to use for input and search for widgets
		do
			Result := implementation.active_window
			if Result = Void then
				set_active_window_to_current_focus
				Result := implementation.active_window
			end
		end

	active_dialog: EV_DIALOG
			-- `active_window' as dialog object
		do
			Result ?= active_window
			if Result = Void then
				-- TODO: raise exception, provide help
			end
		end

feature -- Element change

	set_active_window (a_window: EV_WINDOW)
			-- Set `window' to `a_window' and request focus for it.
		require
			a_window_not_void: a_window /= Void
			a_window_valid: application_under_test.windows.has (a_window)
		do
			implementation.set_active_window (a_window)
		ensure
			active_window_set: active_window = a_window
		end

	set_active_window_by_title (a_title: STRING)
			-- Set `active_window' to window with title `a_title'.
		local
			l_window: EV_WINDOW
			l_windows: LINEAR [EV_WINDOW]
		do
			l_windows := application_under_test.windows
			from
				l_windows.start
				l_window := Void
			until
				l_windows.after or l_window /= Void
			loop
				-- TODO: regexp matching
				if l_windows.item.title.is_equal (a_title) then
					l_window := l_windows.item
				else
					l_windows.forth
				end
			end
			if l_window = Void then
				-- TODO: raise exception, provide help
				raise ("window_not_found")
			else
				set_active_window (l_window)
			end
		ensure
			active_window_correct: has_window_with_title (a_title) implies active_window /= Void
		end

	set_active_window_by_name (a_name: STRING)
			-- Set `active_window' to window which has `a_name' as `identifier_name'.
		local
			l_window: EV_WINDOW
		do
			l_window := implementation.window_by_identifier (a_name)
			if l_window = Void then
				-- TODO: raise exception, provide help
				raise ("window_not_found")
			else
				set_active_window (l_window)
			end
		ensure
			active_window_correct: has_window_with_name (a_name) implies active_window /= Void
		end

	set_active_window_to_current_focus
			-- Set `active_window' to window which has currently the focus.
		local
			l_window: EV_WINDOW
			l_windows: LINEAR [EV_WINDOW]
		do
			l_windows := application_under_test.windows.twin
			from
				l_windows.start
			until
				l_windows.after or l_window /= Void
			loop
				if l_windows.item.has_focus then
					l_window := l_windows.item
				else
					l_windows.forth
				end
			end
			if l_window = Void then
				-- TODO: raise exception, provide help
				raise ("window_not_found")
			else
				set_active_window (l_window)
			end
		ensure
			active_window_correct: has_window_with_focus implies active_window /= Void
		end

feature -- Status report

	has_identifiable (a_pattern: STRING): BOOLEAN
			-- Does an identifiable corresponding to `a_pattern' exist in GUI?
		require
			a_pattern_not_void: a_pattern /= Void
			a_pattern_valid: -- is_valid_pattern (a_pattern)
		do
			Result := implementation.identifiable (a_pattern) /= Void
		end

	has_widget_with_name (a_name: STRING): BOOLEAN
			-- Does a widget with `identifier_name' `a_name' exist in GUI?
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			-- TODO
		end

	has_window_with_title (a_title: STRING): BOOLEAN
			-- Does a window with title `a_title' exist in GUI?
		require
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
		do
			-- TODO
		end

	has_window_with_name (a_name: STRING): BOOLEAN
			-- Does a window with `identifier_name' `a_name' exist in GUI?
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			-- TODO
		end

	has_window_with_focus: BOOLEAN
			-- Does a window with focus exist in GUI?
		do
			-- TODO
		end

feature -- Basic lookup

	identifiable (a_pattern: STRING): EV_IDENTIFIABLE
			-- Identifiable according to `a_pattern'
			-- Pattern syntax:
			--   name				lookup a name
			--   {TYPE}				lookup a type
			--   {TYPE}name			lookup a type and name
			--   parent.name			lookup a direct parent-child relationship
			--   parent..name		lookup a direct or indirect parent-child relationship
			--   window:name			lookup a name on a window
			-- Example of a combination:
			--   window:{TYPE}indirect-parent..direct-parent.{TYPE}name
			--
			-- not supported yet:
			--	type syntax on window
		require
			a_pattern_not_void: a_pattern /= Void
			a_pattern_valid: valid_pattern (a_pattern)
		do
			Result := implementation.identifiable (a_pattern)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("identifiable_not_found")
			end
		ensure
			result_correct: has_identifiable (a_pattern) implies Result /= Void
		end

	identifiables (a_pattern: STRING): LIST [EV_IDENTIFIABLE]
			-- All identifiables according to `a_pattern'
			-- See `identifiable' for more information about pattern syntax.
		require
			a_pattern_not_void: a_pattern /= Void
			a_pattern_valid: valid_pattern (a_pattern)
		do
			Result := implementation.identifiables (a_pattern)
		ensure
			result_not_void: Result /= Void
			result_correct: has_identifiable (a_pattern) implies not Result.is_empty
		end

feature -- Advanced lookup

	widget_by_name (a_name: STRING): EV_WIDGET
			-- Get widget with `a_name' in `active_window'.
			-- Widget will be looked for recursively.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result ?= implementation.identifiable (a_name)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("widget_not_found")
			end
		ensure
			result_correct: -- has_widget_with_name (a_name) implies Result /= Void
		end

	container_by_name (a_name: STRING): EV_CONTAINER
			-- Get container with `a_name' in `active_window'.
			-- Container will be looked for recursively.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result ?= implementation.identifiable (a_name)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("container_not_found")
			end
		ensure
			result_correct: -- has_container_with_name (a_name) implies Result /= Void
		end

	item_by_name (a_name: STRING): EV_ITEM
			-- Get item with `a_name' in `active_window'.
			-- Items will be looked for recursively.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result ?= implementation.identifiable (a_name)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("item_not_found")
			end
		ensure
			result_correct: -- has_item_with_name (a_name) implies Result /= Void
		end

	item_list_by_name (a_name: STRING): EV_ITEM_LIST [EV_ITEM]
			-- Get item list with `a_name' in `active_window'.
			-- Items list will be looked for recursively.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result ?= implementation.identifiable (a_name)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("item_list_not_found")
			end
		ensure
			result_correct: -- has_item_list_with_name (a_name) implies Result /= Void
		end

feature -- Menu lookup

	menu_by_name (a_name: STRING): EV_MENU_ITEM
			-- Menu on main menu bar of `active_window' with `identifier_name' `a_name'
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result ?= implementation.identifiable ("{EV_MENU_BAR}."+a_name)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("menu_not_found")
			end
		ensure
			result_correct: -- has_menu_with_name (a_name) implies Result /= Void
		end

	sub_menu_by_name (a_parent: EV_MENU_ITEM; a_name: STRING): EV_MENU_ITEM
			-- Menu item of `a_parent' with `identifier_name' `a_name'
		require
			a_parent_not_void: a_parent /= Void
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result ?= implementation.identifiable (a_parent.full_identifier_path+"."+a_name)
			if Result = Void then
				-- TODO: raise exception, provide help
				raise ("sub_menu_not_found")
			end
		ensure
			result_correct: -- has_sub_menu_with_name (a_parent, a_name) implies Result /= Void
		end

	menu_by_path (a_path: STRING): EV_MENU_ITEM
			-- Menu item on menu bar of `active_window' denoted by `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		local
			l_segments: LIST [STRING]
		do
			l_segments := a_path.split ('.')
			from
				l_segments.start
			until
				l_segments.after
			loop
				if Result = Void then
					Result := menu_by_name (l_segments.item)
				else
					Result := sub_menu_by_name (Result, l_segments.item)
				end
				l_segments.forth
			end
		end

	menu_items_by_path (a_path: STRING): LIST [EV_MENU_ITEM]
			-- Menu items of `active_window' on `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		local
			l_segments: LIST [STRING]
		do
			l_segments := a_path.split ('.')
			from
				create {LINKED_LIST [EV_MENU_ITEM]}Result.make
				l_segments.start
			until
				l_segments.after
			loop
				if Result.is_empty then
					Result.extend (menu_by_name (l_segments.item))
				else
					Result.extend (sub_menu_by_name (Result.last, l_segments.item))
				end
				l_segments.forth
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Support

	valid_pattern (a_pattern: STRING): BOOLEAN
			-- Is `a_pattern' valid to use for searching?
		do
			Result := implementation.valid_pattern (a_pattern)
		end

feature {VISION2_TEST} -- Implementation

	implementation: GUI_I
			-- Implementation of GUI interface

invariant

	implementation_not_void: implementation /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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

end
