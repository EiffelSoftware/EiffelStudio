indexing
	description: "Object used to get information on ICOR_DEBUG_VALUE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_INFO

inherit
	REFACTORING_HELPER

	ICOR_EXPORTER

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make, make_from_prepared_value

feature {NONE} -- Initialisation

	make (a_referenced_value: ICOR_DEBUG_VALUE) is
			-- Initialize `Current' with the referenced value
			-- this referenced is the value we got directly from the dotnet debugger
			-- with no processing on it.
		require
			argument_not_void: a_referenced_value /= Void
		do
			icd_referenced_value := a_referenced_value
			icd_prepared_value := Edv_formatter.prepared_debug_value (a_referenced_value)
			init
		end

	make_from_prepared_value (a_referenced_value: ICOR_DEBUG_VALUE; a_prepared_value: ICOR_DEBUG_VALUE) is
			-- Initialize `Current' from a prepared value
			-- a prepared value is an dereferenced, and unboxed dotnet value
		require
			argument_not_void: a_referenced_value /= Void and then a_prepared_value /= Void
		do
			icd_referenced_value := a_referenced_value
			icd_prepared_value := a_prepared_value
			init
		end

feature -- Dispose

	clean is
			-- Clean Current value
			-- and make Current ready to be disposed
			-- This object should not be used anymore.
			-- For that the caller must be sure the data are not
			-- referenced elsewhere
		do
				--| IcorDebug world
			icd_referenced_value := Void
			icd_prepared_value := Void --| Nota: could be cleaned .. in certain context

				--| ICorDebugClass value
			if once_value_icd_class /= Void then
				once_value_icd_class := Void
			end
				--| ICorDebugModule value
			if once_value_icd_module /= Void then
				once_value_icd_module := Void
			end

				--| And then ...

				--|Eiffel world
			once_value_class_type := Void
			once_value_class_type_computed := False
		end

feature {NONE} -- Internal Initialisation

	init is
			-- Set the main information
		local
			l_type: INTEGER
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			if not error_occurred then
				referenced_address := icd_referenced_value.get_address
				object_address := icd_prepared_value.get_address

--				if referenced_address = 0 then
-- FIXME jfiat: 20040316 : null address for non null object : Check this
-- why sometime the referenced value has null address but is not null !!!
-- so for now let's use the icd_prepared_value when it occurs ..
-- ANSWER: If the value is at least partly in registers,
--         the address value is 0
--				end

				l_type := icd_prepared_value.get_type
				if icd_prepared_value.error_code_is_object_neutered (icd_prepared_value.last_call_success) then
					is_object := True
				end

				is_reference_type := True
				inspect l_type
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_string
				then
					is_string_type := (l_type = {MD_SIGNATURE_CONSTANTS}.element_type_string)
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_szarray,
					{MD_SIGNATURE_CONSTANTS}.element_type_array
				then
					is_array_type := True
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_class,
					{MD_SIGNATURE_CONSTANTS}.element_type_object,
					{MD_SIGNATURE_CONSTANTS}.element_type_valuetype,
					{MD_SIGNATURE_CONSTANTS}.element_type_byref
				then
					is_class := (l_type = {MD_SIGNATURE_CONSTANTS}.element_type_class)
					is_object := (l_type = {MD_SIGNATURE_CONSTANTS}.element_type_object)
					is_valuetype := (l_type =	{MD_SIGNATURE_CONSTANTS}.element_type_valuetype)
					is_byref := (l_type =	{MD_SIGNATURE_CONSTANTS}.element_type_byref)
				else
					is_reference_type := False
				end

				if is_reference_type then
-- FIXME jfiat [2004/07/06] : we already compute the IsNull property
-- so let's use it. Let's keep these lines commented
-- to keep in mind, we should handle the case where icd_prepared_value is invalid
-- in the future Void.
--					if interface_debug_reference_value /= Void then
--						is_null := interface_debug_reference_value.is_null
--					else
						is_null := icd_prepared_value.is_null_reference
--					end
				end

				if is_reference_type or else is_class or else is_valuetype or else is_object then
					l_icdov := icd_prepared_value.query_interface_icor_debug_object_value
					if icd_prepared_value.last_call_succeed then
						has_object_interface := True
						l_icdov.clean_on_dispose
					end
				end
			end
		rescue
			error_occurred := True
			retry
		end

feature -- Access

	referenced_address: INTEGER_64
			-- Address of `icd_referenced_value'

	object_address: INTEGER_64
			-- Address of `icd_prepared_value'
			-- or physical address

feature -- Queries

	address_as_hex_string: STRING is
			-- hexadecimal representation for `address'
		do
			Result := "0x" + object_address.to_integer.to_hex_string
		end

	value_to_truncated_string (a_size: INTEGER): STRING is
			-- Truncated string output for the Current value
		do
			if is_string_type then
				Result := Edv_formatter.prepared_icor_debug_value_as_truncated_string (icd_prepared_value, a_size)
			else
				check
					False -- FIXME: jfiat: should not occur, but for safety, let's keep this here for now
				end
				Result := Edv_formatter.prepared_icor_debug_value_to_truncated_string (icd_prepared_value, a_size)
			end
		end

feature -- Nature Reference

	is_null: BOOLEAN
			-- Is this object representing a NULL value ?

	has_object_interface: BOOLEAN
			-- In ICorDebugObjectValue interface supported ?

	is_array_type: BOOLEAN
			-- Is this object a ARRAY type value ?

	is_reference_type: BOOLEAN
			-- Is this object a reference type value ?

	is_basic_type: BOOLEAN
			-- Is this object a basic type value ?

	is_class: BOOLEAN
			-- Is this object a class type value ?

	is_object: BOOLEAN
			-- Is this object an object type value ?

	is_valuetype: BOOLEAN
			-- Is this object a valuetype value ?

	is_byref: BOOLEAN
			-- Is this object a byref value ?

	is_string_type: BOOLEAN
			-- Is this object a String type value ?

feature -- Queries

	value_icd_class: ICOR_DEBUG_CLASS is
			-- ICOR_DEBUG_CLASS related to this Current value
		require
			has_object_interface: has_object_interface
		local
			l_icdov: like new_interface_debug_object_value
		do
			Result := once_value_icd_class
			if Result = Void then
				l_icdov := new_interface_debug_object_value
				if l_icdov /= Void then
					Result := l_icdov.get_class
					once_value_icd_class := Result
					l_icdov.clean_on_dispose
				end
			end
		end

	value_class_type: CLASS_TYPE is
			-- CLASS_TYPE related to this Current value
		require
			has_object_interface: has_object_interface
			value_module_file_name_valid: value_module_file_name /= Void
			value_class_token_valid: value_class_token > 0
		do
			if once_value_class_type_computed then
				Result := once_value_class_type
			else
				if has_object_interface then
					Result := Il_debug_info_recorder.class_type_for_module_class_token (value_module_file_name, value_class_token)
				else
					Result := Eiffel_system.System.system_object_class.compiled_class.types.first
						--| FIXME jfiat 2004/03/29 : Any smarter way to find the real type ?
						-- even in case of external type ?
				end
				once_value_class_type := Result
				once_value_class_type_computed := True
			end
				--| NOTA: Result can be void
		end

	value_class_c: CLASS_C is
			-- CLASS_C related to this Current value
		require
			has_object_interface: has_object_interface
			value_module_file_name_valid: value_module_file_name /= Void
			value_class_token_valid: value_class_token > 0
		local
			ct: CLASS_TYPE
			an: STRING -- assembly name
			ci: CLASS_I
			cn: STRING  -- class name
		do
			ct := value_class_type
			if ct /= Void then
				Result := ct.associated_class
			else
				cn := value_class_name
				an := value_icd_module.get_assembly.get_name
				an := only_file_name_without_extension (an)
					--| FIXME jfiat 2004/04/02 : maybe having
					--| eiffel_universe.class_from_assembly_filename (...
				ci := eiffel_universe.class_from_assembly (an, cn)
				if ci = Void then
					fixme ("FIXME JFIAT: Ugly .. but for now .. far enought")
					ci := Eiffel_system.System.system_object_class
				end
				Result := ci.compiled_class
				if Result = Void then
					Result := Eiffel_system.System.system_object_class.compiled_class
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	only_file_name_without_extension (f: STRING): STRING is
			-- Return only the filename part of the absolute filename `f'
			-- Not very nice, but how could we do otherwise ?
		local
			pos: INTEGER
		do
			Result := f.twin
			pos := Result.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, Result.count)
			if pos > 0 then
				Result := Result.substring (pos + 1, Result.count)
			end
			pos := Result.last_index_of ('.', Result.count)
			if pos > 0 then
				Result := Result.substring (1, pos - 1)
			end
		end

feature -- Queries on ICOR_DEBUG_OBJECT_VALUE

	value_class_token: INTEGER is
			-- Dotnet class token for this ICorDebugObjectValue value
		require
			has_object_interface
		local
			lcl: like value_icd_class
		do
			lcl := value_icd_class
			if lcl /= Void then
				Result := lcl.get_token
			end
		end

	value_class_name: STRING is
			-- class name for this ICorDebugObjectValue value
		require
			has_object_interface
		local
			l_ct: INTEGER
		do
			l_ct := value_class_token
			if l_ct > 0 then
				if il_debug_info_recorder.has_class_info_about_module_class_token (value_module_file_name, l_ct) then
					Result := Il_debug_info_recorder.class_name_for_class_token_and_module (l_ct, value_module_file_name)
				else
					Result := value_icd_module.md_type_name (l_ct)
				end
			end
		end

	value_module_file_name: STRING is
			-- module filename for this ICorDebugObjectValue value
		require
			has_object_interface
		do
			Result := value_icd_module.get_name
		end

	value_icd_module: ICOR_DEBUG_MODULE is
			-- ICorDebugModule for this ICorDebugObjectValue value
		require
			has_object_interface
		local
			l_icd_class: like value_icd_class
		do
			Result := once_value_icd_module
			if Result = Void then
				l_icd_class := value_icd_class
				if l_icd_class /= Void then
					Result := l_icd_class.get_module
				end
				once_value_icd_module := Result
			end
		end

	value_icd_function (f_name: STRING): ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for this ICorDebugObjectValue value
			-- with external feature name `f_name'.
		require
			has_object_interface
			valid_feature_name: f_name /= Void and then not f_name.is_empty
		local
			icdm: like value_icd_module
			classtok, feattok: INTEGER
		do
			icdm := value_icd_module
			if icdm /= Void then
				classtok := value_class_token
				if classtok > 0 then
					feattok := icdm.md_member_token (classtok, f_name)
					if feattok > 0 then
						Result := icdm.get_function_from_token (feattok)
					end
				end
			end
		end

feature {NONE} -- Interface Access : Impl

	icd_strong_prepared_value_from (a_icd: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
		require
			a_icd /= Void
		local
			l_heap: ICOR_DEBUG_HEAP_VALUE
			l_strong: ICOR_DEBUG_HANDLE_VALUE
			l_ref: ICOR_DEBUG_REFERENCE_VALUE
		do
			l_heap := a_icd.query_interface_icor_debug_heap_value
			if l_heap /= Void then
				if not l_heap.is_valid or else l_heap.last_error_was_object_neutered then
						--| Get the value from the Strong reference
					if a_icd /= Void then
						l_strong := a_icd.strong_reference_value
						if l_strong /= Void then
							l_ref := l_strong.query_interface_icor_debug_reference_value
							if l_ref /= Void then
								Result := l_ref.dereference
								l_ref.clean_on_dispose
							end
						end
					end
				end
				l_heap.clean_on_dispose
			end
		end

	new_interface_debug_object_value_from (a_icd: ICOR_DEBUG_VALUE): ICOR_DEBUG_OBJECT_VALUE is
		require
			a_icd /= Void
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			Result := a_icd.query_interface_icor_debug_object_value
			if Result /= Void then
				l_icdv := icd_strong_prepared_value_from (a_icd)
				if l_icdv /= Void then
					Result := l_icdv.query_interface_icor_debug_object_value
					l_icdv.clean_on_dispose
				end
			end
		ensure
			result_not_equal_to_input: Result /= a_icd
		end

feature -- IUnknown Interfaces

	new_interface_debug_object_value: ICOR_DEBUG_OBJECT_VALUE is
			-- ICorDebugObjectValue interface
		require
			valid_object_type: is_reference_type or else is_class or else is_object or else is_valuetype
		do
			Result := new_interface_debug_object_value_from (icd_prepared_value)
		end

	interface_debug_array_value: ICOR_DEBUG_ARRAY_VALUE is
			-- ICorDebugArrayValue interface
		require
			is_array_type
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			Result := icd_prepared_value.query_interface_icor_debug_array_value
			if Result /= Void then
				l_icdv := icd_strong_prepared_value_from (icd_prepared_value)
				if l_icdv /= Void then
					Result := l_icdv.query_interface_icor_debug_array_value
					l_icdv.clean_on_dispose
				end
			end
		end

	interface_debug_string_value: ICOR_DEBUG_STRING_VALUE is
			-- ICorDebugStringValue interface
		require
			is_string_type
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			Result := icd_prepared_value.query_interface_icor_debug_string_value
			if Result /= Void then
				l_icdv := icd_strong_prepared_value_from (icd_prepared_value)
				if l_icdv /= Void then
					Result := l_icdv.query_interface_icor_debug_string_value
					l_icdv.clean_on_dispose
				end
			end
		end

feature {NONE} -- Implementation

	once_value_class_type_computed: BOOLEAN
			-- is `once_value_class_type' already computed ?
			-- in case `once_value_class_type' is Void, do not recompute it

	once_value_class_type: CLASS_TYPE
			-- Once per instance for `value_class_type'

	once_value_icd_class: ICOR_DEBUG_CLASS
			-- Once per instance for `value_icd_class'

	once_value_icd_module: ICOR_DEBUG_MODULE
			-- Once per instance for `value_icd_module'			


	error_occurred: BOOLEAN
			-- Did an error occurred ?

feature -- Restricted properties

	icd_referenced_value: ICOR_DEBUG_VALUE
			-- Object encapsulated by Current

	icd_prepared_value: ICOR_DEBUG_VALUE
			-- prepared Object encapsulated by Current

invariant

	icd_referenced_and_prepared_value_not_void : icd_referenced_value = Void implies icd_prepared_value = Void

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

end -- class EIFNET_DEBUG_VALUE_INFO
