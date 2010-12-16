note
	description: "Array Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_ARRAY_TYPE_DECL

inherit
	OBJC_POINTER_TYPE_DECL
		redefine
			debug_output
		end

create
	make_with_array_info

feature {NONE} -- Initialization

	make_with_array_info (a_name: STRING; a_pointed_type: OBJC_TYPE_DECL; a_count: NATURAL)
			-- Initialize Current with `a_name', `a_pointed_type' and `a_count'
		require
			a_valid_name: not a_name.is_empty
		do
			name := a_name
			pointed_type := a_pointed_type
			count := a_count
		ensure
			name_set: name = a_name
			pointed_type_set: pointed_type = a_pointed_type
			count_set: count = a_count
		end

feature -- Access

	count: NATURAL

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			if attached pointed_type as attached_pointed_type then
				Result.append ("[" + count.out + attached_pointed_type.debug_output + "]")
			else
				check pointed_type_not_void: False end
			end
		end

end
