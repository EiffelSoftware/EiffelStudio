-- A temporary register to hold the result of an expression.

class REGISTER

inherit

	REGISTRABLE
		redefine
			get_register, free_register,
			is_temporary
		end;

	SHARED_BYTE_CONTEXT;

	SHARED_C_LEVEL;

creation

	make

feature

	regnum: INTEGER;
			-- Which register is it ?
	
	c_type: TYPE_C;
			-- C type of the register
	
	make (ctype: TYPE_C) is
			-- Create a register of C type `ctype'.
		require
			valid_type: ctype /= Void;
			non_void_type: ctype.level /= C_void;
		do
			c_type := ctype;
			get_register;
		end;
	
	get_register is
			-- Get a register for C type `c_type'
		do
			regnum := context.register_server.get_register (c_type);
			if c_type.is_pointer then
				context.set_local_index (register_name, Current);
			end;
		ensure then
			valid_register: regnum /= 0;
		end;

	free_register is
			-- Free register used by the expression
		require else
			register_exists: regnum /= 0;
		do
			context.register_server.free_register (c_type, regnum);
		end;

	grab_register is
			-- Reserve a register for immediate use.
		do
			get_register;
			free_register;
		end;

	register_name: STRING is
			-- ASCII representation of register
		do
			!! Result.make (10)
			inspect
				c_type.level
			when C_long then
				Result.append ("ti");
			when C_ref then
				Result.append ("tp");
			when C_float then
				Result.append ("tf");
			when C_char then
				Result.append ("tc");
			when C_double then
				Result.append ("td");
			when C_pointer then
				Result.append ("ta");
			end;
			Result.append(regnum.out);
		end;

	print_register is
			-- Print register.
		local
			str: STRING;
			index: INTEGER;
		do
			if c_type.is_pointer then
				print_register_by_name;
			else
				context.buffer.putstring (register_name);
			end;
		end;

	is_temporary: BOOLEAN is true;
			-- Register is a temporary one.

invariant

	not_void_type: c_type.level /= C_void;
	valid_c_type: c_type.level >= 1 and c_type.level <= C_nb_types;

end
