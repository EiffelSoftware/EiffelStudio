indexing

	description: "Demo class for sets implemented as sorted lists %
		% Only one routine to display the set is added."

class MSLS 

inherit
	TWO_WAY_SORTED_SET [INTEGER] 

create
	make

feature

	display is
		do
			io.set_error_default
			from
				start
			until
				exhausted
			loop
				io.putchar (' ')
				io.putint (item.item)
				forth
			end
		end

end -- class MSLS

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

