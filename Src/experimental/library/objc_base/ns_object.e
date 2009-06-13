note
	description: "Wrapper for cocoa's root class (id)."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

inherit
	DISPOSABLE

create
	share_from_pointer

create {NS_OBJECT, OBJC_CLASS, OBJC_CALLBACK_MARSHAL}
	make_from_pointer

feature {NONE} -- Initialization

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
			proper_reference_counting: {NS_OBJECT_API}.retain_count (a_ptr) = 1
		end

	share_from_pointer (a_ptr: POINTER)
			-- Initialize Current using `a_ptr' assuming `a_ptr' was not created by the Eiffel code.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
			{NS_OBJECT_API}.retain (a_ptr)
		ensure
			item_set: item = a_ptr
			proper_reference_counting: {NS_OBJECT_API}.retain_count (a_ptr) = old {NS_OBJECT_API}.retain_count (a_ptr) + 1
		end

feature -- Access

	class_: OBJC_CLASS
			-- Identifying class
		do
			create Result.make_from_pointer ({NS_OBJECT_API}.class_ (item))
		end

	item: POINTER
			-- Underlying objective-C object

feature -- Status report

	exists: BOOLEAN
			-- Does current still have its underlying object and thus is usable?
		do
			Result := item /= default_pointer
		end

feature -- Removal

	dispose
			-- <Precursor>
		local
			l_null: POINTER
		do
			if item /= l_null then
				{NS_OBJECT_API}.release (item)
				item := l_null
			end
		end

feature {NS_OBJECT} -- Should be used by classes in native only

end
