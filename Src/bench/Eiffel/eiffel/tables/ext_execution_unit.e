-- Execution unit for an external feature

class EXT_EXECUTION_UNIT 

inherit
	EXECUTION_UNIT
		redefine
			real_body_id, is_valid,
			is_external, compound_name,
			generate_declaration
		end

creation
	make
	
feature -- Access

	external_name: STRING
			-- Name of the external

	argument_types: ARRAY [STRING]
			-- Type of C external routine's arguments.

	return_type: STRING
			-- Return type of C external routine.

feature -- Setting

	set_external_name (name: like external_name) is
			-- Assign `name' to `external_name'.
		require
			name_not_void: name /= Void implies not name.is_empty
		do
			external_name := name
		ensure
			external_name_set: external_name = name
		end

	set_argument_types (arr: like argument_types) is
			-- Assign `arr' to `argument_types'.
		do
			argument_types := arr
		ensure
			argument_types_set: argument_types = arr
		end

	set_return_type (name: like return_type) is
			-- Assign `name' to `return_type'.
		require
			name_not_void: name /= Void implies not name.is_empty
		do
			return_type := name
		ensure
			return_type_set: return_type = name
		end

feature -- Status

	is_external: BOOLEAN is True
			-- Is the current executino unit an external one ?

	real_body_id: INTEGER is
			-- Real body id
		local
			frozen_body_id: INTEGER
		do
			check
				consistency: Externals.has (external_name)
			end
			frozen_body_id := Externals.item (external_name).real_body_id
			if frozen_body_id > 0 then
				Result := frozen_body_id
			else
				Result := {EXECUTION_UNIT} Precursor
			end
		end

	is_valid: BOOLEAN is
			-- Is execution unit still valid?
		do
			Result := Externals.has (external_name) and then Precursor {EXECUTION_UNIT}
		end

feature -- Generation

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
					buffer.putstring (external_name)
					buffer.putstring ("();%N")
				else
					{EXECUTION_UNIT} Precursor (buffer)
				end
			end
		end
		
	compound_name: STRING is
			-- Compound C routine name
		do
			Result := external_name
		end

end
