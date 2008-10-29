indexing

	description:

		"Abstract testing strategy"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


deferred class AUT_STRATEGY

inherit

	AUT_TASK

feature {NONE} -- Initialization

	make (a_a_system: like system; an_interpreter: like interpreter) is
			-- Create new strategy.
		require
			a_a_system_not_void: a_a_system /= Void
			a_interpreter_not_void: an_interpreter /= Void
		do
			system := a_a_system
			interpreter := an_interpreter
		ensure
			system_set: system = a_a_system
			interpreter_set: interpreter = an_interpreter
		end

feature -- Status

	has_next_step: BOOLEAN is
			-- Is there a next step to execute?
		deferred
		end

feature -- Access

	system: SYSTEM_I
			-- system

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute tests

feature -- Execution

	start is
		do
			if not interpreter.is_running then
				interpreter.start
			end
		end

	cancel is
		do
		end

feature{NONE} -- Implementation

	assign_void is
			-- Assign void to the next free variable.
		local
			void_constant: ITP_CONSTANT
		do
			if interpreter.is_running and interpreter.is_ready then
				create void_constant.make (Void)
				interpreter.assign_expression (interpreter.variable_table.new_variable, void_constant)
			end
		end

invariant

	system_not_void: system /= Void
	interpreter_not_void: interpreter /= Void

end
