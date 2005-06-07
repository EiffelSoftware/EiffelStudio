indexing

	description: 
		"Representation of an eiffel attribute.";
	date: "$Date$";
	revision: "$Revision $"

class E_ATTRIBUTE

inherit

	E_FEATURE
		redefine
			assigner_name, is_attribute, type
		end

create

	make

feature -- Properties

	is_attribute: BOOLEAN is True
			-- Is current a function

	type: TYPE_A
			-- Return type

	assigner_name: STRING
			-- Name of the assigner procedure (if any)

feature -- Setting

	set_type (t: like type; a: like assigner_name) is
			-- Set `type' to `t' and `assigner_name' to `a'.
		require
			valid_t: t /= Void
		do
			type := t
			assigner_name := a
		ensure
			type_set: type = t
			assigner_name_set: assigner_name = a
		end

end -- class E_ATTRIBUTE
