indexing
	description:
		"Control over objects meant to be used within different threads."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_CONTROL

feature -- Basic operations

	freeze (object: ANY) is
			-- Freeze `object'.
		require
			valid_object: object /= Void
		do
			eif_thr_freeze (object)
		end

	unfreeze (object: ANY) is
			-- Unfreeze `object'.
		require
			valid_object: object /= Void
		do
			eif_thr_unfreeze (object)
		end

feature {NONE} -- Externals

	eif_thr_freeze (object: ANY) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_unfreeze (object: ANY) is
		external
			"C | %"hector.h%""
		alias
			"eufreeze"
		end

end -- class OBJECT_CONTROL

--|--------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|--------------------------------------------------------------
