indexing
	description: "Delegate use to load pixmap"
	external_name: "EiffelSoftware.Runtime.EV_PIXMAP_IMP_DELEGATE"
	assembly: "EiffelSoftware.Runtime", "5.5.0.0", "neutral", "def26f296efef469"
	date: "$Date$"
	revision: "$Revision$"

external class
	EV_PIXMAP_IMP_DELEGATE

inherit
	MULTICAST_DELEGATE

create
	make
	
feature {NONE} -- Initialization

	make (a_target: SYSTEM_OBJECT; function_ptr: POINTER) is
			-- Create a new delegate object
		external
			"IL creator signature (System.Object, System.IntPtr) use EiffelSoftware.Runtime.EV_PIXMAP_IMP_DELEGATE"
		end

--feature -- Delegate implementation
--
--	begin_invoke (hwnd: POINTER; msg, wparam, lparam: INTEGER; callback: ASYNC_CALLBACK; obj: SYSTEM_OBJECT): IASYNC_RESULT is
--		indexing
--			external_name: "BeginInvoke"
--		do
--			-- Automatically built by .NET runtime
--		end
--		
--	end_invoke (res: IASYNC_RESULT): INTEGER is
--		indexing
--			external_name: "EndInvoke"
--		do
--			-- Automatically built by .NET runtime
--		end
--		
--	invoke (hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
--		indexing
--			external_name: "Invoke"
--		do
--			-- Automatically built by .NET runtime
--		end
--		

end -- class EV_PIXMAP_IMP_DELEGATE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

