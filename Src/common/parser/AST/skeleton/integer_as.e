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

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_int_arg (0);
		end

feature -- Properties

	value: INTEGER;
			-- Integer value

	is_integer: BOOLEAN is
			-- Is it an integer value ?
		do
			Result := True;
		end;

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

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			Result := True;
		end;

end -- class INTEGER_AS
