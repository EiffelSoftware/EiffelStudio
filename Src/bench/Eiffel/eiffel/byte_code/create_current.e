-- Creation of a like Current.

class CREATE_CURRENT 

inherit

	CREATE_INFO
		redefine
			gen_type_string, make_gen_type_byte_code
		end
	SHARED_GENERATION_CONSTANTS

feature 

	analyze is
			-- Mark we need the dynamic type of current
		do
			context.mark_current_used;
			context.add_dt_current;
		end;

	generate is
			-- Generate creation type id (dynamic type) of current	
		local
			gen_file: INDENT_FILE;
		do
--            context.generate_current_dtype;
			gen_file := context.generated_file;
			gen_file.putstring ("Dftype(")
			gen_file.putstring (context.Current_register.register_name)
			gen_file.putchar (')')
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a like Current creation type.
		do
			ba.append (Bc_ccur);
		end;

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is

		do
			-- Nothing.
		end

	generated_type_id : STRING is

		do
			!!Result.make (0)
			Result.append ("Dftype(")
			Result.append (context.Current_register.register_name)
			Result.append_character (')')
		end

	gen_type_string (final_mode : BOOLEAN) : STRING is

		do
			!!Result.make (0)
			Result.append_integer (-12)
			Result.append (", Dftype(")
			Result.append (context.Current_register.register_name)
			Result.append ("), ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_short_integer (-12)
			ba.append_short_integer (0)
		end

	type_to_create : CL_TYPE_I is

		do
			-- None.
			-- If Current is generic it already
			-- carries all the info in it's header.
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.new_line;
		end


end
