indexing
	description: "Wrapper of base class System.String providing additional features"

class
	MY_STRING
alias
	"RegistrationService.MyString"

create
	make

feature {NONE} -- Initialization

	make (value: STRING) is
			-- Initialize string with `value'.
		local
			a_internal: STRING
		do
			create a_internal.make (value)
			internal := a_internal
		end

feature -- Access

	is_integer: BOOLEAN is
			-- Is string an integer?
		local
			i: INTEGER
		do
			from
				Result := true
			until
				i >= internal.count or not Result
			loop
				Result := internal.chars (i).isdigit (internal.chars (i))
				i := i + 1
			end
		end

	to_integer: INTEGER is
			-- Convert string to integer
		do
			Result := internal.ToInt32
		end

feature {NONE} -- Implementation

	internal: STRING
			-- Internal string

end -- class STRING
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

