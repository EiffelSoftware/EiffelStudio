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
		local
			window_enumerator_delegate: WEL_ENUM_WINDOW_DELEGATE
			l_result: like internal_children
		do
			print ("Something happened%N")
			create l_result.make (1)
			internal_children := l_result
			Result := l_result
			create window_enumerator_delegate.make (Current, $enumerate_child_windows_callback)
			cwel_enum_child_windows_procedure (window_enumerator_delegate, a_window.item)
			internal_children := Void
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal_children: detachable ARRAYED_LIST [WEL_WINDOW]
			-- Temporary container for `enumerate'. Used by `enumerate_child_windows_callback'.
	
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

	cwel_enum_child_windows_procedure (callback: WEL_ENUM_WINDOW_DELEGATE; hwnd: POINTER)
			-- SDK EnumChildWindows
			-- (from WEL_COMPOSITE_WINDOW)
			-- (export status {NONE})
		external
			"C signature (EIF_POINTER, HWND) use %"wel_enum_child_windows.h%""
		end

note
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

