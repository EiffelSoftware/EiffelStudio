indexing

	description: 
		"Representation of an eiffel function.";
	date: "$Date$";
	revision: "$Revision $"

class E_FUNCTION

inherit

	E_ROUTINE
		redefine
			is_function, type
		end

creation
	
	make

feature -- Properties

	is_function: BOOLEAN is True;
			-- Is current a function

	type: TYPE_A;
			-- Return type

feature -- Setting

	set_type (t: like type) is
			-- Set `type' to `t'.
		require
			valid_t: t /= Void
			t_not_void_type: not t.is_void
				-- VB: See exported features of DYNAMIC_CHAIN: `remove: Void'.
		do
			type := t
		ensure
			set: type = t
		end;

end -- class E_FUNCTION
