note
	description: "An Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_TYPE_DECL

inherit
	OBJC_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make(a_name: STRING)
			-- Initialize Current with `a_name'.
		require
			valid_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_type_decl (Current)
		end

feature -- Setters

	set_name (a_name: like name)
			-- Set `name' with `a_name'.
		require
			a_valid_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_encoding (an_encoding: attached like encoding)
			-- Set `encoding' with `an_encoding'.
			-- Moreover, set pointed_type, struct_fields and struct_name if appropriate.
		require
			a_valid_encoding: not an_encoding.is_empty
		do
			encoding := an_encoding
		ensure
			encoding_set: encoding = an_encoding
		end

feature -- Access

	name: STRING assign set_name
			-- The name of Current.
			-- Example: "NSString *"

	encoding: detachable STRING assign set_encoding note option: stable attribute end
			-- The Objective-C type encoding of Current.
			-- Example: "@" or "{CGRect={CGPoint=dd}{CGSize=dd}}"

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "generic_type_decl"
		end

end
