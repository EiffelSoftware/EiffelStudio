indexing
	description: "Delegate used by WEL_DISPATCHER to enable callbacks from Win32 API to WEL managed code"
	external_name: "EiffelSoftware.Runtime.WEL_DISPATCHER_DELEGATE"
	assembly: "EiffelSoftware.Runtime", "5.5.0.0", "neutral", "def26f296efef469"
	date: "$Date$"
	revision: "$Revision$"

external class
	WEL_DISPATCHER_DELEGATE
	
inherit
	MULTICAST_DELEGATE

create
	make
	
feature {NONE} -- Initialization

	make (a_target: SYSTEM_OBJECT; function_ptr: POINTER) is
			-- Create a new delegate object
		external
			"IL creator signature (System.Object, System.IntPtr) use EiffelSoftware.Runtime.WEL_DISPATCHER_DELEGATE"
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
		
end -- class WEL_DISPATCHER_DELEGATE
