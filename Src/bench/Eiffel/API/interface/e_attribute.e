indexing

	description: 
		"Representation of an eiffel attribute.";
	date: "$Date$";
	revision: "$Revision $"

class E_ATTRIBUTE

inherit

	E_FEATURE
		redefine
			is_attribute, type
		end

create

	make

feature -- Properties

	is_attribute: BOOLEAN is True;
			-- Is current a function

	type: TYPE_A;
			-- Return type

feature -- Setting

	set_type (t: like type) is
			-- Set `type' to `t'.
		require
			valid_t: t /= Void
		do
			type := t
		ensure
			set: type = t
		end;

end -- class E_ATTRIBUTE
