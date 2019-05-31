note
	description: "Generate Boogie code from IV universe."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BOOGIE_GENERATOR

create
	make

feature {NONE} -- Initialization

	make (a_boogie_universe: IV_UNIVERSE)
			-- Initialize Boogie generator with universe `a_boogie_universe'.
		do
			boogie_universe := a_boogie_universe
		ensure
			boogie_universe_set: boogie_universe = a_boogie_universe
		end

feature -- Access

	boogie_universe: IV_UNIVERSE
			-- Boogie universe.

	last_generated_verifier_input: E2B_VERIFIER_INPUT
			-- Verifier input generated from `iv_universe'.

feature -- Basic operations

	generate_verifier_input
			-- Generate verifier input for `boogie_universe'.
		local
			l_printer: IV_BOOGIE_PRINTER
		do
			create last_generated_verifier_input.make

				-- Add universe dependencies
			across
				boogie_universe.dependencies as deps
			loop
				last_generated_verifier_input.add_boogie_file (deps.item)
			end

				-- Add background theory
			last_generated_verifier_input.add_boogie_file (theory_directory.extended ("base_theory.bpl"))

			create l_printer.make
			boogie_universe.process (l_printer)
			last_generated_verifier_input.add_custom_content (l_printer.output.out)
		end

feature {E2B_CUSTOM_AGENT_CALL_HANDLER} -- Implementation

	theory_directory: PATH
			-- Directory containing theory files.
		once
			if {EIFFEL_LAYOUT}.is_eiffel_layout_defined then
				Result := {EIFFEL_LAYOUT}.eiffel_layout.tools_path.extended ("autoproof")
			else
				create Result.make_current
			end
		ensure
			instance_free: class
		end

end
