indexing
	description:
		"Callback objects"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class 
	CALLBACK

create
	
	-- Not for instantiaton

feature {NONE} -- Initialization

	make (r: like callback) is
			-- Create callback to `r'.
		require
			non_void_reference: r /= Void
		do
			set_callback (r)
		ensure
			reference_set: callback = r
		end
		
feature -- Status setting

	set_callback (r: like callback) is
			-- Set callback to `r'.
		require
			non_void_reference: r /= Void
		do
			callback := r
		ensure
			reference_set: callback = r
		end

feature {NONE} -- Implementation

	callback: ANY
			-- Reference to callback object

end -- class CALLBACK

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
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
