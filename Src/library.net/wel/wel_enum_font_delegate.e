indexing
	description: "Delegate used by WEL_FONT_FAMILY_ENUMERATOR to enable callbacks from Win32 API to WEL managed code"
	external_name: "ISE.Runtime.WEL_ENUM_FONT_DELEGATE"
	assembly: "ise_runtime", "5.2.0.0", "neutral", "def26f296efef469"
	date: "$Date$"
	revision: "$Revision$"

external class
	WEL_ENUM_FONT_DELEGATE
	
inherit
	MULTICAST_DELEGATE

create
	make
	
feature {NONE} -- Initialization

	make (target: SYSTEM_OBJECT; function_ptr: POINTER) is
			-- Create a new delegate object
		external
			"IL creator signature (System.Object, System.IntPtr) use ISE.Runtime.WEL_ENUM_FONT_DELEGATE"
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
		
end -- class WEL_ENUM_FONT_DELEGATE
