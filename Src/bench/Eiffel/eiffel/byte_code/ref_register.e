-- A temporary reference register not under GC control

class REF_REGISTER 

inherit

	REGISTER
		redefine
			get_register, free_register, print_register,
			register_name
		end;

creation

	make

	
feature 

	get_register is
			-- Get a register
		do
			context.add_non_gc_vars;
			regnum := context.non_gc_reg_vars;
		ensure then
			valid_register: regnum /= 0;
		end;

	free_register is
			-- Free register used by the expression
		do
			context.free_non_gc_vars;
		end;

	register_name: STRING is
			-- ASCII representation of register
		do
			Result := Buffer;
			Result.wipe_out;
			Result.append ("xp");
			Result.append(regnum.out);
		end;

	print_register is
			-- Print register.
		require else
			file_exists: context.generated_file /= Void;
			register_exists: regnum /= 0;
		do
			context.generated_file.putstring (register_name);
		end;

end
