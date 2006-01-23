indexing
	description: 
		"Eiffel Vision tab controlable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "select, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TAB_CONTROLLABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Status report

	is_tabable_to: BOOLEAN is
			-- Is Current able to be tabbed to?
		deferred
		end

	is_tabable_from: BOOLEAN is
			-- Is Current able to be tabbed from?
		deferred
		end

feature -- Status setting

	enable_tabable_to is
			-- Make `is_tabable_to' `True'.
		deferred
		ensure
			is_tabable_to: is_tabable_to
		end

	disable_tabable_to is
			-- Make `is_tabable_to' `False'.
		deferred
		ensure
			not_is_tabable_to: not is_tabable_to
		end

	enable_tabable_from is
			-- Make `is_tabable_from' `True'.
		deferred
		ensure
			is_tabable_from: is_tabable_from
		end

	disable_tabable_from is
			-- Make `is_tabable_from' `False'.
		deferred
		ensure
			not_is_tabable_from: not is_tabable_from
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TAB_CONTROLLABLE;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

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




end -- class EV_TAB_CONTROLLABLE_I

