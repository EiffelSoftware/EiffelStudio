indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_CLASS

inherit
	ICOR_OBJECT
		redefine
			init_icor
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	init_icor is
			-- 
		do
			Precursor
			token := get_token
		end		
	
feature {ICOR_EXPORTER} -- Properties

	token: INTEGER
	
feature {ICOR_EXPORTER} -- Access

	get_module: ICOR_DEBUG_MODULE is
		local
			p: POINTER
		do
			last_call_success := cpp_get_module (item, $p)
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_module (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_token: INTEGER is
		do
			last_call_success := cpp_get_token (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_static_field_value (mdfielddef: INTEGER; a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_VALUE is
			-- GetStaticFieldValue returns a value object (ICorDebugValue) 
			-- for the given static field
			-- variable. If the static field could possibly be relative to either
			-- a thread, context, or appdomain, then pFrame will help the debugger
			-- determine the proper value.
		require
			frame_not_void: a_frame /= Void
			token_valid: mdfielddef > 0
		local
			p: POINTER
		do
			last_call_success := cpp_get_static_field_value (item, mdfielddef, a_frame.item, $p)
			if p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end

feature {NONE} -- Implementation

	cpp_get_module (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugClass signature(ICorDebugModule**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetModule"
		end

	cpp_get_token (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugClass signature(mdTypeDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetToken"
		end

	cpp_get_static_field_value (obj: POINTER; a_mdfielddef: INTEGER; a_p_frame: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugClass signature(mdFieldDef, ICorDebugFrame*, ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetStaticFieldValue"
		end

end -- class ICOR_DEBUG_CLASS

