note
	description: "Projection to a Printer."
	author: "Daniel Furrer."
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

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make_with_context (a_world: EV_FIGURE_WORLD; a_context: EV_PRINT_CONTEXT)
		do
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PRINT_PROJECTOR;

end -- class EV_PRINT_PROJECTOR_IMP
