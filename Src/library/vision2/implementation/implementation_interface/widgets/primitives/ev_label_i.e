indexing
	description: 
		"Eiffel Vision label. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LABEL_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_TEXT_ALIGNABLE_I
		redefine
			interface
		end

	EV_FONTABLE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- implementation

	interface: EV_LABEL	
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
	
end --class EV_LABEL_I

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

