indexing
	description: "Declare an interface through which %
				  %flyweights can receive and act %
				  %on extrinsic state."
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

end -- class FLYWEIGHT


--|----------------------------------------------------------------
--| EiffelPatterns: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

