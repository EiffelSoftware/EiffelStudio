indexing
	description:
		"Evaluators for test steps"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EVALUATOR inherit

	CALLBACK
		rename
			callback as test_step, set_callback as set_test_step
		end

feature -- Access

	name: STRING
			-- Name of evaluator

feature -- Status report

	is_setup_ok: BOOLEAN is
			-- Is evaluator set up?
		do
			Result := name /= Void and then not name.is_empty
		end

	is_true: BOOLEAN is
			-- Does evaluator yield true?
		require
			setup_ok: is_setup_ok
		deferred
		end
	 
feature -- Status setting

	set_name (s: STRING) is
			-- Set name to `s'.
		require
			non_empty_name: s /= Void and then not s.is_empty
		do
			name := s
		ensure
			name_set: name = s
		end

end -- class EVALUATOR

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
