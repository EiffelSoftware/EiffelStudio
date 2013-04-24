note
	description: "Objects that is a straight forward implementation for an `n_body_force_solver' O(n^2)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_PARTICLE_SIMULATION_N2 [G -> NUMERIC]

inherit
	EG_PARTICLE_SIMULATION [G]

feature {NONE} -- Implementation

	n_body_force_solver (a_particle: EG_PARTICLE): G
			-- Solve n_nody_force O(n).
		local
			l_item: EG_PARTICLE
			l_result: detachable like n_body_force_solver
		do
			from
				particles.start
			until
				particles.after
			loop
				l_item := particles.item
				if l_result = Void then
					l_result := n_body_force (a_particle, l_item)
				else
					l_result := l_result + n_body_force (a_particle, l_item)
				end
				particles.forth
			end
			check l_result /= Void end -- FIXME: Implied by ...
			Result := l_result
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EG_PARTICLE_SIMULATION_N2

