indexing
	description:
		"EiffelVision assignment attempt class"

class
	ASSIGN_ATTEMPT [G]

create
	default_create

feature -- Access

	attempt (an_object: ANY): G is
		-- Attempt to return an object of type `G' from `an_object'
		do
			Result := generize (an_object)
		end

feature {NONE} -- External

	generize (an_object: ANY): G is
		external
			"C (EIF_OBJECT): EIF_REFERENCE| <disptchr.h>"
		end
		
end -- class ASSIGN_ATTEMPT

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
