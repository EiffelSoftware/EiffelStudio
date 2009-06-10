note
	description: "Wrapper for cocoa's root class (id)."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

inherit
	DISPOSABLE

create {NS_OBJECT, OBJC_CALLBACK_MARSHAL}
	share_from_pointer
create {OBJC_CLASS, OBJC_CALLBACK_MARSHAL}
	make_from_pointer

feature {NS_OBJECT} -- Creation

	make_from_pointer (a_ptr: POINTER)
			-- Initialize Current assuming the Eiffel code initialized `a_ptr' via an external call.
			-- For internal use by the framework only
 		require
			a_ptr_not_null: a_ptr /= default_pointer
			-- FIXME: check if the pointer is valid and points to an NS_OBJECT object!
			-- descendants should also check if the type of the cocoa object is what they need
			objective_c_class_matches_eiffel_class: -- class_ = current.wrapped_class
		do
			item := a_ptr
		ensure
			item_set: item = a_ptr
			--proper_reference_counting: {NS_OBJECT_API}.retain_count (a_ptr) = 1
		end

feature {NONE} -- Creation

	share_from_pointer (a_ptr: POINTER)
			-- Initialize Current using `a_ptr' assuming `a_ptr' was not created by the Eiffel code.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
			--{NS_OBJECT_API}.retain (a_ptr)
		ensure
			item_set: item = a_ptr
			--proper_reference_counting: {NS_OBJECT_API}.retain_count (a_ptr) = old {NS_OBJECT_API}.retain_count (a_ptr) + 1
		end

feature -- Identifying Classes

	class_: OBJC_CLASS
		do
			create Result.make_from_pointer ({NS_OBJECT_API}.class_ (item))
		end

feature -- Constants

	frozen nil: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return nil;"
		end

feature -- Removal

	dispose
			-- <Precursor>
		do
			if item /= default_pointer then
				{NS_OBJECT_API}.release (item)
				item := default_pointer
			end
		end

feature {NS_OBJECT} -- Should be used by classes in native only

	item: POINTER
	 	-- The C-pointer to the Cocoa object

invariant
--	cocoa_object_allocated: item /= nil
end
