-- Execution unit for an external feature

class EXT_EXECUTION_UNIT 

inherit
	EXECUTION_UNIT
		redefine
			real_body_id, is_valid,
			is_external, compound_name,
			generate_declaration
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal
		end

creation
	make
	
feature -- Access

	external_name_id: INTEGER
			-- Name of the external

	argument_types: ARRAY [INTEGER]
			-- Type of C external routine's arguments.

	return_type_id: INTEGER
			-- Return type ID of C external routine.

feature -- String Access

	external_name: STRING is
			-- Return type of C external routine.
		require
			external_name_id_set: external_name_id > 0
		do
			Result := Names_heap.item (external_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

	return_type: STRING is
			-- Return type of C external routine.
		require
			return_type_id_set: return_type_id > 0
		do
			Result := Names_heap.item (return_type_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Setting

	set_external_name_id (name_id: like external_name_id) is
			-- Assign `name_id' to `external_name_id'.
		require
			valid_name_id: name_id > 0
		do
			external_name_id := name_id
		ensure
			external_name_set: external_name_id = name_id
		end

	set_argument_types (arr: like argument_types) is
			-- Assign `arr' to `argument_types'.
		do
			argument_types := arr
		ensure
			argument_types_set: argument_types = arr
		end

	set_return_type_id (name_id: like return_type_id) is
			-- Assign `name_id' to `return_type_id'.
		do
			return_type_id := name_id
		ensure
			return_type_set: return_type_id = name_id
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
				consistency: Externals.has (external_name_id)
			end
			frozen_body_id := Externals.item (external_name_id).real_body_id
			if frozen_body_id > 0 then
				Result := frozen_body_id
			else
				Result := {EXECUTION_UNIT} Precursor
			end
		end

	is_valid: BOOLEAN is
			-- Is execution unit still valid?
		do
			Result := Externals.has (external_name_id) and then Precursor {EXECUTION_UNIT}
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
			args: like argument_types
			l_names_heap: like Names_heap
			i, nb: INTEGER
		do
			if argument_types /= Void then
				buffer.putstring ("extern ")

					--| If the return type is not specified we are taking the standard
					--| one.
				if return_type_id > 0 then
					buffer.putstring (return_type)
				else
					type.generate (buffer)
				end

				buffer.putstring (" ")
				buffer.putstring (external_name)

					--| We generate each argument separated by a coma.
				from
					l_names_heap := Names_heap
					buffer.putstring (" (")
					args := argument_types
					i := args.lower
					nb := args.upper
					buffer.putstring (l_names_heap.item (args.item (i)))
					i := i + 1
				until
					i > nb
				loop
					buffer.putstring (", ")
					buffer.putstring (l_names_heap.item (args.item (i)))
					i := i + 1
				end
				buffer.putstring (");%N")
			else
					-- If there is a return type, we need to declare it
					-- Otherwise we use the `Precursor' version of `generate_declaration'
				if return_type_id > 0 then
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
			Result := Names_heap.item (external_name_id)
		end

end
