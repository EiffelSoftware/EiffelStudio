note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_STATEMENT_VISITOR

feature -- Visitor

	process_assert (a_assert: IV_ASSERT)
			-- Process `a_assert'.
		require
			a_assert_attached: attached a_assert
		deferred
		end

	process_assume (a_assume: IV_ASSERT)
			-- Process `a_assume'.
		require
			a_assume: attached a_assume
		deferred
		end

	process_assignment (a_assignment: IV_ASSIGNMENT)
			-- Process `a_assignment'.
		require
			a_assignment_attached: attached a_assignment
		deferred
		end

	process_block (a_block: IV_BLOCK)
			-- Process `a_block'.
		require
			a_block_attached: attached a_block
		deferred
		end

	process_conditional (a_conditional: IV_CONDITIONAL)
			-- Process `a_conditional'.
		require
			a_conditional_attached: attached a_conditional
		deferred
		end

	process_havoc (a_havoc: IV_HAVOC)
			-- Process `a_havoc'.
		require
			a_havoc_attached: attached a_havoc
		deferred
		end

	process_label (a_label: IV_LABEL)
			-- Process `a_label'.
		require
			a_label_attached: attached a_label
		deferred
		end

	process_loop (a_loop: IV_LOOP)
			-- Process `a_loop'.
		require
			a_loop_attached: attached a_loop
		deferred
		end

	process_goto (a_goto: IV_GOTO)
			-- Process `a_goto'.
		require
			a_goto_attached: attached a_goto
		deferred
		end

	process_procedure_call (a_call: IV_PROCEDURE_CALL)
			-- Process `a_call'.
		require
			a_call_attached: attached a_call
		deferred
		end

	process_return (a_return: IV_RETURN)
			-- Process `a_return'.
		require
			a_return_attached: attached a_return
		deferred
		end

end
