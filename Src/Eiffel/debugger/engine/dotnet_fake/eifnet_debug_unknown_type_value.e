note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_UNKNOWN_TYPE_VALUE

inherit
	EIFNET_ABSTRACT_DEBUG_VALUE

feature

	debug_value_type_id: INTEGER
		do
		end

	kind: INTEGER
		do
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE]
		do
		end

	expandable: BOOLEAN
		do
		end

	type_and_value: STRING_32
		do
		end

	output_value: STRING_32
		do
		end

	dump_value: DUMP_VALUE
		do
		end

	dynamic_class: CLASS_C
		do
		end

end
