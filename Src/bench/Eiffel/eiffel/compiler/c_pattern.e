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
				-- Use of `deep_equal' is valid as no SPECIAL objects are
				-- involved
			Result := 	deep_equal (result_type, other.result_type)
						and then
						n = other.argument_count;
			from
				i := 1;
			until
				i > n or else not Result
			loop
					-- Use of `deep_equal' is valid as no SPECIAL objects are
					-- involved
				Result := deep_equal (argument_types.item (i),
											(other.argument_types.item (i)));
				i := i + 1;
			end;
		end;

	hash_code: INTEGER is
			-- Hash code for pattern
		local
			i, n, m: INTEGER;
		do
			Result := result_type.hash_code;
			n := argument_count;
			if n > 0 then
				from
					i := 1;
				until
					i > n
				loop
					inspect i \\ 6
					when 1 then m := 10;
					when 2 then m := 100;
					when 3 then m := 1000;
					when 4 then m := 10000;
					when 5 then m := 100000;
					when 0 then m := 1000000;
					end;
					Result := Result + m * argument_types.item (i).hash_code;
					i := i + 1;
				end;
			end;
		end;

feature -- Pattern generation

	generate_hooks (file: INDENT_FILE) is
			-- Generate garbage collector hooks
		local
			i, nb: INTEGER;
		do
			file.putstring ("%T%TRTLI(");
			file.putint (nb_hooks);
			file.putstring (");%N");
			file.putstring ("%T%Tl[0] = Current;%N");
			from
				i := 1;
				nb := argument_count;
			until
				i > nb
			loop
				if argument_types.item (i).is_pointer then
					file.putstring ("%T%Tl[");
					file.putint (argument_hook_index (i));
					file.putstring ("] = arg");
					file.putint (i);
					file.putstring (";%N");
				end;
				i := i + 1;
			end;
			if result_type.is_pointer then
				file.putstring ("%T%Tl[");
				file.putint (nb_hooks - 1);
				file.putstring ("] = Result;%N");
			end;
		end;

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

	generate_argument_declaration (nbtab: INTEGER; file: INDENT_FILE) is
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
					file.putchar ('%T');
					j := j + 1;
				end;
				argument_types.item (i).generate (file);
				file.putstring ("arg");
				file.putint (i);
				file.putchar (';');
				file.new_line;
				i := i + 1;
			end;
		end;

	generate_arguments_in_call (file: INDENT_FILE) is
			-- Generate arguments in call
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := argument_count;
			until
				i > nb
			loop
				if argument_types.item (i).is_pointer then
					file.putstring (", l[");
					file.putint (argument_hook_index (i));
					file.putchar (']');
				else
					file.putstring (", arg");
					file.putint (i);
				end;
				i := i + 1;
			end;
		end;

	generate_pattern (id: INTEGER; file: INDENT_FILE) is
			-- Generate pattern
		local
			arg: TYPE_C;
			i, nb: INTEGER;
		do
				-- Generate pattern from C code to interpreter
			generate_toi_compound (id, file);

				-- Compound pattern from interpreter to C code
			generate_toc_compound (id, file);
		end;

	generate_separate_pattern (id: INTEGER; file: INDENT_FILE) is
		local
			f_name: STRING
		do
			f_name := "sepcall";
			f_name.append_integer (id);

			file.generate_function_signature ("void", f_name, False, file,
					<<"ptr", "is_extern">>,
					<<"fnptr", "int">>);

			file.putstring ("%
				%%TEIF_REFERENCE Current;%N%
				%%TEIF_INTEGER ack = _concur_command_ack;%N");
			if not result_type.is_void then
				file.putchar ('%T');
				result_type.generate (file);
				file.putstring ("result;%N");
			end;
			generate_argument_declaration (1, file);
			generate_separate_get (file);
			file.putstring ("%Tif (is_extern)%N%T%T");
			generate_routine_call (True, file);
			file.putstring ("%Telse%N%T%T");
			generate_routine_call (False, file);
			if result_type.is_void then
				file.putstring ("%TCURSPA(_concur_current_client->sock, ack);%N")
			else
				file.putstring ("%T");
				file.putstring (result_type.separate_send_macro);
				file.putstring ("(result);%N");
			end;
			file.putstring ("}%N%N");
		end;

	generate_toc_compound (id: INTEGER; file: INDENT_FILE) is
			-- Generate compound pattern from interpreter to C code
		local
			f_name: STRING
		do
			f_name := "toc";
			f_name.append_integer (id);

			file.generate_function_signature ("void", f_name, False, file,
					<<"ptr", "is_extern">>,
					toc_arg_types);
			file.putstring ("%
				%%TEIF_REFERENCE Current;%N");
			if not result_type.is_void then
				file.putchar ('%T');
				result_type.generate (file);
				file.putstring ("result;%N%Tstruct item *it;%N");
			end;
			generate_argument_declaration (1, file);
			generate_toc_pop (file);
			file.putstring ("%Tif (is_extern)%N%T%T");
			generate_routine_call (True, file);
			file.putstring ("%Telse%N%T%T");
			generate_routine_call (False, file);
			if not result_type.is_void then
				file.putstring ("%Tit = iget();%N");
				file.putstring ("%Tit->type = ");
				result_type.generate_sk_value (file);
				file.putstring (";%N%Tit->");
				result_type.generate_union (file);
				file.putstring (" = result;%N");
			end;
			file.putstring ("}%N%N");
		end;

	generate_toi_compound (id: INTEGER; file: INDENT_FILE) is
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

			file.generate_function_signature
				(result_string, f_name, False, file,
				 argument_name_array, arg_types);

			file.putstring ("%Tstruct item *it;%N");
			generate_toi_push (file);
			file.putstring ("%Txinterp(IC);%N");
			if not result_type.is_void then
				file.putstring ("%
					%%Tit = opop();%N%
					%%Treturn it->");
				result_type.generate_union (file);
				file.putstring (";%N");
			end;
			file.putstring ("}%N%N");
		end;

	generate_toi_push (file: INDENT_FILE) is
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
				file.putstring ("%Tit = iget();%N");
				file.putstring ("%Tit->type = ");
				arg.generate_sk_value (file);
				file.putstring (";%N%Tit->");
				arg.generate_union (file);
				file.putstring (" = arg");
				file.putint (i);
				file.putstring (";%N");
				i := i + 1;
			end;
			file.putstring ("%
				%%Tit = iget();%N%
				%%Tit->type = SK_REF;%N%
				%%Tit->it_ref = Current;%N");
		end;

	generate_toc_pop (file: INDENT_FILE) is
			-- Generate poping instructions for pattern from interpreter
			-- to C code
		local
			i: INTEGER;
		do
			file.putstring ("%TCurrent = opop()->it_ref;%N");
			from
				i := argument_count;
			until
				i < 1
			loop
				file.putstring ("%Targ");
				file.putint (i);
				file.putstring (" = opop()->");
				argument_types.item (i).generate_union (file);
				file.putstring (";%N");
				i := i - 1;
			end;
		end;

	generate_separate_get (file: INDENT_FILE) is
			-- Generate get instructions for pattern for separate call
		local
			i: INTEGER
		do
			file.putstring ("%TCurrent = CUROBJ;%N");
			from
				i := argument_count;
			until
				i < 1
			loop
				file.putstring ("%Targ");
				file.putint (i);
				file.putstring (" = ");
				file.putstring (argument_types.item (i).separate_get_macro);
				file.putchar ('(');
				file.putint (i - 1);
				file.putstring (");%N");
				i := i - 1;
			end
		end;

	generate_routine_call (is_extern: BOOLEAN; file: INDENT_FILE) is
			-- Generate C routine call
		local
			i, nb: INTEGER;
			generate_test_macro: BOOLEAN;
		do
			if not result_type.is_void then
				file.putstring ("result = ");
			end;
			if is_extern and then result_type.is_boolean then
				generate_test_macro := True;
				file.putstring ("EIF_TEST((");
			else
				file.putchar ('(');
			end;
			result_type.generate_function_cast (file,
				argument_type_array (not is_extern));
			file.putstring ("ptr)(");
			nb := argument_count;
			if not is_extern then
				file.putstring ("Current");
				if nb > 0 then
					file.putchar (',');
				end;
			end;
			from
				i := 1;
			until
				i > nb
			loop
				file.putstring ("arg");
				file.putint (i);
				if i < nb then
					file.putchar (',');
				end;
				i := i + 1;
			end;
			if generate_test_macro then
				file.putchar (')');
			end;
			file.putstring (");%N");
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

invariant

	result_type_exists: result_type /= Void

end
