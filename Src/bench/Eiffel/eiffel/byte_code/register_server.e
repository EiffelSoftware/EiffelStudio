-- Register server (distributes register numbers)

class REGISTER_SERVER 

inherit

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end;	-- DEBUG only
	SHARED_C_LEVEL
		export
			{NONE} all
		end

create

	make

	
feature 

	make (b: BOOLEAN) is
			-- `b' is false if creation comes from `duplicate'
		do
			if b then
				init;
			end;
		end;

	init is
			-- Initialize array
		local
			i: INTEGER;
			reg: REGISTER_MANAGER;
		do
			create registers.make (1, C_nb_types);
			from
				i := 1;
			until
				i > C_nb_types
			loop
				create reg.make
				registers.put (reg, i);
				i := i + 1;
			end;
		end;
	
	registers: ARRAY [REGISTER_MANAGER];
			-- The available registers (one entry per C type)
	
	
	set_registers (r: like registers) is
			-- Assign `r' to `registers'
		do
			registers := r;
		end;

	duplicate: like Current is
			-- Duplicate of the current instance
		local
			reg: like registers;
			i: INTEGER;
		do
			create Result.make (false);
			create reg.make (1, C_nb_types);
			Result.set_registers (reg);
			from
				i := 1;
			until
				i > C_nb_types
			loop
				reg.put (registers.item (i).duplicate, i);
				i := i + 1;
			end;
		end;
	
	clear_all is
			-- Clear current data structure
		local
			i, count: INTEGER;
		do
			from
				i := registers.lower;
				count := registers.count;
			until
				i > count
			loop
				registers.item (i).clear_all;
				i := i + 1;
			end;
		end;

	get_register (ctype: TYPE_C): INTEGER is
			-- First free register of type `ctype'
		do
			Result := registers.item (ctype.level).get_register;
debug
io.error.put_string ("get register #");
io.error.put_integer (Result);
io.error.put_string (" of type ");
io.error.put_string (ctype.generator);
io.error.put_new_line;
end;
		end;

	free_register (ctype: TYPE_C; n: INTEGER) is
			-- Free register number `n' of type `ctype'
		do
debug
io.error.put_string ("free register #");
io.error.put_integer (n);
io.error.put_string (" of type ");
io.error.put_string (ctype.generator);
io.error.put_new_line;
end;
			registers.item (ctype.level).free_register (n);
		end;

	needed_registers (ctype: TYPE_C): INTEGER is
			-- Number of needed registers for C type `ctype'
		do
			Result := registers.item (ctype.level).needed_registers;
		end;

	needed_registers_by_clevel (clevel: INTEGER): INTEGER is
			-- Number of needed registers for C type level `clevel'
		do
			Result := registers.item (clevel).needed_registers;
		end;

end
