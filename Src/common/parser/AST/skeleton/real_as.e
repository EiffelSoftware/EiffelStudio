indexing

	description: 
		"AST representation of a real constant.";
	date: "$Date$";
	revision: "$Revision$"

class REAL_AS

inherit

	ATOMIC_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (r: STRING) is
			-- Create a new REAL AST node with `r'
			-- containing the textual representation
			-- of the real value.
		require
			r_not_void: r /= Void
		do
			value := r
		ensure
			value_set: value = r
		end

feature {NONE} -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		end;

feature -- Properties

	value: STRING;
			-- Real value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value.is_equal (other.value)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (value);
		end;

	string_value: STRING is
		do
			Result := clone (value)
		end

end -- class REAL_AS
