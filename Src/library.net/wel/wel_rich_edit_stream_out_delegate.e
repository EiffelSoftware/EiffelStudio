indexing
	description: "Delegate used by WEL_RICH_EDIT_STREAM_OUT to enable callbacks from Win32 API to WEL managed code"
	external_name: "EiffelSoftware.Runtime.WEL_RICH_EDIT_STREAM_OUT_DELEGATE"
	assembly: "EiffelSoftware.Runtime", "5.5.707.0", "neutral", "def26f296efef469"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

external class
	WEL_RICH_EDIT_STREAM_OUT_DELEGATE

inherit
	MULTICAST_DELEGATE

create
	make

feature {NONE} -- Initialization

	make (a_target: SYSTEM_OBJECT; function_ptr: POINTER) is
			-- Create a new delegate object
		external
			"IL creator signature (System.Object, System.IntPtr) use EiffelSoftware.Runtime.WEL_RICH_EDIT_STREAM_OUT_DELEGATE"
		end

end -- class WEL_RICH_EDIT_STREAM_OUT_DELEGATE
