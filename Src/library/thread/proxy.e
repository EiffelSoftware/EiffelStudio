indexing
	description:
		"Indirection proxy allowing share of objects between threads, %
		%without having the garbage collectors intercollect each-other."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROXY [G]

obsolete
	"Not needed anymore since object does not need protection"

create
	make, put

feature {NONE} -- Initialization

	frozen make, frozen put (obj: G) is
			-- Make proxy denote `obj'.
		require
			not_void: obj /= Void
		do
			item := obj
		end

feature	-- Access

	item: G
			-- Object attached to proxy.

feature {NONE} -- Disposal

	dispose is
		do
		end

end -- class PROXY

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

