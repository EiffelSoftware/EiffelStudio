indexing
	description: "Dotnet debug value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE

inherit
	ABSTRACT_DEBUG_VALUE
	
	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT}
	make
--, make_attribute
	
feature {NONE} -- Initialization

	make (v: like value) is
			-- 	Set `value' to `v'.
		require
			v_not_void: v /= Void
		do
			set_default_name
			value := v
			create value_info.make (v)
		ensure
			value_set: value = v
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
--		
feature -- Access

	value: ICOR_DEBUG_VALUE
			-- Value of object.

	value_info: EIFNET_DEBUG_VALUE_INFO

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		local
			l_name: STRING
			system: SYSTEM_I
		do
--			if value_info.is_string then
				Result := Eiffel_system.system.Any_class.compiled_class
--			elseif value_info.is_character_type then
--			end
		ensure then
			non_void_result: Result /= Void
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_manifest_string (value_info.value_to_string, dynamic_class)
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

end -- class EIFNET_DEBUG_VALUE
