indexing
	description: 
		"Eiffel Vision sensitive. Implementation interface."
	status: "See notice at end of class"
	keywords: "sensitive, input"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SENSITIVE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Status report

	user_is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		do
			if not has_parent or else parent_is_sensitive then
				Result := is_sensitive
			end
		end

feature -- Status setting

	user_enable_sensitive is
			-- Make object sensitive to user input.
		do
			internal_non_sensitive := False
			enable_sensitive
		ensure
			is_sensitive_if_parent_sensitive:
				(has_parent and then parent_is_sensitive) implies interface.implementation.is_sensitive
			is_sensitive_if_orphaned: not has_parent implies interface.implementation.is_sensitive
		end

	user_disable_sensitive is
			-- Make object desensitive to user input.
		do
			internal_non_sensitive := True
			disable_sensitive
		ensure
			is_desensitive: not user_is_sensitive
		end

feature {EV_ANY_I} -- Implementation

	enable_sensitive is
			-- Make object sensitive to user input.
		deferred
		end

	disable_sensitive is
			-- Make object desensitive to user input.
		deferred
		end

	parent_is_sensitive: BOOLEAN is
		deferred
		end

	has_parent: BOOLEAN is
		deferred
		end

	internal_non_sensitive: BOOLEAN
		-- Is `Current' not sensitive to input as seen
		-- from `interface'?
		
	is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		deferred
		end

	interface: EV_SENSITIVE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_SENSITIVE_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

