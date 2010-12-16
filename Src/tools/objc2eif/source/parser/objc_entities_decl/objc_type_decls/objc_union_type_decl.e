note
	description: "Union Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_UNION_TYPE_DECL

inherit
	OBJC_TYPE_DECL
		redefine
			debug_output
		end

create
	make_with_union_info

feature {NONE} -- Initialization

	make_with_union_info (a_name: STRING; a_union_name: STRING; a_fields: ARRAYED_LIST [OBJC_TYPE_DECL])
			-- Initialize Current with `a_name', `a_union_name' and `a_fields'.
		require
			a_valid_name: not a_name.is_empty
			a_valid_union_name: not a_union_name.is_empty
		do
			make (a_name)
			union_name := a_union_name
			fields := a_fields
		ensure
			name_set: name = a_name
			union_name_set: union_name = a_union_name
			fields_set: fields = a_fields
		end

feature -- Setters

	set_fields (a_fields: like fields)
			-- Set `fields' with `a_fields'.
		do
			fields := a_fields
		ensure
			fields_set: fields = a_fields
		end

	set_union_name (a_union_name: like union_name)
			-- Set `union_name' with `a_union_name'.
		do
			union_name := a_union_name
		ensure
			union_name_set: union_name = a_union_name
		end

feature -- Access

	fields: ARRAYED_LIST [OBJC_TYPE_DECL] assign set_fields
			-- An array containing the types of the fields of the struct.

	union_name: STRING assign set_union_name
			-- The name of the struct.

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "(" + union_name + "="
			from
				fields.start
			until
				fields.after
			loop
				Result.append (fields.item.debug_output)
				fields.forth
			end
			Result.append (")")
		end

end
