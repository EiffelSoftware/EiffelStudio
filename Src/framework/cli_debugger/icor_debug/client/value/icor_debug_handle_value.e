note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_HANDLE_VALUE

inherit
	ICOR_DEBUG_REFERENCE_VALUE
		redefine
			clean_on_dispose
		end

	ICOR_DEBUG_HANDLE_TYPE

feature {ICOR_EXPORTER} -- Query

	is_Handle_strong: BOOLEAN
		local
			l_type: INTEGER
		do
			set_last_call_success (cpp_get_handle_type (item, $l_type))
			Result := l_type = Handle_strong
		end

	is_Handle_weak_track_resurrection: BOOLEAN
		local
			l_type: INTEGER
		do
			set_last_call_success (cpp_get_handle_type (item, $l_type))
			Result := l_type = Handle_weak_track_resurrection
		end

feature {ICOR_EXPORTER} -- Access

	get_handle_type: INTEGER
			-- returns the type of this handle
		do
			set_last_call_success (cpp_get_handle_type (item, $Result))
		end

	api_dispose
			-- returns the type of this handle
		do
			set_last_call_success (cpp_api_dispose (item))
		end

feature -- Cleaning / Dispose

	clean_on_dispose
			-- Call this, to clean the object as if it is about to be disposed
		do
			if item_not_null and then is_Handle_strong then
				api_dispose
			end
			Precursor {ICOR_DEBUG_REFERENCE_VALUE}
		end

	dispose
			-- Free `item'.
		local
			hr: INTEGER
		do
			if item_not_null and is_Handle_strong then
				hr := cpp_api_dispose (item)
			end
--			Precursor
		end

feature {NONE} -- Implementation

	cpp_get_handle_type (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugHandleValue signature(CorDebugHandleType *): EIF_INTEGER 
				use "cli_debugger_utils.h"
			]"
		alias
			"GetHandleType"
		end

	cpp_api_dispose (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugHandleValue signature(): EIF_INTEGER 
				use "cli_debugger_utils.h"
			]"
		alias
			"Dispose"
		end

end
