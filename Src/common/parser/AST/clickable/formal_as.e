indexing

	description: 
		"AST representation of a formal generic type.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAL_AS

inherit

	TYPE
		rename
			position as text_position
		redefine
			simple_format
		end;

	CLICKABLE_AST
		redefine
			is_class
		end

feature {AST_FACTORY} -- Initialization

	initialize (p: INTEGER) is
			-- Create a new FORMAL AST node.
		do
			position := p
		ensure
			position_set: position = p
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			position := yacc_int_arg (0);
		end;

feature -- Properties

	position: INTEGER;
			-- Position of the formal parameter in the declaration
			-- array

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position
		end

feature -- Output

	dump: STRING is
		do
			!!Result.make (12);
			Result.append ("Generic #");
			Result.append_integer (position);
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (ctxt.formal_name (position))
		end;

feature {COMPILER_EXPORTER}

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

end -- class FORMAL_AS
