note

	description:

		"Abstract formatter which generates output adapted to a specific Eiffel compiler"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EIFFEL_COMPILER_SPECIFIC_PRINTER

inherit

	EWG_PRINTER
		redefine
			make_internal
		end

create
	make,
	make_string


feature {NONE} -- Initialization

	make_internal
		do
			create eiffel_compiler_mode.make
		end

feature -- Status

	eiffel_compiler_mode: EWG_EIFFEL_COMPILER_MODE
			-- Eiffel compiler mode

end
