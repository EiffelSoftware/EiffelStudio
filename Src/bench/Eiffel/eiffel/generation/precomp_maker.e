-- Makefile generator for precompiled C compilation

class PRECOMP_MAKER

inherit

	WBENCH_MAKER
		redefine
			generate_compilation_rule, system_name,
			remove_after_partial, generate_additional_rules
		end;
		
creation

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%
				%%T$(RM) $*.c%N%N");
		end;

	system_name: STRING is
			-- Name of executable
		do
			Result := Driver
		end;

	remove_after_partial: BOOLEAN is True;

	generate_additional_rules is
		do
			Make_file.putstring ("%Tld -r -o preobj.o ");
			generate_objects_macros;
			Make_file.new_line;
			Make_file.putstring ("%T$(RM) ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.new_line;
			Make_file.putstring ("%T$(RM) melted.eif Makefile Makefile.SH config.sh");
			Make_file.new_line;
			Make_file.putstring ("%T$(RM) -r $(SUBDIRS)");
			Make_file.new_line
		end;

end
