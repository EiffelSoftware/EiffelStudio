class
	TEST_PROC [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end]

inherit
	PROCEDURE [BASE_TYPE, OPEN_ARGS]
		redefine
			call
		end

create
	make

feature -- Initialization

	make (a_unbound_procedure: like unbound_procedure)
		do
			unbound_procedure := a_unbound_procedure
			unbound_arguments := unbound_procedure.empty_operands

			is_target_closed := True
			open_count := empty_operands.count
		end

feature -- Access

	unbound_arguments: TUPLE
	unbound_procedure: PROCEDURE [ANY, TUPLE]

feature -- Basic operations

	call (args: OPEN_ARGS)
				-- <Precursor>
		do
			unbound_arguments [1] := 47
			unbound_procedure.call (unbound_arguments)
		end
end

