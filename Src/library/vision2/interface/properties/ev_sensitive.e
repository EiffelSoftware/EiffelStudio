indexing
	description:
		"Abstraction for objects that may ignore user input."
	status: "See notice at end of class"
	keywords: "sensitive, sensitivity, input"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SENSITIVE

inherit
	EV_CONTAINABLE
		redefine
			implementation,
			is_in_default_state
		end
	
feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is object sensitive to user input.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.user_is_sensitive
		ensure
			bridge_ok: Result = implementation.user_is_sensitive
		end

feature -- Status setting

	enable_sensitive is
			-- Make object sensitive to user input.
		require
			not_destroyed: not is_destroyed
		do
			implementation.user_enable_sensitive
		ensure
			is_sensitive: (parent = Void or parent_is_sensitive) implies is_sensitive
		end

	disable_sensitive is
			-- Make object non-sensitive to user input.
		require
			not_destroyed: not is_destroyed
		do
			implementation.user_disable_sensitive
		ensure
			is_unsensitive: not is_sensitive
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINABLE} and is_sensitive
		end

	parent_is_sensitive: BOOLEAN is
		local
			sensitive_parent: EV_SENSITIVE
		do
			sensitive_parent ?= parent
			if sensitive_parent /= Void then
				Result := sensitive_parent.is_sensitive
			end
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_SENSITIVE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_SENSITIVE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
