indexing
	description:
		"Access to GUI elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI

feature -- Access

	application_under_test: EV_APPLICATION
			-- Application under test

	window: EV_WINDOW
			-- Window to use for input and search for widgets

	dialog: EV_DIALOG
			-- `window' as dialog object
		do
			Result ?= window
			if Result = Void then
				-- TODO: raise exception, provide help
			end
		end

feature -- Element change

	set_application_under_test (an_app: EV_APPLICATION) is
			-- Set `ev_application' to `an_app'.
		require
			an_app_not_void: an_app /= Void
		do
			application_under_test := an_app
		ensure
			application_under_test_set: application_under_test = an_app
		end

	set_window (a_window: EV_WINDOW) is
			-- Set `window' to `a_window'.
		do
			window := a_window
		end

	set_active_window (a_window: EV_WINDOW) is
			-- Set `window' to `a_window' and request focus for it.
		require
			a_window_not_void: a_window /= Void
		do
			set_window (a_window)
			window.show
			window.set_focus
		end

	set_window_by_title (a_title: STRING) is
			-- Set `window' to window with title `a_title'.
		local
			windows: LINEAR [EV_WINDOW]
		do
			windows := application_under_test.windows
			from
				windows.start
				window := Void
			until
				windows.after or window /= Void
			loop
				-- TODO: regexp matching
				if windows.item.title.is_equal (a_title) then
					window := windows.item
				else
					windows.forth
				end
			end
			if window = Void then
				-- TODO: raise exception, provide help
			end
		ensure
			window_correct: has_window_with_title (a_title) implies window /= Void
		end

	set_window_by_name (a_name: STRING) is
			-- Set `window' to window which has `a_name' as `identifier_name'.
		local
			windows: LINEAR [EV_WINDOW]
		do
			windows := application_under_test.windows
			from
				windows.start
				window := Void
			until
				windows.after or window /= Void
			loop
				-- TODO: regexp matching
				if windows.item.identifier_name.is_equal (a_name) then
					window := windows.item
				else
					windows.forth
				end
			end
			if window = Void then
				-- TODO: raise exception, provide help
			end
		ensure
			window_correct: has_window_with_name (a_name) implies window /= Void
		end

	set_window_to_current_focus is
			-- Set `window' to window which has currently the focus.
		local
			windows: LINEAR [EV_WINDOW]
		do
			windows := application_under_test.windows
			from
				windows.start
				window := Void
			until
				windows.after or window /= Void
			loop
				if windows.item.has_focus then
					window := windows.item
				else
					windows.forth
				end
			end
			if window = Void then
				-- TODO: raise exception, provide help
			end
		ensure
			window_correct: -- has_window_with_focus implies window /= Void
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

feature {NONE} -- Implementation

	check_window is
			-- Check active window.
		do
			if window = Void then
				application_under_test.windows.do_all (agent (a_window: EV_WINDOW) do if a_window.has_focus then window := a_window	end end)
			end
		end

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
