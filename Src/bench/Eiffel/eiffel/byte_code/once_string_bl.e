indexing

	description: "Enlarged byte code for once manifest string."
	date: "$Date$"
	revision: "$Revision$"

class
	ONCE_STRING_BL 

inherit
	ONCE_STRING_B
		redefine
			analyze,
			generate,
			print_register,
			register,
			set_register,
			unanalyze
		end

create
	make

feature 

	register: REGISTRABLE
			-- Where string is kept to ensure it is GC safe

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'.
		do
			register := r
		end

	unanalyze is
			-- Undo analysis work.
		do
			register := Void
		end

	analyze is
			-- Analyze the string.
		do
				-- FIXME: alexk 09 Aug 2004: This can be optimized in cases
				-- when once manifest strings are pre-initialized
			get_register
		end

	generate is
			-- Generate the string.
		do
			check register /= No_register end
			context.generate_once_manifest_string_access (register, value, number)
		end

	print_register is
			-- Print the string (or the register in which it is held).
		do
			check register /= No_register end
			register.print_register
		end

end