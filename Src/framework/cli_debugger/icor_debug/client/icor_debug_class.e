note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_CLASS

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- Access

	token: NATURAL_32
			-- Class's token
		do
			--| FIXME jfiat [2008/11/12] : maybe try to cache the value ...
			Result := get_token
		end

feature {ICOR_EXPORTER} -- Access

	get_module: ICOR_DEBUG_MODULE
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_module (item, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_module (p, Current)
			end
		ensure
			success: last_call_success = 0
		end

	get_static_field_value (mdfielddef: NATURAL_32; a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_VALUE
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
			set_last_call_success (cpp_get_static_field_value (item, mdfielddef, a_frame.item, $p))
			if p /= default_pointer then
				Result := new_value (p)
			end
		end

feature {NONE} -- Access

	get_token: like token
		do
			set_last_call_success (cpp_get_token (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_module (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugClass signature(ICorDebugModule**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetModule"
		end

	cpp_get_token (obj: POINTER; a_p: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugClass signature(mdTypeDef*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetToken"
		end

	cpp_get_static_field_value (obj: POINTER; a_mdfielddef: NATURAL_32; a_p_frame: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugClass signature(mdFieldDef, ICorDebugFrame*, ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetStaticFieldValue"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ICOR_DEBUG_CLASS

