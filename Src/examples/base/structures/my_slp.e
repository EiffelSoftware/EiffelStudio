indexing

	description: "Demo class for SLP_QUEUE %
		% Only one feature added: display"

class MY_SLP 

inherit
	LINKED_PRIORITY_QUEUE [INTEGER]
		rename
			make as lpq_make
		end

create
	make

feature -- Creation

	make is
		do
			io.set_error_default
			lpq_make
		end

feature -- Routine

	display is
		do
			from
				start
			until
				offright
			loop
				io.putint (sorted_list_item.item)
				io.putstring (" ")
				forth
			end
		end

end -- class MY_SLP

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

