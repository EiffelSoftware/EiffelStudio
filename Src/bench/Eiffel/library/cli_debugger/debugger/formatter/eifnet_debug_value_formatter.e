indexing
	description: "Used to prepare and format output of ICOR_DEBUG_VALUE"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_FORMATTER
	
inherit
	EIFNET_ICOR_ELEMENT_TYPES_CONSTANTS

	EIFNET_API_ERROR_CODE_FORMATTER
	
	ICOR_EXPORTER

feature -- Access

	prepared_debug_value (icd: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- strip_reference an unboxed value
		require
			arg_value_not_void: icd /= Void
		do
			Result := icd
			Result := strip_references (Result)
			Result := unbox_debug_value (Result)
		ensure
			Result_not_void: Result /= Void
		end

	icor_debug_string_value (a_data: ICOR_DEBUG_VALUE): ICOR_DEBUG_STRING_VALUE is
			-- Prepare `a_data' and return ICorDebugStringValue from `a_data'
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := prepared_debug_value (a_data)
			Result := prepared_icor_debug_value_as_icd_string_value (l_icdv)
		end

feature -- Transforming

	icor_debug_string_value_to_sub_string (a_icd_string_value: ICOR_DEBUG_STRING_VALUE; 
					min, max: INTEGER): STRING is
		do
			Result := get_sub_string_value (a_icd_string_value, min, max)			
		end

	icor_debug_string_value_to_string (a_icd_string_value: ICOR_DEBUG_STRING_VALUE): STRING is
		do
			Result := get_string_value (a_icd_string_value)
		end
		
	icor_debug_value_to_string (a_data: ICOR_DEBUG_VALUE): STRING is
		local
			l_data: ICOR_DEBUG_VALUE
		do
			l_data := prepared_debug_value (a_data)
			if last_strip_references_call_success /= 0 then
				print ("[!] Error on strip_references (dereference..) %N%T=> " + error_code_to_string (last_strip_references_call_success) + "%N")
				Result := "ERROR while Dereferencing"
			else
				Result := prepared_icor_debug_value_to_string (l_data)
			end
		end
		
	icor_debug_value_to_integer (a_data: ICOR_DEBUG_VALUE): INTEGER is
		local
			l_data: ICOR_DEBUG_VALUE
		do
			l_data := prepared_debug_value (a_data)
			Result := prepared_icor_debug_value_as_integer (l_data)
		end

feature {EIFNET_DEBUG_VALUE_FACTORY, SHARED_EIFNET_DEBUG_VALUE_FORMATTER, DEBUG_VALUE_EXPORTER} -- Dereferenced to Specialized Value

	prepared_icor_debug_value_as_icd_string_value (a_data: ICOR_DEBUG_VALUE): ICOR_DEBUG_STRING_VALUE is
		do
			Result := a_data.query_interface_icor_debug_string_value
		end

	prepared_icor_debug_value_as_string (a_data: ICOR_DEBUG_VALUE): STRING is
		local
			l_string: ICOR_DEBUG_STRING_VALUE
		do
			l_string := prepared_icor_debug_value_as_icd_string_value (a_data)
			if l_string /= Void then
				Result := get_string_value (l_string)
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

	prepared_icor_debug_value_as_integer (a_data: ICOR_DEBUG_VALUE): INTEGER is -- INTEGER_32
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
			Result := l_mp.read_real (0)
		end

	prepared_icor_debug_value_as_double (a_data: ICOR_DEBUG_VALUE): DOUBLE is
		local
			l_mp: MANAGED_POINTER
		do
			l_mp := value_data_pointer (a_data)
			Result := l_mp.read_double (0)
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
			l_data: ICOR_DEBUG_VALUE

			l_string: ICOR_DEBUG_STRING_VALUE
			l_array: ICOR_DEBUG_ARRAY_VALUE
			l_object: ICOR_DEBUG_OBJECT_VALUE
			l_reference: ICOR_DEBUG_REFERENCE_VALUE

			l_found_value: BOOLEAN
			l_result_string: STRING
		do
			l_data := a_data
			l_type := l_data.get_type

			--| Now start getting info

			l_found_value := False
			l_result_string := "TypeID ["+ l_type.out +"]::" + cor_element_type_to_string (l_type)
			l_result_string.prepend_string ("[" + l_data.item.out +"] :: ")
			
				--| At this point the argument 
				--| of this feature is already ref-stripped and out of any box.
	
	            --| Is this object a string object ? |--
			if not l_found_value then
				l_string := l_data.query_interface_icor_debug_string_value
				if l_data.last_call_succeed then
					l_result_string := get_string_value (l_string)
					l_found_value := True
				end
			end

	            --| Might be an array... |--
			if not l_found_value then
				l_array := l_data.query_interface_icor_debug_array_value
				if l_data.last_call_succeed then
					l_result_string.append_string ("<<ARRAY>>")
					l_result_string.append_string (" rank=" + l_array.get_rank.out)
					l_result_string.append_string (" count=" + l_array.get_count.out)
					l_found_value := True
				end
			end

			if not l_found_value then
					--| Check if OBJECT |--
				l_object := l_data.query_interface_icor_debug_object_value
				if l_data.last_call_succeed then
					l_result_string.append_string ("<<OBJECT>>")
--					l_result_string := "<<OBJECT>>"
					l_result_string.append_string (" class token = 0x" + l_object.get_class.get_token.to_hex_string)
					
					l_found_value := True
				else
					l_result_string.append_string ("<<OBJECT-ERROR:"+l_data.last_error_code_id+">>")
				end
			end

			if not l_found_value then
					--| Check if REFERENCE |--
					--| Should not occur since we work on dereferenced ICorDebugValue !!!
					--| Except if Null ...

				l_reference := l_data.query_interface_icor_debug_reference_value
				if l_data.last_call_succeed then
					l_result_string.append_string ("<<REFERENCE>>")
					if l_reference.is_null then
						l_result_string := " IsNull"
						l_found_value := True								
					else
--						l_mp := value_data_pointer (l_data)
--						l_found_value := True
					end
--				else
--					l_result_string.append_string ("<<?? REFERENCE-ERROR:"+l_data.last_error_code_id+">>")
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
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_end then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_sentinel then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_void then
					Result := "Void" -- FIXME
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_boolean then
					Result := prepared_icor_debug_value_as_boolean (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_char then
					Result := prepared_icor_debug_value_as_character (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
					Result := prepared_icor_debug_value_as_integer_8 (l_icd)
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_pinned then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
					Result := prepared_icor_debug_value_as_integer_16 (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_i4,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_i
				then
					Result := prepared_icor_debug_value_as_integer (l_icd)
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_u4,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_u 
				then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
					Result := prepared_icor_debug_value_as_integer_64 (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
					Result := prepared_icor_debug_value_as_real (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
					Result := prepared_icor_debug_value_as_double (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_ptr then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_byref then
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_class,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_object,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_array,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype
				then
					Result := prepared_icor_debug_value_as_reference_to_string (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_string then
					Result := prepared_icor_debug_value_as_string (l_icd)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_fnptr then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_reqd then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_opt then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_internal then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_max then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_modifier then
				else			
--					Result := "Unknown type (for now)"
				end
			else
				print ("[!] Error on ICorDebugValue->GetType() %N")
--				Result := ""
			end
		end

	prepared_icor_debug_value_to_string (a_data: ICOR_DEBUG_VALUE): STRING is
		local
			l_result: ANY
		do
			l_result := prepared_icor_debug_value (a_data)
			if l_result /= Void then
				Result := l_result.out
			else
				Result := "Void"
			end
		end
	
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
			l_real_value: MANAGED_POINTER
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
					last_strip_references_call_success := 0
					debug ("ICorDebugReferenceValue")
						print ("Not a ICorDebugReferenceValue %N")
					end
					do_break := True
				end
					--| IsNULL ?
				if not do_break then
					l_is_null := l_icor_ref.is_null
					if not l_icor_ref.last_call_succeed then
						last_strip_references_call_success := l_icor_ref.last_call_success
						debug ("ICorDebugReferenceValue")
							print ("Failed on ICorDebugReferenceValue->IsNULL ()  %N")
						end
						do_break := True
					end
				end
				if not do_break and then l_is_null then
					do_break := True
				end
					--| GetValue
				if not do_break then
					create l_real_value.make (sizeof_CORDB_ADDRESS)
					l_icor_ref.get_value (l_real_value.item)
					if not l_icor_ref.last_call_succeed then
						last_strip_references_call_success := l_icor_ref.last_call_success
						debug ("ICorDebugReferenceValue")
							print ("Failed on ICorDebugReferenceValue->GetValue (..)  %N")
						end
						do_break := True
					end
				end

					--| Derefrence the thing ...
				if not do_break then
					l_new_value := l_icor_ref.dereference_strong
					if not l_icor_ref.last_call_succeed then
							--| FIXME jfiat [2003/10/10 - 14:51] DerefrenceStrong may not be implemented on 1.2
							--| so let's use Derefrence as a patch
						debug ("ICorDebugReferenceValue")
							print ("Failed on ICorDebugReferenceValue->DereferenceStrong ()%N This may not be implemented on Whidtbey (1.2)%N")
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
						debug ("ICorDebugReferenceValue")
							print ("Failed on ICorDebugReferenceValue->Dereference () error on 0x" + l_real_value.out +"%N")
						end
						do_break := True
					else
						--| got a new real value, let's check if no dereferencing is needed anymore
						Result := l_new_value
						debug ("ICorDebugReferenceValue")
							print ("Got a sub reference !!%N")
						end
					end
				end
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
			if Result.last_call_succeed then

                --| Replace the current value with the unboxed object.
				Result := l_box.get_object
				check
					l_box.last_call_succeed
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	sizeof_CORDB_ADDRESS: INTEGER is
			-- Number of bytes in a value of type `CORDB_ADDRESS'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(CORDB_ADDRESS)"
		end

	value_data_pointer (icdvalue: ICOR_DEBUG_VALUE): MANAGED_POINTER is
		local
			l_icd_with_value: ICOR_DEBUG_VALUE_WITH_VALUE
			l_size: INTEGER
			l_mp: MANAGED_POINTER
		do
			l_icd_with_value := icdvalue.query_interface_icor_debug_generic_value
			if not icdvalue.last_call_succeed then
				l_icd_with_value := icdvalue.query_interface_icor_debug_reference_value
			end
			if l_icd_with_value /= Void and then icdvalue.last_call_succeed then
				l_size := l_icd_with_value.get_size
				if icdvalue.last_call_succeed then
					create l_mp.make (l_size)
					l_icd_with_value.get_value (l_mp.item)
					if l_icd_with_value.last_call_succeed then
						Result := l_mp
					end
				end
			end
		end

	get_string_value (icd: ICOR_DEBUG_STRING_VALUE): STRING is
		local
			l_length: INTEGER
		do
			l_length := icd.get_length
			if icd.last_call_succeed then
				Result := icd.get_string (l_length)
			end
		end
		
	get_sub_string_value (icd: ICOR_DEBUG_STRING_VALUE; min,max: INTEGER): STRING is
		local
			l_length: INTEGER
		do
			l_length := icd.get_length
			if icd.last_call_succeed then
				Result := icd.get_string (l_length)
			end
		end		

	any_or_void_to_string (a_data: ANY): STRING is
		do
			if a_data /= Void then
				Result := a_data.out
			else
				Result := "Void"
			end
		end

end

