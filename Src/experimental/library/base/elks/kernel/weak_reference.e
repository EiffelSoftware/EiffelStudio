note
	description: "[
		Abstraction for weak references, i.e. references to object that can still be reclaimed by the GC.
		If the actual generic parameter is expanded, `put' cannot be used as it does not make sense from the user
		point of view.
		]"
	status: "See notice at end of class."
	library: "Free implementation of ELKS library"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEAK_REFERENCE [G]

inherit
	DISPOSABLE
		rename
			dispose as clear
		end

create
	default_create,
	put

feature -- Initialization

	put (v: G)
			-- New weak reference to `v'.
		require
			v_not_void: v /= Void
			not_expanded: not ({G}).is_expanded
		do
			clear
			internal_item := create_weak_reference ($v)
		ensure
			item_set: item = v
		end

feature -- Removal

	clear
			-- Remove existing weak reference.
		do
			if internal_item /= default_pointer then
					-- This guarantees that `G' is not expanded per the precondition of `put'.
				free_weak_reference (internal_item)
				internal_item := default_pointer
			end
		ensure then
			removed: not exists
		end

feature -- Access

	item: detachable G
			-- Current reference if still alive. Void otherwise
		require
			not_expanded: not ({G}).is_expanded
		local
			l_ptr, l_null: POINTER
		do
			l_ptr := internal_item
			if
				l_ptr /= l_null and then
				attached {G} access (l_ptr) as l_result
			then
				Result := l_result
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Is current reference still alive?
		do
			Result := item /= Void
		ensure
			not_present: not Result implies item = Void
		end

feature {NONE} -- Implementation: Status Report

	internal_item: POINTER
			-- Actual reference to the weak reference.

feature {NONE} -- To move to ISE_RUNTIME

	frozen create_weak_reference (a_object: POINTER): POINTER
			-- Given the Eiffel object `a_object', return its weak_reference value.
		external
			"C inline use %"eif_hector.h%""
		alias
			"return eif_create_weak_reference($a_object);"
		end

	frozen free_weak_reference (a_weak_reference: POINTER)
			-- Free the allocated entry for weak reference `a_weak_reference'.
		external
			"C inline use %"eif_hector.h%""
		alias
			"eif_free_weak_reference($a_weak_reference);"
		end

	frozen access (a_weak_reference: POINTER): detachable ANY
			-- Associated Eiffel object if any associated to weak reference `a_weak_reference'.
		external
			"C inline use %"eif_hector.h%""
		alias
			"return eif_access($a_weak_reference);"
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
