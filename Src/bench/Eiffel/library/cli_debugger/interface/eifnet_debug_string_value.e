indexing
	description: "Dotnet debug value associated with String value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_STRING_VALUE

inherit

	ABSTRACT_REFERENCE_VALUE
		redefine
			output_value, kind, expandable
		end

	EIFNET_ABSTRACT_DEBUG_VALUE		
		undefine
			address
		redefine
			output_value, kind, expandable
		end		
		
	COMPILER_EXPORTER
		undefine
			is_equal
		end
	
create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is
			-- 	Set `value' to `v'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
--			a_frame_not_void: f /= Void
		do
			set_default_name

			init_dotnet_data (a_referenced_value, a_prepared_value, f)

			is_external_type := True
			string_value := icd_value_info.value_to_string

			is_null := (string_value = Void)
			if not is_null then
				address := icd_value_info.address_as_hex_string
			end
		ensure
			value_set: icd_value = a_prepared_value
		end

--	make_attribute (attr_name: like name; a_class: like e_class; v: like value) is
--			-- Set `attr_name' to `name' and `value' to `v'.
--		require
--			not_attr_name_void: attr_name /= Void
--			v_not_void: v /= Void
--		do
--			name := attr_name
--			if a_class /= Void then
--				e_class := a_class
--				is_attribute := True
--			end
--			value := v
--		ensure
--			value_set: value = v
--		end

feature -- Access
		
--	icd_string: ICOR_DEBUG_STRING_VALUE
			-- String value
	
	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
			Result := Eiffel_system.System.system_string_class.compiled_class
		ensure then
			non_void_result: Result /= Void
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_string_for_dotnet (Current)
		end

feature {NONE} -- Output
	
	output_value: STRING is
			-- A STRING representation of the value of `Current'.
		do
			Result := string_value
		end

	type_and_value: STRING is
			-- Return a string representing `Current'.
		do
			create Result.make (40)
			Result.append (dynamic_class.name_in_upper)
			Result.append (Equal_sign_str)
			Result.append (output_value)
		end
		
feature -- Output	

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result :=(icd_value_info.interface_debug_object_value /= Void)
		end

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := children_from_external_type
		end

--	children_from_external_type: LIST [ABSTRACT_DEBUG_VALUE] is
--			-- Children list from a Reference which is an external type
--			-- (ie: a dotnet type, not pure Eiffel)
--		require
--			is_external_type: is_external_type
--		local
--			l_object_value: ICOR_DEBUG_OBJECT_VALUE
--			l_icd_class: ICOR_DEBUG_CLASS
--			l_class_token: INTEGER			
--			l_icd_module: ICOR_DEBUG_MODULE
--			l_md_import: MD_IMPORT
--			l_tokens: ARRAYED_LIST [INTEGER]
--			l_tokens_array: ARRAY [INTEGER]
--			
--			l_tokens_count: INTEGER
--			l_enum_hdl: INTEGER
--			
--			l_att_token: INTEGER
--			l_att_icd_debug_value: ICOR_DEBUG_VALUE
--			l_att_debug_value: ABSTRACT_DEBUG_VALUE
--			l_att_name: STRING
--		do
--			l_object_value := icd_value_info.interface_debug_object_value
--			if l_object_value /= Void then
--				l_icd_class := l_object_value.get_class
--				
--				if l_icd_class /= Void then
--					l_class_token := l_icd_class.get_token
--					
--					l_icd_module := l_icd_class.get_module
--					l_md_import := l_icd_module.interface_md_import
--		
--					l_enum_hdl := 0
--					l_tokens_array := l_md_import.enum_fields ($l_enum_hdl, l_class_token, 10)
--					l_tokens_count := l_md_import.count_enum (l_enum_hdl)
--					if l_tokens_count > 0 then
--						create l_tokens.make (l_tokens_count)
--						l_tokens.fill (l_tokens_array)
--						if l_tokens_count > l_tokens_array.count then
--								-- We need to retrieve the rest of the data
--							l_tokens_array := l_md_import.enum_fields ($l_enum_hdl, l_class_token, l_tokens_count - 10)
--							l_tokens.fill (l_tokens_array)
--						end
--					end
--					
--	-- FIXME: JFIAT: 2004-01-14 : Check with User's preference limit.
--	-- FIXME: JFIAT: 2004-01-14 : do we get all inherited fields too ?
--	
--					l_md_import.close_enum (l_enum_hdl)
--					
--					if l_tokens /=  Void then
--						create {SORTED_TWO_WAY_LIST [ABSTRACT_DEBUG_VALUE]} Result.make
--						from
--							l_tokens.start
--						until
--							l_tokens.after
--						loop
--							l_att_token := l_tokens.item
--							l_att_name := l_md_import.get_field_props (l_att_token)							
--							
--							l_att_icd_debug_value := l_object_value.get_field_value (l_icd_class, l_att_token)
--							if l_att_icd_debug_value /= Void then
--								l_att_debug_value := debug_value_from_icdv (l_att_icd_debug_value)
--								if l_att_debug_value /= Void then
--									l_att_debug_value.set_name (l_att_name)
--									Result.extend (l_att_debug_value)
--								end
--							end
--							l_tokens.forth
--						end
--					end
--				end
--			end
--		end		

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := External_reference_value
		end

end -- class EIFNET_DEBUG_STRING_VALUE

