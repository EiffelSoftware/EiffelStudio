indexing
	description: "Enumerate all child windows of a WEL_WINDOW."
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
		do
			create internal_children.make (1)
			cwel_enum_child_windows_procedure (Current, $enumerate_child_windows_callback,
				a_window.item)
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
				if wnd /= void and then wnd.exists then
					internal_children.extend (wnd)
				end
			end
		end	

	cwel_enum_child_windows_procedure (cur_obj: like Current; callback: POINTER; hwnd: POINTER) is
			-- SDK EnumChildWindows
			-- (from WEL_COMPOSITE_WINDOW)
			-- (export status {NONE})
		external
			"C signature (EIF_OBJECT, EIF_POINTER, HWND) use %"wel_enum_child_windows.h%""
		end

end -- class WEL_WINDOW_ENUMERATOR
