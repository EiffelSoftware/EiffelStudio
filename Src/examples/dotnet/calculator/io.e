indexing
	description: "Manages I/O."
	external_name: "ISE.Examples.Calculator.IO"

class
	IO

feature -- Access

	out: CONSOLE is
		indexing
			description: "Console object"
			external_name: "Out"
		do
			create Result
		ensure
			console_object_created: Result /= Void
		end

end -- class IO

--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
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

