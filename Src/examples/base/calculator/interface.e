class 
	INTERFACE

feature

	operator_key: STRING
		-- Letter key associated to an operation.

	associated_command: STATE
		-- Associated state.

	help_message: STRING
		-- Help message.

	set_interface (k, m: STRING; c: STATE) is
			-- Fill out key with `k', command with `c' and message with `m'.
		do
			operator_key := k
			associated_command := c
			help_message := m
		ensure
			operator_key = k
			associated_command = c
			help_message = m
		end; -- set_interface

end -- class INTERFACE

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

