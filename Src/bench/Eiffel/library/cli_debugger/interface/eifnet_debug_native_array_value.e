indexing
	description: "Dotnet debug value associated with NativeArray value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_NATIVE_ARRAY_VALUE

inherit

	ABSTRACT_SPECIAL_VALUE

	EIFNET_ABSTRACT_DEBUG_VALUE
		undefine
			address, append_to
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is
			-- 	Set `value' to `a_prepared_value'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
		do
			set_default_name
			
			init_dotnet_data (a_referenced_value, a_prepared_value, f)

			is_null := icd_value_info.is_null
			if not is_null then
				address := icd_value_info.address_as_hex_string
			end

			array_value := icd_value_info.interface_debug_array_value
			if array_value /= Void then
				capacity := array_value.get_count
			end
--			create items.make
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

	array_value: ICOR_DEBUG_ARRAY_VALUE

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
			Result := Eiffel_system.system.native_array_class.compiled_class
		ensure then
			non_void_result: Result /= Void
		end

	string_value: STRING is
			-- If `Current' represents a string then return its value.
			-- Else return Void.
			-- but in dotnet, STRING are not represented as SPECIAL[CHARACTER]
		do
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		local
			l_str: STRING
		do
			create l_str.make (40)
			if address /= Void then
				l_str.append (dynamic_class.name_in_upper)
				l_str.append (Left_square_bracket)
				l_str.append (address)
				l_str.append (Right_square_bracket)
			else
				l_str.append (NONE_representation)
			end

			create Result.make_object (address, dynamic_class)
		end

feature -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
			st.add_string (type_and_value)
		end;

feature {ABSTRACT_DEBUG_VALUE} -- Output
		
	append_value (st: STRUCTURED_TEXT) is 
			-- Append only the value of Current to `st'.
		do 
			st.add_string (output_value)
		end;
		
feature -- Output	

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := items
			if Result = Void then
				create items.make
				fill_items (Min_slice_ref.item, Max_slice_ref.item)
				Result := items
			end
		end

	fill_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		require
			items_not_void: items /= Void
			slice_valid: a_slice_min <= a_slice_max
		local
			l_elt: ICOR_DEBUG_VALUE
			l_att_debug_value: ABSTRACT_DEBUG_VALUE
			i: INTEGER
		do			
			if capacity > 0 then
				set_sp_bounds (a_slice_min, (capacity - 1).min (a_slice_max))
				if sp_lower <= sp_upper then
					from
						i := sp_lower
					until
						i > sp_upper
					loop
						l_elt := array_value.get_element_at_position (i)
						if l_elt /= Void then
							l_att_debug_value := debug_value_from_icdv (l_elt)
							l_att_debug_value.set_name (i.out)
							items.extend (l_att_debug_value)
						end
						i := i + 1
					end
				end
			end
		end


end -- class EIFNET_DEBUG_NATIVE_ARRAY_VALUE

