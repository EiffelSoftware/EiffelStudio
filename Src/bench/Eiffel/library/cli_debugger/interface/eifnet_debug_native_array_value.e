indexing
	description: "Dotnet debug value associated with NativeArray value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_NATIVE_ARRAY_VALUE

inherit

	ABSTRACT_SPECIAL_VALUE
		redefine
			kind
		end

	EIFNET_ABSTRACT_DEBUG_VALUE
		undefine
			address, append_to, sorted_children
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value) is
			-- 	Set `value' to `a_prepared_value'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
		do
			set_default_name
			
			init_dotnet_data (a_referenced_value, a_prepared_value)

			is_null := icd_value_info.is_null
			if not is_null then
				address := icd_value_info.address_as_hex_string
			end

			get_array_value
			if array_value /= Void then
				capacity := array_value.get_count
				release_array_value
			end
			register_dotnet_data
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

feature -- get

	get_array_value is
			-- get `array_value'
		do
			array_value := icd_value_info.interface_debug_array_value
		end
		
	release_array_value is
			-- Release `array_value'
		do
			array_value.clean_on_dispose
			array_value := Void
		end		

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
				l_str.append (Left_address_delim)
				l_str.append (address)
				l_str.append (Right_address_delim)
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

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if is_static then
				Result := Static_reference_value
			else
				Result := Special_value
			end
		end
		
	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := items
			if Result = Void then
				reset_items -- the size will be set by fill_items
				get_items (Min_slice_ref.item, Max_slice_ref.item)
				Result := items
			end
		end

	get_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		require else
			slice_valid: a_slice_min <= a_slice_max
		local
			l_elt: ICOR_DEBUG_VALUE
			l_att_debug_value: ABSTRACT_DEBUG_VALUE
			i: INTEGER
			nb_items: INTEGER
		do			
			if capacity > 0 then
				set_sp_bounds (a_slice_min, (capacity - 1).min (a_slice_max))
				if sp_lower <= sp_upper then
					nb_items := sp_upper - sp_lower + 1
					if nb_items > items.capacity then
						items.resize (nb_items)
					end
					get_array_value
					from
						i := sp_lower
					until
						i > sp_upper
					loop
						l_elt := array_value.get_element_at_position (i)
						if l_elt /= Void then
							l_att_debug_value := debug_value_from_icdv (l_elt)
							l_att_debug_value.set_name (i.out)
							items.put_last (l_att_debug_value)
						end
						i := i + 1
					end
					release_array_value
				end
			end
			items_computed := True			
		end

end -- class EIFNET_DEBUG_NATIVE_ARRAY_VALUE
