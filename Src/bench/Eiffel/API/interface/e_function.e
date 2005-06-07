indexing

	description: 
		"Representation of an eiffel function.";
	date: "$Date$";
	revision: "$Revision $"

class E_FUNCTION

inherit

	E_ROUTINE
		redefine
			assigner_name, is_function, type
		end

create
	
	make

feature -- Properties

	is_function: BOOLEAN is True
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
			t_not_void_type: not t.is_void
				-- VB: See exported features of DYNAMIC_CHAIN: `remove: Void'.
		do
			type := t
			assigner_name := a
		ensure
			type_set: type = t
			assigner_name_set: assigner_name = a
		end

end -- class E_FUNCTION
