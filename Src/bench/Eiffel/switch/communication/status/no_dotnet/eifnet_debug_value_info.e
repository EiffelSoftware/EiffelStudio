indexing
	description: "Object used to get information on ICOR_DEBUG_VALUE"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_INFO

create
	make, make_from_prepared_value
	
feature {NONE} -- Initialisation

	make (a_referenced_value: ICOR_DEBUG_VALUE) is
		do
		end

	make_from_prepared_value (a_referenced_value: ICOR_DEBUG_VALUE; a_prepared_value: ICOR_DEBUG_VALUE) is
		do
		end
		
feature -- Queries on ICOR_DEBUG_OBJECT_VALUE

	value_class_name: STRING is
		do
		end		

feature -- Interface Access

	has_object_interface: BOOLEAN is False

	new_interface_debug_object_value: ICOR_DEBUG_OBJECT_VALUE is
		do
		end

	interface_debug_string_value: ICOR_DEBUG_STRING_VALUE is
		do
		end

end -- class EIFNET_DEBUG_VALUE_INFO
