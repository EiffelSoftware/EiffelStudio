indexing

	description: 
		"AST representation of BIT types.";
	date: "$Date$";
	revision: "$Revision $"

class BITS_AS

inherit

	BASIC_TYPE
		rename
			initialize as initialize_basic_type
		redefine
			set, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (v: like bits_value) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		do
			bits_value := v
		ensure
			bits_value_set: bits_value = v
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initilization
		do
			bits_value ?= yacc_arg (0);
		ensure then
			bits_value_exists: bits_value /= Void
		end;

feature -- Properties

	bits_value: INTEGER_AS;
			-- Bits value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_value, other.bits_value)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			!!Result.make (10);
			Result.append ("BIT ");
			Result.append_integer (bits_value.value);
		end;

end -- class BITS_AS
