indexing
	description: "Dotnet debug value associated with String value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_STRING_VALUE

inherit

	ABSTRACT_REFERENCE_VALUE


	EIFNET_ABSTRACT_DEBUG_VALUE	
		undefine
			address
		end
	
create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is
			-- 	Set `value' to `v'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
		do
		ensure
			value_set: icd_value = a_prepared_value
		end

feature -- Access
		
	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
--			Result := Eiffel_system.System.system_string_class.compiled_class
		ensure then
			non_void_result: Result /= Void
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
--			create Result.make_string_for_dotnet (Current)
		end

feature {NONE} -- Output
	
--	output_value: STRING is
--			-- A STRING representation of the value of `Current'.
--		do
----			Result := string_value
--		end
--
	type_and_value: STRING is
			-- Return a string representing `Current'.
		do
--			create Result.make (40)
--			Result.append (dynamic_class.name_in_upper)
--			Result.append (Equal_sign_str)
--			Result.append (output_value)
		end
		
--feature -- Output	
--
--	expandable: BOOLEAN is False
--			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
--
	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
--			Result := Void
		end
--
--	kind: INTEGER is
--			-- Actual type of `Current'. cf possible codes underneath.
--			-- Used to display the corresponding icon.
--		do
----			Result := External_reference_value
--		end

end

