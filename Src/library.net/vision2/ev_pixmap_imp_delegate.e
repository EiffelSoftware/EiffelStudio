indexing
	description: "Delegate use to load pixmap"
	external_name: "ISE.Runtime.EV_PIXMAP_IMP_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"

external class
	EV_PIXMAP_IMP_DELEGATE

inherit
	MULTICAST_DELEGATE

create
	make
	
feature {NONE} -- Initialization

	make (target: SYSTEM_OBJECT; function_ptr: POINTER) is
			-- Create a new delegate object
		external
			"IL creator signature (System.Object, System.IntPtr) use ISE.Runtime.EV_PIXMAP_IMP_DELEGATE"
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
