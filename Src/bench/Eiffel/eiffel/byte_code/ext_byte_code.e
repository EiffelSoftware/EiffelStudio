-- Byte code for external features

class EXT_BYTE_CODE 

inherit

	STD_BYTE_CODE
		rename
			generate as old_generate
		redefine
			generate_return_exp,generate_arguments, generate_compound,
			generate_arg_declarations, is_external
		end;

	STD_BYTE_CODE
		redefine
			generate,
			generate_return_exp,generate_arguments, generate_compound,
			generate_arg_declarations, is_external
		select
			generate
		end

	SHARED_INCLUDE
	
feature 

	external_name: STRING;
			-- External name to call

	encapsulated: BOOLEAN;
			-- Has the call to `external_name' to be 
			-- encapsulated ?

	is_special: BOOLEAN is
			-- Does the external declaration include a macro
		do
			Result := (special_file_name /= Void);
		end;

	has_signature: BOOLEAN is
			-- Does the external declaration include a signature ?
		do
			Result := has_arg_list or else has_return_type;
		end;

	has_arg_list: BOOLEAN is
			-- Does the signature include arguments ?
		do
			Result := (arg_list /= Void) and then (arg_list.count > 0);
		end;

	has_return_type: BOOLEAN is
			-- Does the signature include a return type ?
		do
			Result := (return_type /= Void);
		end;

	has_include_list: BOOLEAN is
			-- Does the external declaration include a list of include files ?
		do
			Result := (include_list /= Void) and then (include_list.count > 0);
		end;

	special_type: STRING;
			-- Type of macro; the name shoud be changed into special_type or type_name

	special_file_name: STRING;
			-- File name including the macro definition

	arg_list: ARRAY[STRING];
			-- List of arguments for the signature

	return_type: STRING;
			-- Return type of signature

	include_list: ARRAY[STRING];
			-- List of include files

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s;
		end;

	set_encapsulated (e: BOOLEAN) is
			-- Assign `e' to `encapsulated'
		do
			encapsulated := e;
		end;

	set_special_type (s: STRING) is
			-- Assign `s' to `special_type'
		do
			special_type := s;
	end;

	set_special_file_name (s: STRING) is
			-- Assign `s' to `special_file_name'
		do
			special_file_name := s;
		end;

	set_arg_list (a: ARRAY[STRING]) is
			-- Assign `a' to `arg_list'
		do
			arg_list := a;
		end;

	set_return_type (s: STRING) is
			-- Assign `s' to `return_type'
		do
			return_type := s;
		end;

	set_include_list (a: ARRAY[STRING]) is
		-- Assign `a' to `include_list'
		do
			include_list := a;
	end;

	is_external: BOOLEAN is
			-- Is the current byte code a byte code for external
			-- features ?
		do
			Result := True;
		end;

	generate is
			-- Byte code generation
		local
			assignment: ASSIGN_B;
			type_i: TYPE_I;
			internal_name: STRING;
			i: INTEGER;
		do
				-- Check first if there are no #include to generate
				-- required by the feature
			if is_special or has_include_list then
				if is_special and then not shared_include_set.has (special_file_name) then
					generated_file.putstring ("#include ");
					generated_file.putstring (special_file_name);
					generated_file.new_line;
					shared_include_set.extend (special_file_name);
				end;
				if has_include_list then
					from
						i := include_list.lower
					until
						i > include_list.upper
					loop
						if not shared_include_set.has (include_list.item (i)) then
							generated_file.putstring ("#include ");
							generated_file.putstring (include_list.item (i));
							generated_file.new_line;
							shared_include_set.extend (include_list.item (i));
						end;
						i := i + 1;
					end;
				end;
			end;
			if is_special or has_signature then
					-- Generate the header "int foo(Current, args)"
				type_i := real_type (result_type);
				type_i.c_type.generate (generated_file);

					-- Function's name
				internal_name := Encoder.feature_name
				(System.class_type_of_id (context.current_type.type_id).id,
				body_id);

					-- Generate function name
				generated_file.putstring (internal_name);
				generated_file.putchar ('(');
				generate_arguments;
				generated_file.putchar (')');
				generated_file.new_line;
					-- Now generate C declarations for arguments
				generate_arg_declarations;
					-- Starting body of C routine
				generated_file.putchar ('{');
				generated_file.new_line;
				generated_file.indent;
					-- Clone expanded parameters, raise exception in caller if
					-- needed (void assigned to expanded).
				generate_expanded_cloning;
					-- Generate execution trace information
			--	generate_execution_trace;
					-- Generate the saving of the workbench mode assertion level
				if context.workbench_mode then
			--		generate_save_assertion_level;
				end;
					-- Generate local expanded variable creations
				generate_expanded_variables;
					-- Now we want the body
				generate_call;
				generated_file.exdent;
				generated_file.putchar ('}');
				generated_file.new_line;
					-- Leave a blank line after function definition
				generated_file.new_line;
				Context.inherited_assertion.wipe_out;
				
			elseif encapsulated then
				old_generate;
			end;
		end;

	generate_compound is
			-- Call the external function
		do
			if context.result_used or postcondition /= Void or context.has_invariant then
				generated_file.putstring ("Result = ");
			else
				generated_file.putstring ("return ");
			end;
			generated_file.putstring (external_name);
			generated_file.putchar ('(');
			generate_arguments;
			generated_file.putchar (')');
			generated_file.putchar (';');
			generated_file.new_line;
		end;

	generate_call is 
			-- Generates the return macro/function with casts if needed
		local
			i, count: INTEGER;
		do
			if result_type /= Void or has_return_type then
				generated_file.putstring ("return ");
			end;
			if has_return_type then
				generated_file.putchar ('(');
				generated_file.putstring (return_type);
				generated_file.putchar (')');
				generated_file.putchar (' ');
			elseif result_type /= Void then
				result_type.c_type.generate_cast (generated_file);
			else
				generated_file.putstring ("(void) ");
			end;
			generated_file.putstring (external_name);
			if arguments /= Void or has_signature then
				generated_file.putchar ('(');
			end;
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					if has_arg_list then
						generated_file.putchar ('(');
						generated_file.putstring (arg_list.item (i));
						generated_file.putstring (") ");
					end;
					generated_file.putstring ("arg");
					generated_file.putint (i);
					i := i + 1;
					if i <= count then
						generated_file.putstring (", ");
					end;
				end;
			end;
			if arguments /= Void or has_signature then
				generated_file.putchar (')');
			end;
			generated_file.putchar (';');
			generated_file.new_line;
		end;

	generate_return_exp is
			-- Generate the final return
		do
			if context.result_used or postcondition /= Void or context.has_invariant then
				generated_file.putstring ("return Result;");
				generated_file.new_line;
			end;
		end;

	generate_arguments is
			-- Generate C arguments, if any, in the definition.
		local
			i, count: INTEGER;
		do
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					generated_file.putstring ("arg");
					generated_file.putint (i);
					i := i + 1;
					if i <= count then
						generated_file.putstring (", ");
					end;
				end;
			end;
		end;

	generate_arg_declarations is
			-- Declare C parameters, if any, as part of the definition.
		local
			arg: TYPE_I;
			i, count: INTEGER;
		do
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					arg := real_type (arguments.item (i));
					arg.c_type.generate (generated_file);
					generated_file.putstring ("arg");
					generated_file.putint (i);
					generated_file.putchar (';');
					generated_file.new_line;
					i := i + 1;
				end;
			end;
		end;
			
end
