indexing
	description: "Objects that is a straight forward implementation for an `n_body_force_solver' O(n^2)"
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_PARTICLE_SIMULATION_N2 [G -> NUMERIC]

inherit
	EG_PARTICLE_SIMULATION [G]
	
feature {NONE} -- Implementation

	n_body_force_solver (a_particle: EG_PARTICLE): G is
			-- Solve n_nody_force O(n).
		local
			l_item: EG_PARTICLE
		do
			from
				particles.start
			until
				particles.after
			loop
				l_item := particles.item
				if Result = Void then
					Result := n_body_force (a_particle, l_item)
				else
					Result := Result + n_body_force (a_particle, l_item)
				end
				particles.forth
			end
		end
	
end -- class EG_PARTICLE_SIMULATION_N2

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

