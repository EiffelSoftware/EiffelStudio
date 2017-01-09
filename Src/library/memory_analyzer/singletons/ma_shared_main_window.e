note
	description: "Summary description for {MA_SHARED_MAIN_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MA_SHARED_MAIN_WINDOW

feature -- Access

	main_window: detachable MA_WINDOW
			-- MA_WINDOW instance
		require
			set: is_main_window_set
		do
			Result := internal_main_window.item
		ensure
			result_not_void: is_main_window_set implies Result /= Void
		end

feature -- Query

	is_main_window_set: BOOLEAN
			-- If main window instance has been set?
		do
			Result := attached internal_main_window.item
		end

	main_window_not_void: BOOLEAN
			-- If main window instance has been set?
		obsolete
			"Use `is_main_window_set` [Jan/2017]"
		do
			Result := is_main_window_set
		end

feature {MA_WINDOW} -- Access

	set_main_window (a_window: like main_window)
			-- Set main_window instance
		require
			a_window_not_void: a_window /= Void
		do
			internal_main_window.put (a_window)
		ensure
			a_window_set: a_window = internal_main_window.item
		end

feature {NONE} -- misc

	internal_main_window: CELL [detachable MA_WINDOW]
			-- MAIN_WINDOW instance's cell.
		once
			create Result.put (Void)
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
