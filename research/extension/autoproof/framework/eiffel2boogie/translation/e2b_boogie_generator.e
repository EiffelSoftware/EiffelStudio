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
			l_filename: FILE_NAME
		do
			create last_generated_verifier_input.make

				-- Add universe dependencies
			across
				boogie_universe.dependencies as deps
			loop
				last_generated_verifier_input.add_boogie_file (deps.item)
			end

				-- Add background theory
			create l_filename.make
			l_filename.set_directory (theory_directory)
			l_filename.set_file_name ("base_theory.bpl")
			last_generated_verifier_input.add_boogie_file (l_filename)

			create l_printer.make
			boogie_universe.process (l_printer)
			last_generated_verifier_input.add_custom_content (l_printer.output.out)
		end

feature {NONE} -- Implementation

	theory_directory: DIRECTORY_NAME
			-- Directory containing theory files.
		local
			l_ee: EXECUTION_ENVIRONMENT
			l_ise_eiffel, l_eiffel_src: STRING
			l_path: DIRECTORY_NAME
			l_dir: DIRECTORY
		once
			create l_ee

				-- 1. Delivery of installation
			create l_path.make_from_string (l_ee.get ("ISE_EIFFEL"))
			l_path.extend ("studio")
			l_path.extend ("tools")
			l_path.extend ("autoproof")
			create l_dir.make (l_path)

				-- 2. Delivery of development version
			if not l_dir.exists then
				create l_path.make_from_string (l_ee.get ("EIFFEL_SRC"))
				l_path.extend ("Delivery")
				l_path.extend ("studio")
				l_path.extend ("tools")
				l_path.extend ("autoproof")
			end

			Result := l_path
		end

end
