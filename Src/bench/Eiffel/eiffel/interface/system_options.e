indexing
	description: "Options of the system as there are specified in the ace file";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_OPTIONS

feature -- Update

	set_has_multithreaded (b: BOOLEAN) is
			-- Set `has_multithreaded' to `b'
		do
			has_multithreaded := b
		ensure
			has_multithreaded_set: has_multithreaded = b
		end

	set_java_generation (b: BOOLEAN) is
			-- Set `java_generation' to `b'
		do
			java_generation := b
		ensure
			jave_generation_set : java_generation = b
		end

	set_do_not_check_vape (b: BOOLEAN) is
		do
			do_not_check_vape := b
		ensure
			do_not_check_vape_set: do_not_check_vape = b
		end

	allow_address_expression (b: BOOLEAN) is
		do
			address_expression_allowed := b
		ensure
			address_expression_allowed_set: address_expression_allowed = b
		end

	set_inlining_size (i: INTEGER) is
		do
debug ("INLINING")
	io.error.putstring ("Inlining size: ")
	io.error.putint (i)
	io.error.new_line
end
			inlining_size := i
		ensure
			inlining_size_set: inlining_size = i
		end

	set_inlining_on (b: BOOLEAN) is
		do
			inlining_on := b
		ensure
			inlining_on_set: inlining_on = b
		end

	set_array_optimization_on (b: BOOLEAN) is
		do
			array_optimization_on := b
		ensure
			array_optimization_on_set: array_optimization_on = b
		end

	set_remover_off (b: BOOLEAN) is
			-- Assign `b' to `remover_off'
		do
			remover_off := b
		ensure
			remover_off_set: remover_off = b
		end

	set_code_replication_off (b: BOOLEAN) is
			-- Assign `b' to `replication_off'
		do
			code_replication_off := b
		ensure
			code_replication_off_set: code_replication_off = b
		end

	set_exception_stack_managed (b: BOOLEAN) is
		do
			exception_stack_managed := b
		ensure
			exception_stack_managed_set: exception_stack_managed = b
		end

	set_has_expanded is
			-- Set `has_expanded' to True
		do
debug ("ACTIVITY")
	io.error.putstring ("%N%NSystem has expanded%N%N")
end
			has_expanded := True
		ensure
			has_expanded_set: has_expanded = True
		end

	set_line_generation (b: BOOLEAN) is
			-- Set `line_generation' to `b'
		do
			line_generation := b
		ensure
			line_generation_set : line_generation = b
		end

feature -- Access

	remover_off: BOOLEAN
			-- Is the remover off (by specifying the Ace option)

	array_optimization_on: BOOLEAN
			-- Is array optimization on?

	inlining_on: BOOLEAN;
			-- Is inlining on ?

	inlining_size: INTEGER
			-- Size of the feature which will be inlined.

	do_not_check_vape: BOOLEAN;

	address_expression_allowed: BOOLEAN;
	
	java_generation : BOOLEAN
			-- Does the system generate Java byte code?

	line_generation : BOOLEAN
			-- Does the system generate the line number in the C-code?

	has_multithreaded: BOOLEAN
			-- Is the system a multithreaded one?

	code_replication_off: BOOLEAN;
			-- Is code replication off (by specifying the Ace option)

	exception_stack_managed: BOOLEAN;
			-- Is the exception stack managed in final mode

	has_expanded: BOOLEAN;
			-- Is there an expanded declaration in the system,
			-- i.e. some extra check must be done after pass2 ?

end -- class SYSTEM_OPTIONS
