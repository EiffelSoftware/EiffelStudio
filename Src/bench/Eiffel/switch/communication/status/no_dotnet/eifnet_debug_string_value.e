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
		do
		end

feature -- Access

	length: INTEGER is 0
		
	dynamic_class: CLASS_C is
		once
		end

	dump_value: DUMP_VALUE is
		do
		end

feature {NONE} -- Output
	
	type_and_value: STRING is
		do
		end
		
	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
		end

end

