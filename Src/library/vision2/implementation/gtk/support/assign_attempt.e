indexing
	description:
		"EiffelVision assignment attempt class"

class
	ASSIGN_ATTEMPT [G]

feature -- Access

	attempt (an_object: ANY): G is
		-- Attempt to return an object of type `G' from `an_object'
		do
			Result := generize ($an_object)
		end

feature {NONE} -- External

	generize (an_object: POINTER): G is
		external
			"C macro signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_eiffel.h%""
		alias
			" "
		end

end -- class ASSIGN_ATTEMPT

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

