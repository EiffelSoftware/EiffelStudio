indexing
	description: "Dotnet debug value associated with String value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_STRING_VALUE

inherit
--	ABSTRACT_DEBUG_VALUE
--		redefine
--			address
--		end
	ABSTRACT_REFERENCE_VALUE
		redefine
			output_value, kind, expandable
		end		
		
	COMPILER_EXPORTER
		undefine
			is_equal
		end

	ICOR_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end		

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end				

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			is_equal
		end		
	
create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Initialization

	make (a_prepared_value: like value; f: like icd_frame) is
			-- 	Set `value' to `v'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
			a_frame_not_void: f /= Void
		do
			set_default_name
			value := a_prepared_value
			icd_frame := f

			create value_info.make (value)
			is_external_type := True
			string_value := value_info.value_to_string

			is_null := (string_value = Void)
			if not is_null then
				address := value_info.address_as_hex_string
			end
		ensure
			value_set: value = a_prepared_value
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

	icd_frame: ICOR_DEBUG_FRAME

	value: ICOR_DEBUG_VALUE
			-- Value of object.
			
	icd_string: ICOR_DEBUG_STRING_VALUE
			-- String value

	value_info: EIFNET_DEBUG_VALUE_INFO
			-- Value info of object.
	
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
			create Result.make_string_for_dotnet (
					icd_frame, 
					value, 
					icd_string, 
					address, 
					string_value, 
					dynamic_class, 
					is_null
				)
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

	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := Void
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := External_reference_value
		end

end -- class EIFNET_DEBUG_STRING_VALUE

