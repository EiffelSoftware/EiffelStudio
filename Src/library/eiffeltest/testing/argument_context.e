indexing
	description:
		"Argument context facility"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class ARGUMENT_CONTEXT inherit

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Access

	context: like actual_context is
			-- Argument context
		require
			available: is_context_set
		do
			Result := actual_context
		end
		
feature -- Status report

	is_context_set: BOOLEAN is
			-- Is argument context set?
		do
			Result := actual_context /= Void
		end

feature -- Status setting

	set_context (c: ANY) is
			-- Set context to `c'.
		require
			context_exists: c /= Void
		do
			actual_context ?= c
			if actual_context = Void then raise ("Non-conforming argument") end
		ensure
			context_set: context = c
		end

	clear_context is
			-- Clear context.
		do
			actual_context := Void
		ensure
			context_cleared: not is_context_set
		end

feature {NONE} -- Implementation

	actual_context: ANY
			-- Actual context
			-- (To be redefined in subclasses that use the facility.)
invariant

	context_set_definition: is_context_set = (actual_context /= Void)

end -- class ARGUMENT_CONTEXT

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
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
--|----------------------------------------------------------------------
