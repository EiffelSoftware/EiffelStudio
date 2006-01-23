indexing
	description: "Objects that traverse object graphs starting at the root object in a depth first manner."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Stephanie Balzer"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE
	
inherit
	SED_OBJECT_GRAPH_TRAVERSABLE

feature {NONE} -- Implementation

	new_dispenser: ARRAYED_STACK [ANY] is
			-- Create the dispenser to use for storing visited objects.
		do
			create Result.make (default_size)
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
