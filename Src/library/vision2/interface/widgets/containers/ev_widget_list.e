indexing
	description: 
		"Multiple widget container accessible as a list."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WIDGET_LIST

inherit
	EV_CONTAINER
		undefine
			extend,
			prune_all,
			put,
			replace,
			item,
			initialize,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_DYNAMIC_LIST [EV_WIDGET]
		redefine
			implementation,
			is_in_default_state
		select
			put,
			set_extend
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINER} and Precursor {EV_DYNAMIC_LIST}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_WIDGET_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_WIDGET_LIST

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
