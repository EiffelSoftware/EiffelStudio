-- Execution unit for an external feature

class EXT_EXECUTION_UNIT 

inherit
	EXECUTION_UNIT
		redefine
			real_body_id, make, is_valid,
			is_external, compound_name,
			generate_declaration
		end

creation
	make
	
feature 

	external_name: STRING;
			-- Name of the external

	make (cl_type: CLASS_TYPE; f: EXTERNAL_I) is
			-- Initialization
		local
			extension: EXTERNAL_EXT_I
		do
			{EXECUTION_UNIT} Precursor (cl_type, f);
			is_cpp := f.is_cpp;
			external_name := f.external_name;

			extension := f.extension
			if extension /= Void then
				argument_types := extension.argument_types
				if not (argument_types /= Void and then argument_types.count > 0) then
					argument_types := Void
				end
				return_type := extension.return_type
			end
		end;

	is_external: BOOLEAN is True
			-- Is the current executino unit an external one ?

	is_cpp: BOOLEAN
			-- Is Current a C++ member?

	argument_types: ARRAY [STRING]
			-- Type of C external routine's arguments.

	return_type: STRING
			-- Return type of C external routine.

	generate_declaration (buffer: GENERATION_BUFFER) is
			-- Generate external declaration for the compound routine
			--| In this case, there is no header file.
			--| If there is no C signature, we use `generate_declaration' from
			--| EXECUTION_UNIT to generate the declaration.
			--| If there is one C signature, we are using them to declare
			--| a correct external declaration.
		local
			args: ARRAY [STRING]
			i, nb: INTEGER
		do
			if argument_types /= Void then
				buffer.putstring ("extern ")

					--| If the return type is not specified we are taking the standard
					--| one.
				if return_type /= Void then
					buffer.putstring (return_type)
				else
					type.generate (buffer)
				end

				buffer.putstring (" ")
				buffer.putstring (external_name)

					--| We generate each argument separated by a coma.
				from
					buffer.putstring (" (")
					args := argument_types
					i := args.lower
					nb := args.upper
					buffer.putstring (args.item (i))
					i := i + 1
				until
					i > nb
				loop
					buffer.putstring (", ")
					buffer.putstring (args.item (i))
					i := i + 1
				end
				buffer.putstring (");%N")
			else
					-- If there is a return type, we need to declare it
					-- Otherwise we use the `Precursor' version of `generate_declaration'
				if return_type /= Void then
					buffer.putstring ("extern ")
					buffer.putstring (return_type)
					buffer.putstring (" ")
					buffer.putstring (external_name);
					buffer.putstring ("();%N");
				else
					{EXECUTION_UNIT} Precursor (buffer)
				end
			end
		end;
		
	compound_name: STRING is
			-- Compound C routine name
		do
			Result := external_name
		end;

	real_body_id: REAL_BODY_ID is
			-- Real body id
		local
			frozen_body_id: REAL_BODY_ID;
		do
			check
				consistency: Externals.has (external_name);
			end;
			frozen_body_id := Externals.item (external_name).real_body_id;
			if frozen_body_id /= Void then
				Result := frozen_body_id
			else
				Result := {EXECUTION_UNIT} Precursor;
			end;
		end;

	is_valid: BOOLEAN is
		do
			Result := Externals.has (external_name) and then IRS_valid
		end;

	IRS_valid: BOOLEAN is
			-- Is the execution unit still valid ?
		local
			written_type: CL_TYPE_I;
			written_class: CLASS_C
		do
			written_class := System.class_of_id (written_in);
			if written_class /= Void and then
				System.class_type_of_id (type_id) /= Void
			then
				written_type := class_type.written_type (written_class);
				if written_type /= Void then
					if
						written_type.associated_class_type.is_precompiled
					then
						Result := True
						-- The next line is solely here to grow some extra
						-- gray hair on the head of whoever is going to read it.
						-- Seriously: the body id may correspond to a FEATURE_I
						-- having undergone a "body id change". In that case the
						-- body id is not valid if the system has an equivalent
						-- one which is different.
					elseif equal (System.onbidt.item (body_id), body_id) then
						Result := server_has
					end;
				end;
			end;
		end;

	server_has: BOOLEAN is
		do
			Result := Body_server.has (body_id)
		end;
 
end
