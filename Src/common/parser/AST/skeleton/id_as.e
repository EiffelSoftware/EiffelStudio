indexing

	description: "Node for id.";
	date: "$Date$";
	revision: "$Revision$"

class ID_AS

inherit

	ATOMIC_AS
		undefine
			copy, out, is_equal, setup, consistent
		redefine
			pass_address, is_id, good_integer, good_character,
			record_dependances, string_value, simple_format
		end;
	STRING
		rename
			set as string_set, is_integer as string_is_integer
		end

creation

	make

feature

-- SHOULD BE OBSOLETE
--  start_position: INTEGER;
			-- Start position of the string
--  end_position: INTEGER;
			-- Ending position of the string

	is_id: BOOLEAN is
			-- Is the current atomic node an id ?
		do
			Result := True;
		end;

	pass_address (n: INTEGER) is
			-- Eiffel-Yacc interface
		do
			c_get_address (n, $Current, $set);
			getid_create ($make);
			getid_area ($to_c);
		end;
	
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

feature -- Conveniences

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

	string_value: STRING is
		do
			!! Result.make (0);
			Result.append (Current)
		end

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (Current);
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

end
