indexing
	description: "Declare an interface through which %
				  %flyweights can receive and act %
				  %on extrinsic state."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	FLYWEIGHT[G,H]

feature -- Initialization

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

end -- class FLYWEIGHT
