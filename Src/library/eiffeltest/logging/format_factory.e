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
			not_empty: Result /= Void and then not Result.is_empty
		end

end -- class FORMAT_FACTORY

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
