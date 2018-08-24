note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	E2B_OPTIONS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default options.
		do
			is_two_step_verification_enabled := False
			is_inlining_enabled := True
			is_automatic_inlining_enabled := False
			is_automatic_loop_unrolling_enabled := False
			is_sound_loop_unrolling_enabled := True
			is_postcondition_predicate_enabled := False
			is_checking_overflow := False

			is_generating_triggers := False
			is_triggering_on_arithmetic := False
			is_arithmetic_extracted := False
			is_inv_check_independent := True
			is_ignoring_nonvariant := False

			is_ownership_enabled := True
			is_ownership_defaults_enabled := True

			loop_unrolling_depth := 7
			max_recursive_inlining_depth := 4

			is_postcondition_mutation_enabled := False
			is_coupled_mutations_enabled := True
			is_aging_enabled := False
			is_uncoupled_mutations_enabled := False

			is_trace_enabled := False

			is_generating_trivial_loop_variants := True

			is_bulk_verification_enabled := True
			max_parallel_boogies := 3

			is_print_time := True
		end

feature -- Inlining verification step

	is_two_step_verification_enabled: BOOLEAN
			-- Is a verification with inlining done in case of failed verifications?

	set_two_step_verification_enabled (a_value: BOOLEAN)
			-- Set `is_two_step_verification_enabled' to `a_value'.
		do
			is_two_step_verification_enabled := a_value
		end


feature --Postcondition mutation step

	is_postcondition_mutation_enabled: BOOLEAN
			-- Should postcondition mutation be executed?

	set_postcondition_mutation_enabled (a_value: BOOLEAN)
			-- Set `is_postcondition_mutation_enabled' to `a_value'.
		do
			is_postcondition_mutation_enabled := a_value
		end

	is_coupled_mutations_enabled : BOOLEAN
			-- Execute postcondition mutation with coupled mutations?
			-- This is usually the minimum, but can be turned off if uncoupled is used instead.

	set_coupled_mutations_enabled (a_value: BOOLEAN)
			-- Set `is_coupled_mutations_enabled' to `a_value'.
		do
			is_coupled_mutations_enabled := a_value
		end

	is_uncoupled_mutations_enabled: BOOLEAN
			-- Execute postcondition mutation with uncoupled mutations?

	set_uncoupled_mutations_enabled(a_value: BOOLEAN)
			-- Set `is_uncoupled_mutations_enabled' to `a_value'.
		do
			is_uncoupled_mutations_enabled := a_value
		end

	is_aging_enabled : BOOLEAN
			-- Execute postcondition mutation with variable aging?

	set_aging_enabled (a_value: BOOLEAN)
			-- Set `is_aging_enabled' to `a_value'.
		do
			is_aging_enabled := a_value
		end

feature -- Inlining options

	is_inlining_enabled: BOOLEAN
			-- Is inlining enabled?

	inlining_depth: INTEGER
			-- Current inlining depth.

	max_recursive_inlining_depth: INTEGER
			-- Maximum inlining depth for inlining recursive features.

	set_max_recursive_inlining_depth (a_value: INTEGER)
			-- Set `max_recursive_inlining_depth' to `a_value'.
		do
			max_recursive_inlining_depth := a_value
		end

	set_inlining_depth (a_value: INTEGER)
			-- Set `inlining_depth' to `a_value'.
		do
			inlining_depth := a_value
		end

	is_automatic_inlining_enabled: BOOLEAN
			-- Is automatic inlining of certain routines enabled?

	set_automatic_inlining_enabled (a_value: BOOLEAN)
			-- Set `is_automatic_inlining_enabled' to `a_value'.
		do
			is_automatic_inlining_enabled := a_value
		end

	routines_to_inline: LINKED_LIST [INTEGER]
			-- Routines to inline.
		once
			create Result.make
		end

feature -- Loop unrolling

	loop_unrolling_depth: INTEGER
			-- Loop unrolling depth.

	set_loop_unrolling_depth (a_value: INTEGER)
			-- Set `loop_unrolling_depth' to `a_value'.
		do
			loop_unrolling_depth := a_value
		end

	is_automatic_loop_unrolling_enabled: BOOLEAN
			-- Is automatic unrolling of certain loops enabled?

	set_automatic_loop_unrolling_enabled (a_value: BOOLEAN)
			-- Set `is_automatic_loop_unrolling_enabled' to `a_value'.
		do
			is_automatic_loop_unrolling_enabled := a_value
		end

	is_sound_loop_unrolling_enabled: BOOLEAN
			-- Is loop unrolling being done in a sound way?

	set_sound_loop_unrolling_enabled (a_value: BOOLEAN)
			-- Set `is_sound_loop_unrolling_enabled' to `a_value'.
		do
			is_sound_loop_unrolling_enabled := a_value
		end

feature -- Precondition and postcondition predicates

	is_postcondition_predicate_enabled: BOOLEAN
			-- Is generation of postcondition predicates enabled?

	set_postcondition_predicate_enabled (a_value: BOOLEAN)
			-- Set `is_postcondition_predicate_enabled' to `a_value'.
		do
			is_postcondition_predicate_enabled := a_value
		end

feature -- Arithmetic operations

	is_checking_overflow: BOOLEAN
			-- Is checking of overflow enabled?

	set_checking_overflow (a_value: BOOLEAN)
			-- Set `is_checking_overflow' to `a_value'.
		do
			is_checking_overflow := a_value
		end

feature -- Quantifiers

	is_generating_triggers: BOOLEAN
			-- Should AutoProof add triggers to quantified expressions?

	set_generating_triggers (a_value: BOOLEAN)
			-- Set `is_generating_triggers' to `a_value'.
		do
			is_generating_triggers := a_value
		end

	is_triggering_on_arithmetic: BOOLEAN
			-- Should arithmetic operations inside quantifiers be translated as functions,
			-- so that they can be used in triggers?

	set_triggering_on_arithmetic (a_value: BOOLEAN)
			-- Set `is_triggering_on_arithmetic' to `a_value'.
		do
			is_triggering_on_arithmetic := a_value
		end

	is_arithmetic_extracted: BOOLEAN
			-- Should arithmetic operations in function/map arguments inside quantifiers
			-- be extracted into fresh bound variables?

	set_arithmetic_extracted (a_value: BOOLEAN)
			-- Set `is_arithmetic_extracted' to `a_value'.
		do
			is_arithmetic_extracted := a_value
		end

	is_inv_check_independent: BOOLEAN
			-- Should each invariant clause be checked independently?

	set_inv_check_independent (a_value: BOOLEAN)
			-- Set `is_inv_check_independent' to `a_value'.
		do
			is_inv_check_independent := a_value
		end

	is_ignoring_nonvariant: BOOLEAN
			-- Should the "nonvariant" annotation be ignored?

	set_ignoring_nonvariant (a_value: BOOLEAN)
			-- Set `is_ignoring_nonvariant' to `a_value'.
		do
			is_ignoring_nonvariant := a_value
		end

feature -- Framing

	is_ownership_enabled: BOOLEAN
			-- Is ownership enabled?

	set_ownership_enabled (a_value: BOOLEAN)
			-- Set `is_ownership_enabled' to `a_value'.
		do
			is_ownership_enabled := a_value
		end

	is_ownership_defaults_enabled: BOOLEAN
			-- Is ownership enabled?

	set_ownership_defaults_enabled (a_value: BOOLEAN)
			-- Set `is_ownership_defaults_enabled' to `a_value'.
		do
			is_ownership_defaults_enabled := a_value
		end

feature -- Boogie/Z3

	is_enforcing_timeout: BOOLEAN
			-- Is timeout enforced?

	set_is_enforcing_timeout (a_value: BOOLEAN)
			-- Set `is_enforcing_timeout' to `a_value'.
		do
			is_enforcing_timeout := a_value
		end

	timeout: INTEGER
			-- Timeout of z3 in seconds.

	set_timeout (a_value: INTEGER)
			-- Set `timeout' to `a_value'.
		do
			timeout := a_value
		end

	is_trace_enabled: BOOLEAN
			-- Are trace statements printed?

	set_is_trace_enabled (a_value: BOOLEAN)
			-- Set `is_trace_enabled' to `a_value'.
		do
			is_trace_enabled := a_value
		end

feature -- Output

	is_print_time: BOOLEAN
			-- Is verification time output to the console?

	set_print_time (a_value: BOOLEAN)
			-- Set `is_time_output' to `a_value'.
		do
			is_print_time := a_value
		end

feature -- Other

	is_generating_trivial_loop_variants: BOOLEAN
			-- Are trivially false loop variants generated?

	is_bulk_verification_enabled: BOOLEAN
			-- Are classes verified in bulk or by individual routines?

	set_bulk_verification_enabled (a_value: BOOLEAN)
			-- Set `is_bulk_verification_enabled' to `a_value'.
		do
			is_bulk_verification_enabled := a_value
		end

	max_parallel_boogies: INTEGER
			-- Maximum number of parallel Boogie instances.

	set_max_parallel_boogies (a_value: INTEGER)
			-- Set `max_parallel_boogies' to `a_value'.
		do
			max_parallel_boogies := a_value
		end

end
