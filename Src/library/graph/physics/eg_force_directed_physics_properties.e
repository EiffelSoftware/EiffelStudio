indexing
	description: "Objects that holds common properties for EG_SPRING_ENERGY and EG_SPRING_PARTICLE."
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

end -- class EG_FORCE_DIRECTED_PHYSICS_PROPERTIES

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

