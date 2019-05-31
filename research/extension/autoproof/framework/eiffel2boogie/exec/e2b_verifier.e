note
	description: "[
		Interface to run the Boogie verifier.
		
		Usage:
			create verifier.make
			verifier.input.add_boogie_file ("file.bpl")
			verifier.input.add_custom_content ("some boogie code")
			verifier.verify
			verifier.parse_verification_output
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_VERIFIER

inherit

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Boogie verifier.
		do
			create {E2B_PLATFORM_EXECUTABLE_IMPL} executable
			create input.make
		end

feature -- Access

	input: E2B_VERIFIER_INPUT
			-- Input for verifier.

	last_result: detachable E2B_BOOGIE_RESULT
			-- Result of last run of Boogie.
		do
			if not attached internal_last_result and then attached last_output then
				parse_verification_output
			end
			Result := internal_last_result
		end

	last_output: detachable STRING
			-- Output of last run of Boogie.
		do
			Result := executable.last_output
		end

feature -- Status report

	is_running: BOOLEAN
			-- Is Boogie verifier running right now?
		do
			Result := executable.is_running
		end

feature -- Element change

	set_input (a_input: like input)
			-- Set `input' to `a_input'.
		require
			a_input_attached: attached a_input
		do
			input := a_input
		ensure
			input_set: input = a_input
		end

feature -- Basic operations

	verify
			-- Launch Boogie verifier on input.
		do
			internal_last_result := Void
			executable.set_input (input)
			executable.run
		end

	verify_asynchronous
			-- Launch Boogie verifier on input, without waiting for Boogie to finish.
		do
			internal_last_result := Void
			executable.set_input (input)
			executable.run_asynchronous
		end

	cancel
			-- Cancel execution of Boogie.
		do
			executable.cancel
		end

	parse_verification_output
			-- Parse `last_output' and fill `last_result'.
		require
			last_output_set: attached last_output
		local
			l_boogie_parser: E2B_BOOGIE_OUTPUT_PARSER
		do
			create l_boogie_parser.make
			l_boogie_parser.parse (last_output)
			internal_last_result := l_boogie_parser.last_result
		ensure
			last_result_set: attached last_result
		end

feature {NONE} -- Implementation

	executable: attached E2B_EXECUTABLE
			-- Boogie executable.

	internal_last_result: detachable E2B_BOOGIE_RESULT
			-- Cached last result.

end
