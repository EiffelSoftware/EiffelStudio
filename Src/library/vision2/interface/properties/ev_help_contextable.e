indexing
	description:
		"Abstraction for objects that support active help contexts."
	status: "See notice at end of class"
	keywords: "help"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_HELP_CONTEXTABLE

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature -- Access

	help_context: FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT] is
			-- Agent that evaluates to help context sent to help engine when help is requested
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.help_context
		ensure
			bridge_ok: Result = implementation.help_context
		end

feature -- Element change

	set_help_context (an_help_context: like help_context) is
			-- Assign `an_help_context' to `help_context'.
		require
			not_destroyed: not is_destroyed
			an_help_context_not_void: an_help_context /= Void
		do
			implementation.set_help_context (an_help_context)
		ensure
			help_context_assigned: help_context.is_equal (an_help_context)
		end

	remove_help_context is
			-- Remove key press action associated with `EV_APPLICATION.help_key'.
		require
			not_destroyed: not is_destroyed
			help_context_not_void: help_context /= Void
		do
			implementation.remove_help_context
		ensure
			no_help_context: help_context = Void
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_HELP_CONTEXTABLE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_HELP_CONTEXTABLE

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------