indexing
	description:
		"Abstraction for objects that may be selected."
	status: "See notice at end of class"
	keywords: "select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SELECTABLE

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is object state set as selected.
		require
			is_selectable: is_selectable
		do
			Result := implementation.is_selected
		ensure
			bridge_ok: Result = implementation.is_selected
		end

	is_selectable: BOOLEAN is
			-- May the object be selected
		do
			Result := implementation.is_selectable
		end

feature -- Status setting

	enable_select is
			-- Select the object.
		require
			is_selectable: is_selectable
		do
			implementation.enable_select
		ensure
			is_selected: is_selected
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_SELECTABLE_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_SELECTABLE

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/06/07 17:28:07  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.2.2.2  2000/05/09 22:37:33  king
--| Integrated selectable, is_selectable for list items
--|
--| Revision 1.2.2.1  2000/05/09 20:27:58  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
