indexing

	description: 
		"AST representation of an integer constant.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_AS

inherit

	ATOMIC_AS
		redefine
			is_integer, good_integer, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (i: INTEGER) is
			-- Create a new INTEGER AST node.
		do
			value := i
		ensure
			value_set: value = i
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_int_arg (0);
		end

feature -- Properties

	value: INTEGER;
			-- Integer value

	is_integer: BOOLEAN is True
			-- Is it an integer value ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Output

	string_value: STRING is
		do
			Result := value.out
		end	

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (value.out);
		end;
	
feature {COMPILER_EXPORTER}

	good_integer: BOOLEAN is True
			-- Is the atomic a good integer bound for multi-branch ?

end -- class INTEGER_AS
