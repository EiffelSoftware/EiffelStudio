indexing
	description:
		"EiffelVision tool-bar separator, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_SEPARATOR_I

inherit
	EV_SEPARATOR_ITEM_I
		redefine
			parent_imp
--			top_parent_imp
		end

feature -- Access

	parent_imp: EV_TOOL_BAR_IMP
			-- Parent implementation

--	top_parent_imp: EV_TOOL_BAR_IMP is
--			-- Top item holder containing the current item.
--		do
--			Result ?= {EV_SEPARATOR_ITEM_I} Precursor
--		end

end -- class EV_TOOL_BAR_SEPARATOR_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
