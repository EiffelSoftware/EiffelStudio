-- Access to an argument

class ARGUMENT_B 

inherit

	ACCESS_B
		redefine
			enlarged, type, is_argument, is_local, is_creatable,
			make_byte_code, register_name, array_descriptor
		end;
	
feature 

	position: INTEGER;
			-- Position of the argument.
	
	set_position (i: INTEGER) is
			-- Set `position' to `i'
		do
			position := i;
		end;

	type: TYPE_I is
			-- Argument type
		do
			Result := context.byte_code.arguments.item (position);
		end;

	is_argument: BOOLEAN is True;
			-- Is Current an access to an argument ?

	is_local: BOOLEAN is False;
			-- Is Current an access to a local variable ?

	is_creatable: BOOLEAN is False;
			-- Can an access to an argument be the taget of a creation ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			argument_b: ARGUMENT_B;
		do
			argument_b ?= other;
			if argument_b /= Void then
				Result := position = argument_b.position;
			end;
		end;

	enlarged: ARGUMENT_BL is
			-- Enlarge current node
		do
			!!Result;
			Result.fill_from (Current);
		end;

	register_name: STRING is
			-- The "arg<num>" string
		do
			Result := Buffer;
			Result.wipe_out;
			Result.append ("arg");
			Result.append (position.out);
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an access to an argument
		do
			ba.append (Bc_arg);
			ba.append_short_integer (position);
		end;

feature -- Array optimization

	array_descriptor: INTEGER is
		do
			Result := position
		end

end
