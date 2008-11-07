indexing
	description: "Used to prepare and format output of ICOR_DEBUG_VALUE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_FORMATTER

inherit
	EIFNET_ICOR_ELEMENT_TYPES_CONSTANTS

	ICOR_DEBUG_API_ERROR_CODE_FORMATTER

	ICOR_EXPORTER

	REFACTORING_HELPER

feature -- Access

	prepared_debug_value (icd: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- strip_reference an unboxed value
		require
			arg_value_not_void: icd /= Void
			arg_value_item_not_null: icd.item_not_null
		do
				--| On dotnet 2.0, we are faced very often to neutered object
				--| then to minimize the issue, let's use the strong reference value
				--| whenever it is possible.
				--| We may optimize this to use the strong reference only
				--| on neutered ICorDebugValue ...

			if icd.strong_reference_value /= Void then
				Result := icd.strong_reference_value
			else
				Result := icd
			end
			Result := strip_references (Result)
				--| FIXME JFIAT 2004-07-06 : We should handle the case where last_strip_references_call_success reports
				--| an error. And Return Void
				--| for now, this is too many changes, and too big change
				--| but we should check this especially on whidbey
				--| Note: this fixme may be obsolete now since we use the strong reference value ...

			Result := unbox_debug_value (Result)

			if Result = icd then
					--| Make sure Result is not the icd object
					--| otherwise we may clean it by hasard
				Result := icd.duplicated_object
			end
		ensure
			result_not_icd: Result /= icd
			Result_not_void: Result /= Void
			Result_not_void: Result /= Void implies Result.item_not_null
		end

	icor_debug_string_value (a_data: ICOR_DEBUG_VALUE): ICOR_DEBUG_STRING_VALUE is
			-- Prepare `a_data' and return ICorDebugStringValue from `a_data'
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := prepared_debug_value (a_data)
			Result := l_icdv.query_interface_icor_debug_string_value
			if l_icdv /= a_data then
				l_icdv.clean_on_dispose
			end
		end

feature -- Transforming

--	icor_debug_string_value_to_truncated_string (a_icd_string_value: ICOR_DEBUG_STRING_VALUE;
--					a_size: INTEGER): STRING is
--		do
--			Result := get_truncated_string_value (a_icd_string_value, a_size)
--		end

--	icor_debug_string_value_to_string (a_icd_string_value: ICOR_DEBUG_STRING_VALUE): STRING is
--		do
--			Result := get_string_value (a_icd_string_value)
--		end

	icor_debug_value_as_string_to_string (a_data: ICOR_DEBUG_VALUE): STRING_32 is
			-- STRING value from `a_data' which is supposed to be a System.String value.
		local
			l_data: ICOR_DEBUG_VALUE
		do
			l_data := prepared_debug_value (a_data)
			if last_strip_references_call_success /= 0 then
				debug ("debugger_icor_data")
					io.error.put_string ("[!] Error on strip_references (dereference..) %N%T=> " + error_code_to_string (last_strip_references_call_success) + "%N")
				end
				Result := "ERROR while Dereferencing"
			else
				Result := prepared_icor_debug_value_as_string (l_data)
			end
			if l_data /= a_data then
				l_data.clean_on_dispose
			end
		end

--	icor_debug_value_to_string (a_data: ICOR_DEBUG_VALUE): STRING is
--		local
--			l_data: ICOR_DEBUG_VALUE
--		do
--			l_data := prepared_debug_value (a_data)
--			if last_strip_references_call_success /= 0 then
--				debug ("debugger_icor_data")
--					io.error.put_string ("[!] Error on strip_references (dereference..) %N%T=> " + error_code_to_string (last_strip_references_call_success) + "%N")
--				end
--				Result := "ERROR while Dereferencing"
--			else
--				Result := prepared_icor_debug_value_to_string (l_data)
--			end
--			if l_data /= a_data then
--				l_data.clean_on_dispose
--			end
--		end

	icor_debug_value_to_integer (a_data: ICOR_DEBUG_VALUE): INTEGER is
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := prepared_debug_value (a_data)
			Result := prepared_icor_debug_value_as_integer_32 (l_icdv)
			if l_icdv /= a_data then
				l_icdv.clean_on_dispose
			end
		end

	icor_debug_value_to_boolean (a_data: ICOR_DEBUG_VALUE): BOOLEAN is
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := prepared_debug_value (a_data)
			Result := prepared_icor_debug_value_as_boolean (l_icdv)
			if l_icdv /= a_data then
				l_icdv.clean_on_dispose
			end
		end

feature {EIFNET_DEBUG_VALUE_FACTORY, SHARED_EIFNET_DEBUG_VALUE_FORMATTER, DEBUG_VALUE_EXPORTER} -- Dereferenced to Specialized Value

	prepared_icor_debug_value_is_null (a_data: ICOR_DEBUG_VALUE): BOOLEAN is
		do
			Result := a_data.is_null_reference
		end

	prepared_icor_debug_value_as_truncated_string (a_data: ICOR_DEBUG_VALUE; a_size: INTEGER): STRING_32 is
		local
			l_string: ICOR_DEBUG_STRING_VALUE
		do
			l_string := a_data.query_interface_icor_debug_string_value
			if l_string /= Void then
				Result := get_truncated_string_value (l_string, a_size)
				l_string.clean_on_dispose
			end
		end

	prepared_icor_debug_value_as_string (a_data: ICOR_DEBUG_VALUE): STRING_32 is
		local
			l_string: ICOR_DEBUG_STRING_VALUE
		do
			l_string := a_data.query_interface_icor_debug_string_value
			if l_string /= Void then
				Result := get_string_value (l_string)
				l_string.clean_on_dispose
			end
		end

	prepared_icor_debug_value_as_boolean (a_data: ICOR_DEBUG_VALUE): BOOLEAN is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_boolean (0)
		end

	prepared_icor_debug_value_as_character (a_data: ICOR_DEBUG_VALUE): CHARACTER is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_character (0)
		end

	prepared_icor_debug_value_as_natural_8 (a_data: ICOR_DEBUG_VALUE): NATURAL_8 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_natural_8 (0)
		end

	prepared_icor_debug_value_as_natural_16 (a_data: ICOR_DEBUG_VALUE): NATURAL_16 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_natural_16 (0)
		end

	prepared_icor_debug_value_as_natural_32 (a_data: ICOR_DEBUG_VALUE): NATURAL_32 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_natural_32 (0)
		end

	prepared_icor_debug_value_as_natural_64 (a_data: ICOR_DEBUG_VALUE): NATURAL_64 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_natural_64 (0)
		end

	prepared_icor_debug_value_as_integer_8 (a_data: ICOR_DEBUG_VALUE): INTEGER_8 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_integer_8 (0)
		end

	prepared_icor_debug_value_as_integer_16 (a_data: ICOR_DEBUG_VALUE): INTEGER_16 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_integer_16 (0)
		end

	prepared_icor_debug_value_as_integer_32 (a_data: ICOR_DEBUG_VALUE): INTEGER is -- INTEGER_32
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_integer_32 (0)
		end

	prepared_icor_debug_value_as_integer_64 (a_data: ICOR_DEBUG_VALUE): INTEGER_64 is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_integer_64 (0)
		end

	prepared_icor_debug_value_as_real (a_data: ICOR_DEBUG_VALUE): REAL is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_real_32 (0)
		end

	prepared_icor_debug_value_as_double (a_data: ICOR_DEBUG_VALUE): DOUBLE is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_real_64 (0)
		end

	prepared_icor_debug_value_as_pointer (a_data: ICOR_DEBUG_VALUE): POINTER is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_pointer (0)
		end

	prepared_icor_debug_value_as_reference_to_string (a_data: ICOR_DEBUG_VALUE): STRING is
		local
			l_type: INTEGER

			l_string: ICOR_DEBUG_STRING_VALUE
			l_array: ICOR_DEBUG_ARRAY_VALUE
			l_object: ICOR_DEBUG_OBJECT_VALUE
			l_reference: ICOR_DEBUG_REFERENCE_VALUE

			l_found_value: BOOLEAN
			l_result_string: STRING
			l_icd_class: ICOR_DEBUG_CLASS
		do
			l_type := a_data.get_type

			--| Now start getting info

			l_found_value := False
			l_result_string := "TypeID ["+ l_type.out +"]::" + cor_element_type_to_string (l_type)
			l_result_string.prepend_string ("[" + a_data.item.out +"] :: ")

				--| At this point the argument
				--| of this feature is already ref-stripped and out of any box.

	            --| Is this object a string object ? |--
			if not l_found_value then
				l_string := a_data.query_interface_icor_debug_string_value
				if a_data.last_call_succeed then
					l_result_string := get_string_value (l_string)
					l_found_value := True
					l_string.clean_on_dispose
					l_string := Void
				end
			end

	            --| Might be an array... |--
			if not l_found_value then
				l_array := a_data.query_interface_icor_debug_array_value
				if a_data.last_call_succeed then
					l_result_string.append_string ("<<ARRAY>>")
					l_result_string.append_string (" rank=" + l_array.get_rank.out)
					l_result_string.append_string (" count=" + l_array.get_count.out)
					l_found_value := True
					l_array.clean_on_dispose
					l_array := Void
				end
			end

			if not l_found_value then
					--| Check if OBJECT |--
				l_object := a_data.query_interface_icor_debug_object_value
				if a_data.last_call_succeed then
					l_result_string.append_string ("<<OBJECT>>")
					l_icd_class := l_object.get_class
					if l_icd_class /= Void then
						l_result_string.append_string (" class token = 0x" + l_icd_class.get_token.to_hex_string)
					else
						l_result_string.append_string (" neutred (no class info) ")
					end

					l_found_value := True
					l_object.clean_on_dispose
					l_object := Void
				else
					l_result_string.append_string ("<<OBJECT-ERROR:" + a_data.last_error_code_id + ">>")
				end
			end

			if not l_found_value then
					--| Check if REFERENCE |--
					--| Should not occur since we work on dereferenced ICorDebugValue !!!
					--| Except if Null ...

				l_reference := a_data.query_interface_icor_debug_reference_value
				if a_data.last_call_succeed then
					l_result_string.append_string ("<<REFERENCE>>")
					if l_reference.is_null then
						l_result_string := " IsNull"
						l_found_value := True
						l_reference.clean_on_dispose
						l_reference := Void
					end
				end
			end

				--| Looks like we've got a bad object here... |--
			if not l_found_value then
				l_result_string.append_string ("<<VALUE-ERROR::Unknown>>")
				check
					l_found_value
				end
			end
			Result:= l_result_string
		end

feature -- Dereferenced to Value

	prepared_icor_debug_value (a_data: ICOR_DEBUG_VALUE): ANY is
		local
			l_icd: ICOR_DEBUG_VALUE
			l_type: INTEGER
		do
			l_icd := a_data
			l_type := l_icd.get_type
			if l_icd.last_call_succeed then
				inspect l_type
				when {MD_SIGNATURE_CONSTANTS}.element_type_end then
				when {MD_SIGNATURE_CONSTANTS}.element_type_void then
					Result := "Void" -- FIXME
				when {MD_SIGNATURE_CONSTANTS}.element_type_boolean then
					Result := prepared_icor_debug_value_as_boolean (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_char then
					Result := prepared_icor_debug_value_as_character (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_i then
				when {MD_SIGNATURE_CONSTANTS}.element_type_u then
					Result := prepared_icor_debug_value_as_pointer (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
					Result := prepared_icor_debug_value_as_integer_8 (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
					Result := prepared_icor_debug_value_as_natural_8 (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
					Result := prepared_icor_debug_value_as_integer_16 (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
					Result := prepared_icor_debug_value_as_natural_16 (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then
					Result := prepared_icor_debug_value_as_integer_32 (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then
					Result := prepared_icor_debug_value_as_natural_32 (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
					Result := prepared_icor_debug_value_as_integer_64 (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
					Result := prepared_icor_debug_value_as_natural_64 (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
					Result := prepared_icor_debug_value_as_real (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
					Result := prepared_icor_debug_value_as_double (l_icd)

				when {MD_SIGNATURE_CONSTANTS}.element_type_ptr then
				when {MD_SIGNATURE_CONSTANTS}.element_type_byref then
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_class,
					{MD_SIGNATURE_CONSTANTS}.element_type_object,
					{MD_SIGNATURE_CONSTANTS}.element_type_szarray,
					{MD_SIGNATURE_CONSTANTS}.element_type_array,
					{MD_SIGNATURE_CONSTANTS}.element_type_valuetype
				then
					Result := prepared_icor_debug_value_as_reference_to_string (l_icd)
				when {MD_SIGNATURE_CONSTANTS}.element_type_string then
					Result := prepared_icor_debug_value_as_string (l_icd)
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_fnptr then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_reqd then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_opt then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_internal then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_max then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_modifier then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_sentinel then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_pinned then
				else
				end
			else
				debug ("debugger_icor_data")
					io.error.put_string ("[!] Error on ICorDebugValue->GetType() %N")
				end
			end
		end

	prepared_icor_debug_value_to_truncated_string (a_data: ICOR_DEBUG_VALUE; a_size: INTEGER): STRING is
		local
			l_result: ANY
		do
			l_result := prepared_icor_debug_value (a_data)
			if l_result /= Void then
				Result := l_result.out
				if a_size /= - 1 then
					Result.keep_head (a_size)
				end
			else
				Result := "Void"
			end
		end

--	prepared_icor_debug_value_to_string (a_data: ICOR_DEBUG_VALUE): STRING is
--		local
--			l_result: ANY
--		do
--			l_result := prepared_icor_debug_value (a_data)
--			if l_result /= Void then
--				Result := l_result.out
--			else
--				Result := "Void"
--			end
--		end

feature -- internal Status

	last_strip_references_call_success: INTEGER

	last_strip_references_call_succeed: BOOLEAN is
			-- does last call to strip_references succeed ?
		do
			Result := (last_strip_references_call_success = 0)
		end

feature {NONE} -- preparing

	strip_references (a_data: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- Debug Value stripped from Reference.
		local
			l_icor_ref: ICOR_DEBUG_REFERENCE_VALUE
			l_new_value: ICOR_DEBUG_VALUE
			do_break: BOOLEAN
			l_is_null: BOOLEAN
			l_real_cordbg_value_mp: MANAGED_POINTER
		do
			last_strip_references_call_success := 0
			from
				do_break := False
				Result := a_data
			until
				do_break
			loop
				l_icor_ref := Result.query_interface_icor_debug_reference_value
				if not Result.last_call_succeed then
					last_strip_references_call_success := 0 --| return S_OK
					debug ("debugger_icor_data")
						io.error.put_string ("Not a ICorDebugReferenceValue %N")
					end
					if l_icor_ref /= Void then
						l_icor_ref.clean_on_dispose
					end
					do_break := True
				else --| IsNULL ?
					check
						l_icor_ref /= Void
					end
					l_is_null := l_icor_ref.is_null
					if not l_icor_ref.last_call_succeed then
						last_strip_references_call_success := l_icor_ref.last_call_success
						debug ("debugger_icor_data")
							io.error.put_string ("Failed on ICorDebugReferenceValue->IsNULL ()  %N")
						end
						l_icor_ref.clean_on_dispose
						do_break := True
					end
				end
				if not do_break and then l_is_null then
					l_icor_ref.clean_on_dispose
					do_break := True
				end
					--| GetValue
				if not do_break then
					create l_real_cordbg_value_mp.make (sizeof_CORDB_ADDRESS)
					l_icor_ref.get_value (l_real_cordbg_value_mp.item)
					if not l_icor_ref.last_call_succeed then
						last_strip_references_call_success := l_icor_ref.last_call_success
						debug ("debugger_icor_data")
							io.error.put_string ("Failed on ICorDebugReferenceValue->GetValue (..)  %N")
						end
						l_icor_ref.clean_on_dispose
						do_break := True
					end
				end

					--| Derefrence the thing ...
				if not do_break then
					l_new_value := l_icor_ref.dereference_strong
					if not l_icor_ref.last_call_succeed then
							--| FIXME jfiat [2003/10/10 - 14:51] DerefrenceStrong may not be implemented on 1.2
							--| so let's use Derefrence as a patch
						debug ("debugger_icor_data")
							io.error.put_string ("Failed on ICorDebugReferenceValue->DereferenceStrong ()%N This may not be implemented on Whidbey (>1.1)%N")
						end
						l_new_value := l_icor_ref.dereference
					end

					if not l_icor_ref.last_call_succeed then
							--| we could have more information here
							--	  CORDBG_E_BAD_REFERENCE_VALUE
							--		-> "<invalid reference: 0x%p>", realObjectPtr
							--	  CORDBG_E_CLASS_NOT_LOADED
							--		-> "(0x%p) Note: CLR error -- referenced class not loaded.", realObjectPtr
							--	  CORDBG_S_VALUE_POINTS_TO_VOID
							--		-> "0x%p", realObjectPtr
						last_strip_references_call_success := l_icor_ref.last_call_success
						debug ("debugger_icor_data")
							io.error.put_string ("Failed on ICorDebugReferenceValue->Dereference () error on 0x"
													+ l_real_cordbg_value_mp.out +"%N")
						end
						l_icor_ref.clean_on_dispose

							-- FIXME JFIAT 2004-07-06: we set this as Void for now
							-- maybe one day we should handle this a better way
							-- this case occurs mainly when we have unused local variables
							-- In future we should return Void Result
							-- and handle this with error message.
						l_is_null := True
						do_break := True
					else
						--| got a new real value, let's check if no dereferencing is needed anymore
						l_icor_ref.clean_on_dispose
						Result := l_new_value
						l_new_value := Void
						debug ("debugger_icor_data")
							io.error.put_string ("Got a sub reference !!%N")
						end
					end
				end
					-- We keep trace of the is_null information
				Result.set_is_null_reference (l_is_null)
			end
		end

	unbox_debug_value (icd: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- Take out the value from the box, it it is boxed object
		require
			arg_value_not_void: icd /= Void
		local
			l_box: ICOR_DEBUG_BOX_VALUE
		do
			Result := icd

	            --| If we have a boxed object then unbox the little fella... |--
			l_box := Result.query_interface_icor_debug_box_value
			if Result.last_call_succeed and l_box /= Void then
                --| Replace the current value with the unboxed object.
				Result := l_box.get_object
				check
					l_box.last_call_succeed
				end
				l_box.clean_on_dispose
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	sizeof_CORDB_ADDRESS: INTEGER is
			-- Number of bytes in a value of type `CORDB_ADDRESS'
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"sizeof(CORDB_ADDRESS)"
		end

	value_data_pointer (a_icdvalue: ICOR_DEBUG_VALUE): MANAGED_POINTER is
		local
			l_icd_with_value: ICOR_DEBUG_VALUE_WITH_VALUE
			l_size: NATURAL_32
			l_mp: MANAGED_POINTER
		do
			l_icd_with_value := a_icdvalue.query_interface_icor_debug_generic_value
			if l_icd_with_value = Void then
				l_icd_with_value := a_icdvalue.query_interface_icor_debug_reference_value
			end
			if l_icd_with_value /= Void and then a_icdvalue.last_call_succeed then
				l_size := l_icd_with_value.get_size
				if l_icd_with_value.last_call_succeed then
					create l_mp.make (l_size.to_integer_32) --| FIXME: truncated from NATURAL_32 to INTEGER
					l_icd_with_value.get_value (l_mp.item)
					if l_icd_with_value.last_call_succeed then
						Result := l_mp
					end
				end
				l_icd_with_value.clean_on_dispose
			end
		end

	get_string_value (icd: ICOR_DEBUG_STRING_VALUE): STRING_32 is
		local
			l_length: NATURAL_32
		do
			l_length := icd.get_length
			if icd.last_call_succeed then
				Result := icd.get_string (l_length)
			end
		end

	get_truncated_string_value (icd: ICOR_DEBUG_STRING_VALUE; a_size: INTEGER): STRING_32 is
		require
			a_size = -1 or a_size > 0
		local
			l_length: NATURAL_32
		do
			l_length := icd.get_length
			if icd.last_call_succeed then
				if a_size /= -1 then
					l_length := a_size.as_natural_32.min (l_length)
				end
				Result := icd.get_string (l_length)
			end
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

end

