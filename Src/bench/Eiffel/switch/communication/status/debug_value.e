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
	
create {RECV_VALUE, ATTR_REQUEST}
	make, make_attribute
	
feature {NONE} -- Initialization

	make (v: like value) is
			-- 	Set `value' to `v'.
		require
			v_not_void: v /= Void
		do
			set_default_name
			value := v
		ensure
			value_set: value = v
		end

	make_attribute (attr_name: like name; a_class: like e_class; v: like value) is
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
		ensure
			value_set: value = v
		end
		
feature -- Access

	value: G
			-- Value of object.

feature -- Access

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		local
			l_name: STRING
			system: SYSTEM_I
		once
			l_name := value.generator
			system := Eiffel_system.system
			if l_name.is_equal (Integer_8_name) then
				Result := system.Integer_8_class.compiled_class
			elseif l_name.is_equal (Integer_16_name) then
				Result := system.Integer_16_class.compiled_class
			elseif l_name.is_equal (Integer_32_name) then
				Result := system.Integer_32_class.compiled_class
			elseif l_name.is_equal (Integer_64_name) then
				Result := system.Integer_64_class.compiled_class
			elseif l_name.is_equal (Boolean_name) then
				Result := system.Boolean_class.compiled_class
			elseif l_name.is_equal (Character_name) then
				Result := system.Character_class.compiled_class
			elseif l_name.is_equal (Wide_char_name) then
				Result := system.Wide_char_class.compiled_class
			elseif l_name.is_equal (Double_name) then
				Result := system.Double_class.compiled_class
			elseif l_name.is_equal (Real_name) then
				Result := system.Real_class.compiled_class
			elseif l_name.is_equal (Pointer_name) then
				Result := system.Pointer_class.compiled_class
			end
		ensure then
			non_void_result: Result /= Void
		end

feature -- Output

	 append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
			dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_string (value.out)
		end;

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

	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := Void
		end

	Equal_sign_str: STRING is " = "

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Immediate_value
		end

feature {NONE} -- Class constants

	Boolean_name: STRING is "BOOLEAN"
	Character_name: STRING is "CHARACTER"
	Wide_char_name: STRING is "WIDE_CHARACTER"
	Integer_8_name: STRING is "INTEGER_8"
	Integer_16_name: STRING is "INTEGER_16"
	Integer_32_name: STRING is "INTEGER"
	Integer_64_name: STRING is "INTEGER_64"
	Double_name: STRING is "DOUBLE"
	Real_name: STRING is "REAL"
	Pointer_name: STRING is "POINTER"
	
end -- class DEBUG_VALUE
