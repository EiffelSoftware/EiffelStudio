indexing
	description: "Enumerate all child windows of a WEL_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_ENUMERATOR
	
inherit
	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

feature -- Access

	enumerate (a_window: WEL_WINDOW): LIST [WEL_WINDOW] is
			-- Construct a linear representation with all children of `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		local
			window_enumerator_delegate: WEL_ENUM_WINDOW_DELEGATE
		do
			print ("Something happened%N")
			create internal_children.make (1)
			create window_enumerator_delegate.make (Current, $enumerate_child_windows_callback)
			cwel_enum_child_windows_procedure (window_enumerator_delegate, a_window.item)
			Result := internal_children
			internal_children := Void
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal_children: ARRAYED_LIST [WEL_WINDOW]
			-- Temporary container for `enumerate'. Used by `enumerate_child_windows_callback'.
	
	enumerate_child_windows_callback (child_hwnd: POINTER) is
			-- Callback feature called by `enumerate'.
		require
			child_hwnd_not_null: child_hwnd /= default_pointer
		local
			wnd: WEL_WINDOW
		do
			if is_window (child_hwnd) then
				wnd := window_of_item (child_hwnd)
				if wnd /= Void and then wnd.exists then
					internal_children.extend (wnd)
				end
			end
		end	

	cwel_enum_child_windows_procedure (callback: WEL_ENUM_WINDOW_DELEGATE; hwnd: POINTER) is
			-- SDK EnumChildWindows
			-- (from WEL_COMPOSITE_WINDOW)
			-- (export status {NONE})
		external
			"C signature (EIF_POINTER, HWND) use %"wel_enum_child_windows.h%""
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


end -- class WEL_WINDOW_ENUMERATOR

