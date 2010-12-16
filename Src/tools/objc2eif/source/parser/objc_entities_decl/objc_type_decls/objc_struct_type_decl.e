note
	description: "Struct Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_STRUCT_TYPE_DECL

inherit
	OBJC_TYPE_DECL
		redefine
			debug_output
		end

create
	make_with_struct_info

feature {NONE} -- Initialization

	make_with_struct_info (a_name: STRING; a_struct_name: STRING; a_fields: ARRAYED_LIST [OBJC_TYPE_DECL])
			-- Initialize Current with `a_name', `a_struct_name' and `a_fields'.
		require
			a_valid_name: not a_name.is_empty
			a_valid_struct_name: not a_struct_name.is_empty
		do
			make (a_name)
			struct_name := a_struct_name
			fields := a_fields
		ensure
			name_set: name = a_name
			struct_name_set: struct_name = a_struct_name
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

	set_struct_name (a_struct_name: like struct_name)
			-- Set `struct_name' with `a_struct_name'.
		do
			struct_name := a_struct_name
		ensure
			struct_name_set: struct_name = a_struct_name
		end

feature -- Access

	fields: ARRAYED_LIST [OBJC_TYPE_DECL] assign set_fields
			-- An array containing the types of the fields of the struct.

	struct_name: STRING assign set_struct_name
			-- The name of the struct.

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" + struct_name + "="
			from
				fields.start
			until
				fields.after
			loop
				Result.append (fields.item.debug_output)
				fields.forth
			end
			Result.append ("}")
		end

end
