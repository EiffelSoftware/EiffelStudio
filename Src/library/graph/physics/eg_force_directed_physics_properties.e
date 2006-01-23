indexing
	description: "Objects that holds common properties for EG_SPRING_ENERGY and EG_SPRING_PARTICLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_FORCE_DIRECTED_PHYSICS_PROPERTIES

feature -- Access

	electrical_repulsion: DOUBLE
			-- Repulsion between particles in the system.
	
	stiffness: DOUBLE
			-- Stiffness of all links connecting particles.
	
	center_x: INTEGER
			-- X position of the center.
			
	center_y: INTEGER
			-- Y position of the center
			
	center_attraction: DOUBLE
			-- Attraction of the center for particles.

feature -- Element change

	set_center_attraction (a_value: DOUBLE) is
			-- Set `center_attraction' to `a_value'.
		require
			valid_value: a_value >= 0.0
		do
			center_attraction := a_value
		ensure
			set: center_attraction = a_value
		end

	set_stiffness (a_value: DOUBLE) is
			-- Set `stiffness' to `a_value'.
		require
			valid_value: a_value >= 0.0
		do
			stiffness := a_value
		ensure
			set: stiffness = a_value
		end

	set_electrical_repulsion (a_value: DOUBLE) is
			-- Set `electrical_repulsion' to `a_value'.
		require
			valid_value: a_value >= 0.0
		do
			electrical_repulsion := a_value
		ensure
			set: electrical_repulsion = a_value
		end
		
	set_center (ax, ay: INTEGER) is
			-- Set `center_x' to `ax' and `center_y' to `ay'.
		do
			center_x := ax
			center_y := ay
		ensure
			set: center_x = ax and center_y = ay
		end
		
feature {NONE} -- Implementation

	link_stiffness (a_link: EG_LINK_FIGURE): DOUBLE is
			-- Striffness of `a_link'.
		do
			Result := 1.0
		end

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




end -- class EG_FORCE_DIRECTED_PHYSICS_PROPERTIES

