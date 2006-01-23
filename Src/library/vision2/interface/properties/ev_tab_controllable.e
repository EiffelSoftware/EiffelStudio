indexing
	description:
		"Abstraction for objects that may have their ability to be tabbed to enabled/disabled."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TAB_CONTROLLABLE

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature -- Status report

	is_tabable_to: BOOLEAN is
			-- Is Current able to be tabbed to?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_tabable_to
		end

	is_tabable_from: BOOLEAN is
			-- Is Current able to be tabbed from?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_tabable_from
		end

feature -- Status setting

	enable_tabable_to is
			-- Make `is_tabable_to' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_tabable_to
		ensure
			is_tabable_to: is_tabable_to
		end

	disable_tabable_to is
			-- Make `is_tabable_to' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_tabable_to
		ensure
			not_is_tabable_to: not is_tabable_to
		end

	enable_tabable_from is
			-- Make `is_tabable_from' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_tabable_from
		ensure
			is_tabable_from: is_tabable_from
		end

	disable_tabable_from is
			-- Make `is_tabable_from' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_tabable_from
		ensure
			not_is_tabable_from: not is_tabable_from
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
	
	implementation: EV_TAB_CONTROLLABLE_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_TAB_CONTROLLABLE

