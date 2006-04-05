indexing
	description: "[
		interface ICorDebugHandleValue : ICorDebugReferenceValue
		{
			/* returns the type of this handle. */
			HRESULT GetHandleType([out] CorDebugHandleType *pType);

			/** The final release of the interface will also dispose of the handle. This
			  * API provides the ability for client to early dispose the handle.  */
			HRESULT Dispose();
		};
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_HANDLE_VALUE

inherit
	ICOR_DEBUG_REFERENCE_VALUE
		redefine
			clean_on_dispose, dispose
		end
		
	ICOR_DEBUG_HANDLE_TYPE
		undefine
			out, copy
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Query

	is_Handle_strong: BOOLEAN is
		local
			l_type: INTEGER
		do
			last_call_success := cpp_get_handle_type (item, $l_type)			
			Result := l_type = Handle_strong
		end
		
	is_Handle_weak_track_resurrection: BOOLEAN is
		local
			l_type: INTEGER
		do
			last_call_success := cpp_get_handle_type (item, $l_type)			
			Result := l_type = Handle_weak_track_resurrection
		end

feature {ICOR_EXPORTER} -- Access

	get_handle_type: INTEGER is
			-- returns the type of this handle
		do
			last_call_success := cpp_get_handle_type (item, $Result)
		end		

	api_dispose is
			-- returns the type of this handle
		do
			last_call_success := cpp_api_dispose (item)
		end		

feature -- Cleaning / Dispose

	clean_on_dispose is
			-- Call this, to clean the object as if it is about to be disposed
		do
			if item_not_null and then is_Handle_strong then
				api_dispose
			end
			Precursor {ICOR_DEBUG_REFERENCE_VALUE}
		end
		
	dispose is
			-- Free `item'.
		local
			hr: INTEGER
		do
			if item_not_null and is_Handle_strong then
				hr := cpp_api_dispose (item)
			end
			Precursor
		end
		
feature {NONE} -- Implementation

	cpp_get_handle_type (obj: POINTER; a_result: TYPED_POINTER[INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugHandleValue signature(CorDebugHandleType *): EIF_INTEGER 
				use "cli_debugger_utils.h"
			]"
		alias
			"GetHandleType"
		end

	cpp_api_dispose (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugHandleValue signature(): EIF_INTEGER 
				use "cli_debugger_utils.h"
			]"
		alias
			"Dispose"
		end
		
indexing
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

end -- class ICOR_DEBUG_HANDLE_VALUE

