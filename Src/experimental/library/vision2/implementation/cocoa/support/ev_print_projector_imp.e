note
	description: "Projection to a Printer."
	author: "Daniel Furrer."
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_PROJECTOR_IMP

obsolete
	"Use EV_MODEL_PRINT_PROJECTOR_IMP instead. [2017-05-31]"

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
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_world: EV_FIGURE_WORLD; a_context: EV_PRINT_CONTEXT)
		do
			make_with_world (a_world)
			make
		end

	make
			-- <Precursor>
		do
			create draw_routines.make_filled (Void, 0, 20)
			register_basic_figures
			set_is_initialized (True)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PRINT_PROJECTOR note option: stable attribute end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_PRINT_PROJECTOR_IMP
