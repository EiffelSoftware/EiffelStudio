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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

