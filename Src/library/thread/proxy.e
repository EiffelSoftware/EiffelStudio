indexing
	description:
		"Indirection proxy allowing share of objects between threads, %
		%without having the garbage collectors intercollect each-other."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROXY [SHARED_OBJECT]

inherit
	MEMORY
		redefine dispose end
	OBJECT_CONTROL
	OBJECT_OWNER

feature -- Basic operations

	put (obj: SHARED_OBJECT) is
			-- Make proxy denote `obj'.
		require
			not_void: obj /= Void
		do
			record_owner
			proxy_pointer := set_proxy (freeze (obj))
		ensure
			attached: is_set
		end

	item: SHARED_OBJECT is
			-- Object attached to proxy.
		require
			attached: is_set
		do
			Result := access_proxy (proxy_pointer)
		ensure
			accessed_it: Result /= Void
		end

	is_set: BOOLEAN is
			-- Is the proxy attached to an object?
		do
			Result := proxy_pointer /= default_pointer
		end

feature {NONE} -- Implementation

	proxy_pointer: POINTER
			-- Pointer to attached object.


feature -- Removal

	dispose is
			-- Detach object from proxy.
		do
			if thread_is_owner and is_set then
				dispose_proxy (proxy_pointer)
				proxy_pointer := default_pointer
			end
		end


feature {NONE} -- Externals

	set_proxy (obj: POINTER): POINTER is
			-- Attach `obj' to proxy.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_proxy_set"
		end

	access_proxy (p: POINTER): SHARED_OBJECT is
			-- Retrieve attached object.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_proxy_access"
		end

	dispose_proxy (p: POINTER) is
			-- Release attached  object.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_proxy_dispose"
		end

end -- class PROXY

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
