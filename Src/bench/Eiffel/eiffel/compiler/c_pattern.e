-- C Pattern of a feature: it is constitued of the meta types of the
-- arguments and result.

class C_PATTERN 

inherit

	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	HASHABLE
		redefine
			is_equal
		end;
	SHARED_CODE_FILES
		redefine
			is_equal
		end;

creation

	make

feature 

	result_type: TYPE_C;
			-- Meta type of the result

	argument_types: ARRAY [TYPE_C];
			-- Meta types of the arguments

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a;
		end;

	make (t: TYPE_C) is
			-- Creation of a pattern with a result meta type
		require
			good_argument: t /= Void;
		do
			result_type := t;
		end;

	argument_count: INTEGER is
			-- Number of arguments
		do
			if argument_types /= Void then
				Result := argument_types.count;
			end;
		end;

	is_equal (other: C_PATTERN): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			n, i: INTEGER;
		do
			n := argument_count;
			Result :=  n = other.argument_count and then
					equivalent_type (result_type, other.result_type)
			from
				i := 1;
			until
				i > n or else not Result
			loop
				Result := equivalent_type (argument_types.item (i), (other.argument_types.item (i)));
				i := i + 1;
			end;
		end;

	hash_code: INTEGER is
			-- Hash code for pattern
		local
			i, n: INTEGER
		do
			Result := result_type.hash_code
			n := argument_count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					Result := Result + (argument_types.item (i).hash_code |<< (i \\ 16))
					i := i + 1
				end
				Result := Result.abs
			end
		end

feature -- Pattern generation

	nb_hooks: INTEGER is
			-- Number of garbage collector hooks needed
		local
			i, nb: INTEGER;
		do
			from
				Result := 1;
				i := 1;
				nb := argument_count;
			until
				i > nb
			loop
				if argument_types.item (i).is_pointer then
					Result := Result + 1;
				end;
				i := i + 1;
			end;
			if result_type.is_pointer then
				Result := Result + 1;
			end;
		end;

	argument_hook_index (j: INTEGER): INTEGER is
			-- Hook index for i-th argument
		require
			index_small_enough: j <= argument_count;
			index_large_enough: j >= 1;
			consistency: argument_types.item (j).is_pointer;
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > j
			loop
				if argument_types.item (i).is_pointer then
					Result := Result + 1;
				end;
				i := i + 1
			end;
		ensure
			Result > 0
		end;

	argument_name_array: ARRAY [STRING] is
			-- Argument names for code generation
		local
			i, nb: INTEGER;
			temp: STRING
		do
			!! Result.make (1, argument_count + 1)
			Result.put ("Current", 1)
			from
				i := 1;
				nb := argument_count
			until
				i > nb
			loop
				temp := "arg"
				temp.append_integer (i)
				Result.put (temp, i+1)
				i := i + 1;
			end;
		end;

	argument_type_array (include_current: BOOLEAN): ARRAY [STRING] is
			-- Argument types for code generation
		local
			i, j, nb: INTEGER
		do
			nb := argument_count
			if include_current then
				!! Result.make (1, nb + 1)
				Result.put ("EIF_REFERENCE", 1)
				j := 2
			else
				!! Result.make (1, nb)
				j := 1
			end
			from
				i := 1;
			until
				i > nb
			loop
				Result.put (argument_types.item (i).c_string, j)
				i := i + 1;
				j := j + 1;
			end;
		end

	generate_argument_declaration (nbtab: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generate argument declarations
		local
			i, j, nb: INTEGER;
		do
			from
				i := 1;
				nb := argument_count
			until
				i > nb
			loop
				from
					j := 1
				until
					j > nbtab
				loop
					buffer.putchar ('%T');
					j := j + 1;
				end;
				argument_types.item (i).generate (buffer);
				buffer.putstring ("arg");
				buffer.putint (i);
				buffer.putchar (';');
				buffer.new_line;
				i := i + 1;
			end;
		end;

	generate_pattern (id: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generate pattern
		do
				-- Generate pattern from C code to interpreter
			generate_toi_compound (id, buffer)

				-- Compound pattern from interpreter to C code
			generate_toc_compound (id, buffer)
		end

	generate_separate_pattern (id: INTEGER; buffer: GENERATION_BUFFER) is
		local
			f_name: STRING
		do
			f_name := "sepcall";
			f_name.append_integer (id);

			buffer.generate_function_signature ("void", f_name, False, buffer,
					<<"ptr", "is_extern">>,
					<<"fnptr", "int">>);

			buffer.putstring ("%
				%%TEIF_REFERENCE Current;%N%
				%%TEIF_INTEGER ack = _concur_command_ack;%N");
			if not result_type.is_void then
				buffer.putchar ('%T');
				result_type.generate (buffer);
				buffer.putstring ("result;%N");
			end;
			generate_argument_declaration (1, buffer);
			generate_separate_get (buffer);
			buffer.putstring ("%Tif (is_extern)%N%T%T");
			generate_routine_call (True, buffer);
			buffer.putstring ("%Telse%N%T%T");
			generate_routine_call (False, buffer);
			if result_type.is_void then
				buffer.putstring ("%TCURSPA(_concur_current_client->sock, ack);%N")
			else
				buffer.putstring ("%T");
				buffer.putstring (result_type.separate_send_macro);
				buffer.putstring ("(result);%N");
			end;
			buffer.putstring ("}%N%N"); -- ss MT
		end;

	generate_toc_compound (id: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generate compound pattern from interpreter to C code
		local
			f_name: STRING
		do
			f_name := "toc";
			f_name.append_integer (id);

			buffer.generate_function_signature ("void", f_name, False, buffer,
					<<"ptr", "is_extern">>,
					toc_arg_types);
			buffer.putstring ("%
				%%TEIF_REFERENCE Current;%N");
			if not result_type.is_void then
				buffer.putchar ('%T');
				result_type.generate (buffer);
				buffer.putstring ("result;%N%Tstruct item *it;%N");
			end;
			generate_argument_declaration (1, buffer);
			generate_toc_pop (buffer);
			buffer.putstring ("%Tif (is_extern)%N%T%T");
			generate_routine_call (True, buffer);
			buffer.putstring ("%Telse%N%T%T");
			generate_routine_call (False, buffer);
			if not result_type.is_void then
				buffer.putstring ("%Tit = iget();%N");
				buffer.putstring ("%Tit->type = ");
				result_type.generate_sk_value (buffer);
				buffer.putstring (";%N%Tit->");
				result_type.generate_union (buffer);
				buffer.putstring (" = result;%N");
			end;
			buffer.putstring ("}%N%N"); -- ss MT
		end;

	generate_toi_compound (id: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generate compound pattern from C code to the interpreter
		local
			f_name: STRING
			result_string: STRING
			arg_types: ARRAY [STRING]
		do
			f_name := "toi";
			f_name.append_integer (id);

			result_string := result_type.c_string;

			arg_types := argument_type_array (True);

			buffer.generate_function_signature
				(result_string, f_name, False, buffer,
				 argument_name_array, arg_types);

			buffer.putstring ("%Tstruct item *it;%N");
			generate_toi_push (buffer);
			buffer.putstring ("%Txinterp(IC);%N");
			if not result_type.is_void then
				buffer.putstring ("%
					%%Tit = opop();%N%
					%%Treturn it->");
				result_type.generate_union (buffer);
				buffer.putstring (";%N");
			end;
			buffer.putstring ("}%N%N"); -- ss MT
		end;

	generate_toi_push (buffer: GENERATION_BUFFER) is
			-- Generates stack pushing instruction for the patterns
			-- going from C to the interpreter
		local
			i, nb: INTEGER;
			arg: TYPE_C;
		do
			from
				i := 1;
				nb := argument_count;
			until
				i > nb
			loop
				arg := argument_types.item (i);
				buffer.putstring ("%Tit = iget();%N");
				buffer.putstring ("%Tit->type = ");
				arg.generate_sk_value (buffer);
				buffer.putstring (";%N%Tit->");
				arg.generate_union (buffer);
				buffer.putstring (" = arg");
				buffer.putint (i);
				buffer.putstring (";%N");
				i := i + 1;
			end;
			buffer.putstring ("%
				%%Tit = iget();%N%
				%%Tit->type = SK_REF;%N%
				%%Tit->it_ref = Current;%N");
		end;

	generate_toc_pop (buffer: GENERATION_BUFFER) is
			-- Generate poping instructions for pattern from interpreter
			-- to C code
		local
			i: INTEGER;
		do
			buffer.putstring ("%TCurrent = opop()->it_ref;%N");
			from
				i := argument_count;
			until
				i < 1
			loop
				buffer.putstring ("%Targ");
				buffer.putint (i);
				buffer.putstring (" = opop()->");
				argument_types.item (i).generate_union (buffer);
				buffer.putstring (";%N");
				i := i - 1;
			end;
		end;

	generate_separate_get (buffer: GENERATION_BUFFER) is
			-- Generate get instructions for pattern for separate call
		local
			i: INTEGER
		do
			buffer.putstring ("%TCurrent = CUROBJ;%N");
			from
				i := argument_count;
			until
				i < 1
			loop
				buffer.putstring ("%Targ");
				buffer.putint (i);
				buffer.putstring (" = ");
				buffer.putstring (argument_types.item (i).separate_get_macro);
				buffer.putchar ('(');
				buffer.putint (i - 1);
				buffer.putstring (");%N");
				i := i - 1;
			end
		end;

	generate_routine_call (is_extern: BOOLEAN; buffer: GENERATION_BUFFER) is
			-- Generate C routine call
		local
			i, nb: INTEGER;
			generate_test_macro: BOOLEAN;
		do
			if not result_type.is_void then
				buffer.putstring ("result = ");
			end;
			if is_extern and then result_type.is_boolean then
				generate_test_macro := True;
				buffer.putstring ("EIF_TEST((");
			else
				buffer.putchar ('(');
			end;
			result_type.generate_function_cast (buffer, argument_type_array (not is_extern));
			buffer.putstring ("ptr)(");
			nb := argument_count;
			if not is_extern then
				buffer.putstring ("Current");
				if nb > 0 then
					buffer.putchar (',');
				end;
			end;
			from
				i := 1;
			until
				i > nb
			loop
				buffer.putstring ("arg");
				buffer.putint (i);
				if i < nb then
					buffer.putchar (',');
				end;
				i := i + 1;
			end;
			if generate_test_macro then
				buffer.putchar (')');
			end;
			buffer.putstring (");%N");
		end;

	trace is
			-- Debug purpose
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > argument_count
			loop
				argument_types.item (i).trace;
				io.error.putchar ('/');
				i := i + 1;
			end;
			io.error.putchar ('|');
			result_type.trace;
			io.error.putstring ("|");
		end;

feature {NONE} -- Implemantation

	 toc_arg_types: ARRAY [STRING] is
			-- Types of the toc functions

		once
			Result := <<"fnptr", "int">>
		end

	equivalent_type (first_type, other_type: TYPE_C): BOOLEAN is
			-- Are `first_type' and `other_type' equivalent regarding C types
			-- used for generation.
		require
			first_type_not_void: first_type /= Void
			other_type_not_void: other_type /= Void
		local
			basic_i, other_basic_i: BASIC_I
		do
				-- Check if they have the exact same object type.
				-- If not they are different.
			if (first_type.same_type (other_type)) then
				Result := True

					-- If type is basic, we can call `same_as' to ensure that they
					-- are the same kind of basic types (eg LONG_I is used to
					-- represent all INTEGER classes, or CHAR_I to represent an ASCII
					-- character or a wide character).
					--
					-- If it is not, it means that we have either a NONE_I, a REFERENCE_I
					-- or a VOID_I and are test on the type ensure that here we have to
					-- we return True.
				basic_i ?= first_type
				if basic_i /= Void then
					other_basic_i ?= other_type
					Result := basic_i.same_as (other_basic_i)
				end
			end
		end

invariant

	result_type_exists: result_type /= Void

end
