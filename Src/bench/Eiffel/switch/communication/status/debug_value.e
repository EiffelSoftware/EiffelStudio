indexing
	description: "Generic notion of basic type value during the execution of the application."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_VALUE [G]

inherit
	ABSTRACT_DEBUG_VALUE
	
	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make, make_attribute
	
feature {NONE} -- Initialization

	make (a_sk_type: INTEGER; v: like value) is
			-- 	Set `value' to `v'.
		require
			v_not_void: v /= Void
		do
			set_default_name
			value := v
			sk_type := a_sk_type
		ensure
			value_set: value = v
		end

	make_attribute (a_sk_type: INTEGER; attr_name: like name; a_class: like e_class; v: like value) is
			-- Set `attr_name' to `name' and `value' to `v'.
		require
			not_attr_name_void: attr_name /= Void
			v_not_void: v /= Void
		do
			name := attr_name
			if a_class /= Void then
				e_class := a_class
				is_attribute := True
			end
			value := v
			sk_type := a_sk_type			
		ensure
			value_set: value = v
		end
		
feature -- Access

	sk_type: INTEGER

	value: G
			-- Value of object.

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		local
			l_name: STRING
			system: SYSTEM_I
		once
			l_name := value.generator
			system := Eiffel_system.system
			inspect sk_type
			when sk_uint8   then Result := system.natural_8_class.compiled_class				
			when sk_uint16  then Result := system.natural_16_class.compiled_class
			when sk_uint32  then Result := system.natural_32_class.compiled_class
			when sk_uint64  then Result := system.natural_64_class.compiled_class
			when sk_int8    then Result := system.Integer_8_class.compiled_class
			when sk_int16   then Result := system.Integer_16_class.compiled_class
			when sk_int32   then Result := system.Integer_32_class.compiled_class
			when sk_int64   then Result := system.Integer_64_class.compiled_class
			when sk_bool    then Result := system.Boolean_class.compiled_class
			when sk_char    then Result := system.Character_class.compiled_class
			when sk_wchar   then Result := system.Wide_char_class.compiled_class
			when sk_real32  then Result := system.real_32_class.compiled_class
			when sk_real64  then Result := system.real_64_class.compiled_class
			when sk_pointer then Result := system.Pointer_class.compiled_class
			else
				check known_type: False	end
			end
		ensure then
			non_void_result: Result /= Void
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		local
			uint8val: INTEGER_8_REF
			uint16val: INTEGER_16_REF
			uint32val: INTEGER_REF
			uint64val: INTEGER_64_REF

			int8val: INTEGER_8_REF
			int16val: INTEGER_16_REF
			int32val: INTEGER_REF
			int64val: INTEGER_64_REF
			
			realval: REAL_REF
			dblval: DOUBLE_REF
			cval: CHARACTER_REF
			ptrval: POINTER_REF
			bval: BOOLEAN_REF
--			wcval: WIDE_CHARACTER_REF
		do
			fixme ("Use NATURAL_XX instead when compiler support them.")
			
			inspect sk_type
			when sk_uint8   then
				uint8val ?= value
				create Result.make_integer_32 (uint8val.item.to_integer, Dynamic_class)
			when sk_uint16  then
				uint16val ?= value
				create Result.make_integer_32 (uint16val.item.to_integer, Dynamic_class)
			when sk_uint32  then
				uint32val ?= value
				create Result.make_integer_32 (uint32val.item, Dynamic_class)
			when sk_uint64  then
				uint64val ?= value
				create Result.make_integer_64 (uint64val.item, Dynamic_class)
				
			when sk_int8    then
				int8val ?= value
				create Result.make_integer_32 (int8val.item.to_integer, Dynamic_class)
			when sk_int16   then
				int16val ?= value
				create Result.make_integer_32 (int16val.item.to_integer, Dynamic_class)
			when sk_int32   then
				int32val ?= value
				create Result.make_integer_32 (int32val.item, Dynamic_class)
			when sk_int64   then
				int64val ?= value
				create Result.make_integer_64 (int64val.item, Dynamic_class)
				
			when sk_bool    then
				bval ?= value
				create Result.make_boolean (bval.item, Dynamic_class)
			when sk_char    then
				cval ?= value
				create Result.make_character (cval.item, Dynamic_class)
			when sk_wchar   then
					--| FIXME XR: Why is there no conversion feature in WIDE_CHARACTER?!!!
--				wcval ?= value
				create Result.make_character ('%U', Dynamic_class)
			when sk_real32  then
				realval ?= value
				create Result.make_real (realval.item, Dynamic_class)
			when sk_real64  then
				dblval ?= value
				create Result.make_double (dblval.item, Dynamic_class)
			when sk_pointer then
				ptrval ?= value
				create Result.make_pointer (ptrval.item, Dynamic_class)
			else
				check known_type: False	end
			end
		end

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
			dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_string (value.out)
		end;
		
feature {NONE} -- Output

	append_value (st: STRUCTURED_TEXT) is 
		do 
			st.add_string (value.out)
		end;
		
	output_value: STRING is
			-- Return a string representing `Current'.
		do
			Result := value.out
		end

	type_and_value: STRING is
			-- Return a string representing `Current'.
		do
			create Result.make (40)
			Result.append (dynamic_class.name_in_upper)
			Result.append (Equal_sign_str)
			Result.append (value.out)
		end

feature -- ouput 

	is_dummy_value: BOOLEAN is False
			-- Does `Current' represent a object value or for instance an error message
			
	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := Void
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Immediate_value
		end

end -- class DEBUG_VALUE
