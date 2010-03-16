note
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_PROJECTOR_IMP

inherit

	EV_ANY_IMP
		redefine
			interface
		end

	EV_PRINT_PROJECTOR_I
		redefine
			interface
		end

	EV_POSTSCRIPT_PROJECTOR
		redefine
			project,
			add_ps_line,
			add_footer
		end

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
		do
			base_make (an_interface)
		end

	initialize
		do
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Access

	project
		do
		end

	add_ps_line (ps_code: STRING_GENERAL)
			-- Append `ps_code' postscript to output.
		do
		end

feature {NONE} -- Implementation

	add_footer
			-- Add showpage if printing to printer.
		do
			Precursor {EV_POSTSCRIPT_PROJECTOR}
		end

	tmp_print_job_name: STRING
			-- A unique print job file name.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PRINT_PROJECTOR;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_PROJECTOR_IMP

