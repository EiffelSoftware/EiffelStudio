indexing
	description:
		"Singleton instance of format factory"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	FORMAT_FACTORY

feature {NONE} -- Initialization

	format_factory: HASHED_PROTOTYPE_FACTORY [LOG_OUTPUT_FORMAT] is
			-- Format factory singleton
		local
			f: LOG_OUTPUT_FORMAT
		once
			create Result.make
			Result.enable_cloning
			create {TEXT_LOG} f
			Result.extend (f, "ascii")
		ensure
			not_empty: Result /= Void and then not Result.empty
		end

end -- class FORMAT_FACTORY

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
