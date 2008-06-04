indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_UNKNOWN_TYPE_VALUE

inherit
	EIFNET_ABSTRACT_DEBUG_VALUE

feature

	debug_value_type_id: INTEGER is
		do
		end

	kind: INTEGER is
		do
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
		end

	expandable: BOOLEAN is
		do
		end

	type_and_value: STRING_32 is
		do
		end

	output_value: STRING_32 is
		do
		end

	dump_value: DUMP_VALUE is
		do
		end

	dynamic_class: CLASS_C is
		do
		end

end
