-- Access to an argument

class ARGUMENT_B 

inherit

	ACCESS_B
		redefine
			enlarged, type, is_argument, is_local, is_creatable,
			make_byte_code, register_name, array_descriptor,
			pre_inlined_code, print_register, generate_il_call_access
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

	enlarged: ARGUMENT_B is
			-- Enlarge current node
		local
			arg_bl: ARGUMENT_BL
		do
			!!arg_bl;
			arg_bl.fill_from (Current);
			Result := arg_bl
		end;

	register_name: STRING is
			-- The "arg<num>" string
		do
			!! Result.make (10)
			Result.append ("arg");
			Result.append (position.out);
		end;

	print_register is
			-- Print argument
		do
			buffer.putstring (register_name)
		end

feature -- IL code generation

	generate_il_call_access (is_target_of_call: BOOLEAN) is
			-- Generate IL code for an access to an argument
		do
			if is_target_of_call and then real_type (type).is_expanded then
				il_generator.generate_argument_address (position)
			else
				il_generator.generate_argument (position)
			end
		end

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

feature -- Inlining

	pre_inlined_code: INLINED_ARG_B is
		do
			!!Result;
			Result.fill_from (Current)
		end

end
