note
	description: "Represents abstraction of ICorDebug.. classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	ICOR_OBJECT

inherit
	COM_OBJECT
		export
			{ICOR_EXPORTER} item, last_call_success, default_pointer
		redefine
			make_by_pointer,
			out,
			dispose
		end

	ICOR_EXPORTER
		export
			{NONE} all
		redefine
			out
		end

	LOCALIZED_PRINTER
		export
			{NONE} all
		redefine
			out
		end

	SHARED_ICOR_OBJECTS_MANAGER
		redefine
			out
		end

feature {ICOR_EXPORTER} -- Initialisation

	make_by_pointer (an_item: POINTER)
			-- Make Current by pointer.
		do
			Precursor (an_item)
			init_icor
		end

	init_icor
			-- Initialize special field
			-- to be redefined
		do
		end

feature {ICOR_OBJECTS_MANAGER} -- Special feature for ICOR_OBJECTS_MANAGER

	update_item (p: POINTER)
		require
			p_valid: p /= Default_pointer
			item_previously_removed: item = Default_pointer
		do
			item := p
		ensure
			item_set: item = p
		end

feature -- dispose

	clean_on_dispose
			-- Call this, to clean the object as if it is about to be disposed
		do
			dispose_impl (False)
		end

feature {NONE}

	dispose_impl (on_dispose: BOOLEAN)
			-- Implementation of cleaning for the current object
			-- if on_dispose , be careful to have safe GC code
			-- and display related output
		local
			l_nb_ref: INTEGER
		do
			debug ("com_object")
				if on_dispose then
					dispose_debug_output (1, item, $Current, 0)
				else
					clean_on_dispose_debug_output (1, item, $Current, 0)
				end
			end
			if item /= Default_pointer then
				l_nb_ref := {CLI_COM}.release (item)
				item := default_pointer
			end
			debug ("com_object")
				if on_dispose then
					dispose_debug_output (2, item, $Current, l_nb_ref)
				else
					clean_on_dispose_debug_output (2, item, $Current, l_nb_ref)
				end
			end
		rescue
			debug ("com_object")
				clean_on_dispose_debug_output (3, item, $Current, 0)
			end
			item := default_pointer
			retry
		end

	dispose
			-- Free `item'.
		do
			dispose_impl (True)
		end

	clean_on_dispose_debug_output (type: INTEGER; a_ptr: POINTER; an_obj: POINTER; a_nb_ref: INTEGER)
			-- Safe display while disposing. If `type' is `1' then
			-- we are entering `dispose', else we are leaving it.
			-- `a_ptr' is the item being freed in current object `an_obj'.
		external
			"C inline use <stdio.h>"
		alias
			"[
				switch ($type) {
					case 1:
						extern char *eif_typename(int16);
						printf ("\nEntering clean_on_dispose of %s with item value 0x%" EIF_POINTER_DISPLAY "\n", eif_typename((int16)Dftype($an_obj)), (rt_uint_ptr) $a_ptr);
						break;
					case 2:
						printf ("Quitting clean_on_dispose with item value 0x%" EIF_POINTER_DISPLAY " nb_ref[%d]\n", (rt_uint_ptr) $a_ptr, $a_nb_ref);
						break;
					case 3:
						printf ("Error during clean_on_dispose with item value 0x%" EIF_POINTER_DISPLAY "\n", (rt_uint_ptr) $a_ptr);
						break;
					default:
						break;
				}
			]"
		end

feature -- Ref management

	add_ref
			-- Call to the AddRef feature
		local
			l_nb_ref: INTEGER
		do
			check item /= Default_pointer end

			debug ("COM_OBJECT")
				localized_print_error ({STRING_32} "Entering ["+ generating_type.name_32 +"].add_ref ... on " + item.out + "%N")
			end
			l_nb_ref := {CLI_COM}.add_ref (item)
			debug ("COM_OBJECT")
				localized_print_error ({STRING_32} "Quitting ["+ generating_type.name_32 +"].add_ref [" + l_nb_ref.out + "] on " + item.out + "%N")
			end
		end

	release
			-- Call to the Release feature
		local
			l_nb_ref: INTEGER
		do
			check item /= Default_pointer end
			debug ("COM_OBJECT")
				localized_print_error ({STRING_32} "Entering [" + generating_type.name_32 + "].release ... on " + item.out + "%N")
			end
			l_nb_ref := {CLI_COM}.release (item)
			debug ("COM_OBJECT")
				localized_print_error ({STRING_32} "Quitting [" + generating_type.name_32 + "].release [" + l_nb_ref.out + "] on " + item.out + "%N")
			end
			if l_nb_ref = 0 then
				item := default_pointer
			end
		end

feature -- Equality

	is_equal_as_icor_object (other: like Current): BOOLEAN
			-- Comparison of pointer
		require
			other_not_void: other /= Void
		do
			Result := item.is_equal (other.item)
		ensure
			symmetric: Result implies other.is_equal_as_icor_object (Current)
			consistent: is_equal_as_icor_object (other) implies Result
		end

feature {ICOR_EXPORTER} -- Access

	check_last_call_succeed: BOOLEAN
			-- Check last call
		do
			Result := last_call_success = 0
			debug
				if not Result then
					io.put_string ("[!] LastCallSuccess ERROR [" +last_error_code_id+ "]%N")
				end
			end
		end

	out: STRING
			-- Output value
		do
			create Result.make_from_string (generating_type.name_32.out)
			Result.append_character ('[')
			Result.append_string (item.out)
			Result.append_character (']')
		end

feature -- Access status

	item_not_null: BOOLEAN
		do
			Result := item /= Default_pointer
		end

	last_call_succeed: BOOLEAN
			-- Is last call a success ?
		do
			Result := last_call_success = 0
				or last_call_success = 1 -- S_OK or S_FALSE
				--| HRESULT .. < 0 if error ...
		end

	last_error_code: INTEGER
			-- Convert `last_call_success' to hex and keep the last word
		do
			Result := Api_error_code_formatter.error_code_to_id (last_call_success)
		end

	last_error_code_id: STRING
			-- Convert `last_call_success' to hex and keep the last word
		do
			create Result.make_from_string (last_error_code.to_hex_string)
			Result.keep_tail (4)
		end

feature {ICOR_EXPORTER} -- Implementation

	Api_error_code_formatter: ICOR_DEBUG_API_ERROR_CODE_FORMATTER
		once
			create Result
		end

	frozen cwin_close_handle (a_hdl: POINTER): INTEGER
				-- CloseHandle (HANDLE)
		external
			"[
				C signature(HANDLE): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CloseHandle"
		end

feature {NONE} -- Implementation

	sizeof_WCHAR: INTEGER
			-- Number of bytes in a value of type `WCHAR'
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"sizeof(WCHAR)"
		end

	sizeof_CORDB_ADDRESS: INTEGER
			-- Number of bytes in a value of type `CORDB_ADDRESS'
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"sizeof(CORDB_ADDRESS)"
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
