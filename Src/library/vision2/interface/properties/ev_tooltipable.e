indexing
	description:
		"Abstraction for objects that have a tooltip property."
	status: "See notice at end of class"
	keywords: "tooltip, popup, hint"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TOOLTIPABLE

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end
	
feature -- Access

	tooltip: STRING is
			-- Tooltip displayed on `Current'.
		do
			Result := implementation.tooltip
		ensure
			bridge_ok: (Result = Void and implementation.tooltip = Void) or
				Result.is_equal (implementation.tooltip)
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			tooltip: a_tooltip /= Void
		do
			implementation.set_tooltip (a_tooltip)
		ensure
			tooltip_assigned: a_tooltip.is_equal (tooltip) and tooltip /= a_tooltip
		end

	remove_tooltip is
			-- Make `tooltip' `Void'.
		do
			implementation.remove_tooltip
		ensure
			tooltip_removed: tooltip = Void
		end

feature {EV_TOOLTIPABLE_I} -- Implementation
	
	implementation: EV_TOOLTIPABLE_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_TOOLTIPABLE

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
