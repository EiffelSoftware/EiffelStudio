indexing
	description: "Objects that shares an instance of scale factories."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_SCALE_FACTORY

feature {NONE} -- Access

	font_factory: EV_SCALED_FONT_FACTORY is
			-- Scaled font factory.
		once
			create Result
		ensure
			Result_not_Void: Result /= Void
		end
		
	pixmap_factory: EV_SCALED_PIXMAP_FACTORY is
			-- Scaled pixmap factory.
		once
			create Result
		ensure
			Result_not_Void: Result /= Void
		end

end -- class EV_SHARED_SCALE_FACTORY

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

