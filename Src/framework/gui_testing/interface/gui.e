indexing
	description:
		"Access to GUI elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI

create
	make

feature {NONE} -- Implementation

	make is
			-- Initialize object.
		do
			create {GUI_IMP}implementation
		end

feature -- Access

	application_under_test: EV_APPLICATION is
			-- Application under test
		do
			Result := implementation.application_under_test
		end

	screen: EV_SCREEN is
			-- Screen
		do
			Result := implementation.screen
		end

	active_window: EV_WINDOW is
			-- Window to use for input and search for widgets
		do
			Result := implementation.active_window
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

	set_active_window (a_window: EV_WINDOW) is
			-- Set `window' to `a_window' and request focus for it.
		require
			a_window_not_void: a_window /= Void
			a_window_valid: application_under_test.windows.has (a_window)
		do
			implementation.set_active_window (a_window)
		ensure
			active_window_set: active_window = a_window
		end

	set_active_window_by_title (a_title: STRING) is
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
			else
				set_active_window (l_window)
			end
		ensure
			active_window_correct: has_window_with_title (a_title) implies active_window /= Void
		end

	set_window_by_name (a_name: STRING) is
			-- Set `window' to window which has `a_name' as `identifier_name'.
		local
			l_window: EV_WINDOW
			l_windows: LINEAR [EV_WINDOW]
		do
			l_windows := application_under_test.windows
			from
				l_windows.start
			until
				l_windows.after or l_window /= Void
			loop
				-- TODO: regexp matching
				if l_windows.item.identifier_name.is_equal (a_name) then
					l_window := l_windows.item
				else
					l_windows.forth
				end
			end
			if l_window = Void then
				-- TODO: raise exception, provide help
			else
				set_active_window (l_window)
			end
		ensure
			active_window_correct: has_window_with_name (a_name) implies active_window /= Void
		end

	set_active_window_to_current_focus is
			-- Set `active_window' to window which has currently the focus.
		local
			l_window: EV_WINDOW
			l_windows: LINEAR [EV_WINDOW]
		do
			l_windows := application_under_test.windows
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
			else
				set_active_window (l_window)
			end
		ensure
			active_window_correct: has_window_with_focus implies active_window /= Void
		end

feature -- Status report

	has_widget_with_name (a_name: STRING): BOOLEAN is
			-- Does a widget with `identifier_name' `a_name' exist in GUI?
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			-- TODO
		end

	has_window_with_title (a_title: STRING): BOOLEAN is
			-- Does a window with title `a_title' exist in GUI?
		require
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
		do
			-- TODO
		end

	has_window_with_name (a_name: STRING): BOOLEAN is
			-- Does a window with `identifier_name' `a_name' exist in GUI?
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			-- TODO
		end

	has_window_with_focus: BOOLEAN is
			-- Does a window with focus exist in GUI?
		do
			-- TODO
		end

feature -- Widget access

	widget_by_name (a_name: STRING): EV_WIDGET
			-- Get widget with `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			check_window

			if Result = Void then
				-- TODO: raise exception, provide help
			end
		ensure
			result_correct: has_widget_with_name (a_name) implies Result /= Void
		end

feature -- Menu access

	menu_by_title (a_title: STRING): EV_MENU_ITEM is
			-- Menu on main menu bar of `window' with title `a_title'
		require
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
		do
			check_window
		ensure
			result_correct: -- has_menu_with_title (a_title) implies Result /= Void
		end

	menu_by_name (a_name: STRING): EV_MENU_ITEM is
			-- Menu on main menu bar of `window' with `identifier_name' `a_name'
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do

		ensure
			result_correct: -- has_menu_with_name (a_name) implies Result /= Void
		end

	sub_menu_by_title (a_parent: EV_MENU_ITEM; a_title: STRING): EV_MENU_ITEM is
			-- Menu item of `a_parent' with title `a_title'
		require
			a_parent_not_void: a_parent /= Void
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
		do

		ensure
			result_correct: -- has_sub_menu_with_title (a_parent, a_title) implies Result /= Void
		end

	sub_menu_by_name (a_parent: EV_MENU_ITEM; a_name: STRING): EV_MENU_ITEM is
			-- Menu item of `a_parent' with `identifier_name' `a_name'
		require
			a_parent_not_void: a_parent /= Void
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do

		ensure
			result_correct: -- has_sub_menu_with_name (a_parent, a_name) implies Result /= Void
		end

	popup_menu_by_title (a_title: STRING): EV_MENU_ITEM is
			-- Menu item of active popup menu of `ev_application' with title `a_title'
		require
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
			active_popup_menu: application_under_test.popup_menu /= Void
		do

		ensure
			result_correct: -- has_popup_menu_with_title (a_title) implies Result /= Void
		end

	popup_menu_by_name (a_name: STRING): EV_MENU_ITEM is
			-- Menu item of active popup menu of `ev_application' with `identifier_name' `a_name'
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			active_popup_menu: application_under_test.popup_menu /= Void
		do

		ensure
			result_correct: -- has_popup_menu_with_name (a_name) implies Result /= Void
		end

feature {VISION2_TEST} -- Implementation

	implementation: GUI_I
			-- Implementation of GUI interface

	check_window is
			-- Check active window.
		do
--			if window = Void then
--				application_under_test.windows.do_all (agent (a_window: EV_WINDOW) do if a_window.has_focus then window := a_window	end end)
--			end
		end

invariant

	implementation_not_void: implementation /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
