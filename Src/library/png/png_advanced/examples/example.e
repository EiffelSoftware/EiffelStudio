indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXAMPLE

create
	make

feature -- Initialization

	make is
		do
			Create ex1.make
			Create ex2.make
		end

feature -- Implementation

	ex1: FIGURES_EXAMPLE

	ex2: MERGING_EXAMPLE;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end -- EXAMPLE