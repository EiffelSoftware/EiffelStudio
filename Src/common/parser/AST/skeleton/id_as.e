indexing

	description: 
		"AST representation of id.";
	date: "$Date$";
	revision: "$Revision$"

class ID_AS

inherit

	ATOMIC_AS
		undefine
			copy, out, is_equal, setup, consistent
		redefine
			pass_address, is_id, good_integer, good_character,
			record_dependances, is_equivalent
		end;
	STRING
		rename
			set as string_set, is_integer as string_is_integer
		end

creation

	make

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		local
			s: STRING;
		do
			s ?= yacc_arg (0);
			append (s);
		ensure then
			not_empty: not empty;
		end;

feature -- Properties

	is_id: BOOLEAN is
			-- Is the current atomic node an id ?
		do
			Result := True;
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_equal (other)
		end

feature {COMPILER_EXPORTER, FEAT_NAME_ID_AS} -- Conveniences

	record_dependances is
		do
		end;

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
		end;

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		do
		end;

	load (s: STRING) is
		do
			wipe_out;
			append (s);
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (Current);
		end;

	string_value: STRING is
		do
			!! Result.make (0);
			Result.append (Current)
		end

feature {COMPILER_EXPORTER}

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc interface
		do
			c_get_address (n, $Current, $set);
			getid_create ($make);
			getid_area ($to_c);
		end;

feature {NONE}

	getid_create (ptr: POINTER) is
		external
			"C"
		end;

	getid_area (ptr: POINTER) is
		external
			"C"
		end;

end -- class ID_AS
