indexing
	description: "Procedure with inspection features."

class
	EV_PROCEDURE [TARGET, OPERANDS -> TUPLE]

inherit
	PROCEDURE [TARGET, OPERANDS]
		rename
			open_operand_type as operand_type
		redefine
			out
		end

create
	make

feature -- Initialization

	make (a_procedure: PROCEDURE [ANY, OPERANDS]; procedure_name: STRING;
		procedure_operand_names: ARRAY [STRING]) is
			-- Adapt from `a_procedure' using `procedure_name' and
			-- `operand_names'.
		require
			a_procedure_not_void: a_procedure /= Void
			procedure_name_not_void: procedure_name /= Void
			procedure_operand_names_not_void: procedure_operand_names /= Void
			procedure_operand_names_count:
				procedure_operand_names.count = a_procedure.open_count
		do
			adapt (a_procedure)
			name := clone (procedure_name)
			operand_names := deep_clone (procedure_operand_names)
		end

feature -- Access

	name: STRING
			-- Name of procedure.

	operand_name (i: INTEGER): STRING is
			-- Name of `i'th operand.
		do
			Result := operand_names.item (i)
		end

	operand_type_name (i: INTEGER): STRING is
			-- Type name of `i'th operand.
		do
--			Result := (internal.new_instance_of (operand_type (i))).generating_type
			Result := operand_names.item (i) + "_TYPE"
			Result.to_upper
		end

	out: STRING is
			-- Textual representation.
		local
			i: INTEGER
		do
			Result := name + " ("
			from
				i := operand_names.lower
			until
				i > operand_names.upper
			loop
				Result.append (
					operand_names.item (i) + ": " + operand_type_name (i)
				)
				i := i + 1
				if i <= operand_names.upper then
					Result.append ("; ")
				end
			end
			Result.append (")")
		end
		
feature {EV_PROCEDURE} -- Implementation

	operand_names: ARRAY [STRING]

	internal: INTERNAL is
			-- Internal access.
		once
			create Result
		end

invariant
	operand_names_count_is_open_count: 
		operand_names.count = open_count

end -- class EV_PROCEDURE
