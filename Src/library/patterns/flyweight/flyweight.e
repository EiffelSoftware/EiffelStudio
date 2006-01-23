indexing
	description: "Declare an interface through which %
				  %flyweights can receive and act %
				  %on extrinsic state."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	FLYWEIGHT[G,H]

feature {FLYWEIGHT_FACTORY} -- Initialization

	initialize(unsh: like unshared;sh: like shared) is
			-- Initialize Current
		require
			not_void: unsh /= Void and sh /= Void
		do
			unshared := unsh
			shared := sh
			initialized := TRUE
		end

feature {FLYWEIGHT_FACTORY} -- Implementation

	unshared: G
		-- Extrinsic state of Current.
	
	shared: H
		-- intrinsic state of Current.
	
	initialized: BOOLEAN
		-- Has Current being initialized ?

invariant
	FLYWEIGHT_consistent: initialized implies shared /= Void and unshared /= Void

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




end -- class FLYWEIGHT


