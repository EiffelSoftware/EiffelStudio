note
	description: "Enumerate all child windows of a WEL_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_ENUMERATOR

inherit
	ANY

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

feature -- Access

	enumerate (a_window: WEL_WINDOW): LIST [WEL_WINDOW]
			-- Construct a linear representation with all children of `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			Result := enumerate_hwnd (a_window.item)
		ensure
			result_not_void: Result /= Void
		end

	enumerate_hwnd (a_hwnd: POINTER): ARRAYED_LIST [WEL_WINDOW]
			-- Construct a linear representation with all children of `a_hwnd'.
		require
			a_hwnd_not_null: a_hwnd /= default_pointer
		local
			window_enumerator_delegate: WEL_ENUM_WINDOW_DELEGATE
		do
			create Result.make (1)
			internal_children := Result
			create window_enumerator_delegate.make (Current, $enumerate_child_windows_callback)
			cwel_enum_child_windows_procedure (window_enumerator_delegate, a_hwnd)
			internal_children := Void
		ensure
			result_not_void: Result /= Void
		end

	enumerate_all_windows: ARRAYED_LIST [WEL_WINDOW]
			-- Construct a linear representation with all windows.
		local
			window_enumerator_delegate: WEL_ENUM_WINDOW_DELEGATE
		do
			create Result.make (1)
			internal_children := Result
			create window_enumerator_delegate.make (Current, $enumerate_child_windows_callback)
			cwel_enum_windows_procedure (window_enumerator_delegate)
			internal_children := Void
		ensure
			result_not_void: Result /= Void
		end

	enumerate_all_hwnds: ARRAYED_LIST [POINTER]
			-- Construct a linear representation with all handle of windows.
		local
			window_enumerator_delegate: WEL_ENUM_WINDOW_DELEGATE
		do
			create Result.make (1)
			internal_hwnds := Result
			create window_enumerator_delegate.make (Current, $enumerate_hwnd_callback)
			cwel_enum_windows_procedure (window_enumerator_delegate)
			internal_hwnds := Void
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal_children: detachable ARRAYED_LIST [WEL_WINDOW]
			-- Temporary container for `enumerate'. Used by `enumerate_child_windows_callback'.

	internal_hwnds: detachable ARRAYED_LIST [POINTER]
			-- Temporary container for `enumerate_all_hwnds'. Used by `enumerate_hwnd_callback'.

	enumerate_child_windows_callback (child_hwnd: POINTER)
			-- Callback feature called by `enumerate'.
		require
			child_hwnd_not_null: child_hwnd /= default_pointer
		local
			wnd: detachable WEL_WINDOW
		do
			if attached internal_children as l_children then
				if is_window (child_hwnd) then
					wnd := window_of_item (child_hwnd)
					if wnd /= Void and then wnd.exists then
						l_children.extend (wnd)
					end
				end
			end
		end

	enumerate_hwnd_callback (a_hwnd: POINTER)
			-- Callback feature called by `enumerate'.
		local
			l_null: POINTER
		do
			if a_hwnd /= l_null and attached internal_hwnds as l_hwnds and is_window (a_hwnd) then
				l_hwnds.extend (a_hwnd)
			end
		end

	cwel_enum_child_windows_procedure (callback: WEL_ENUM_WINDOW_DELEGATE; hwnd: POINTER)
			-- SDK EnumChildWindows
			-- (from WEL_COMPOSITE_WINDOW)
			-- (export status {NONE})
		external
			"C signature (EIF_POINTER, HWND) use %"wel_enum_child_windows.h%""
		end

	cwel_enum_windows_procedure (callback: WEL_ENUM_WINDOW_DELEGATE)
			-- SDK EnumChildWindows
			-- (from WEL_COMPOSITE_WINDOW)
			-- (export status {NONE})
		external
			"C signature (EIF_POINTER) use %"wel_enum_child_windows.h%""
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class WEL_WINDOW_ENUMERATOR

