note
	description: "Wrapper for cocoa's root class (id)."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

inherit
	NS_OBJECT_BASIC_TYPE
		undefine
			is_equal
		redefine
			copy
		end

	DEBUG_OUTPUT
		redefine
			copy,
			is_equal
		end

	IDENTIFIED
		undefine
			is_equal
		redefine
			copy,
			dispose
		end

create
	share_from_pointer

create {NS_OBJECT, OBJC_CLASS, OBJC_CALLBACK_MARSHAL}
	make_from_pointer,
	make_weak_from_pointer

feature {OBJC_CLASS} -- Initialization

	make_weak_from_pointer (a_ptr: POINTER)
			-- Create a weak reference to a_ptr, the object will neither be retained nor
			-- freed when `Current' is collected
			-- Use with care
 		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
--			do_not_collect := True
		ensure
			item_set: item = a_ptr
		end

	make_from_pointer (a_ptr: POINTER)
			-- Initialize Current assuming the Eiffel code initialized `a_ptr' via an external call.
			-- Use this feature if you alloc'ed the object yourself or are otherwise responsible of freeing it
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
--			proper_reference_counting: {NS_OBJECT_API}.retain_count (a_ptr) = 1
-- 			The retain count doesn't give much information since the framework may retain some of our objects in unpredictable ways
		end

	share_from_pointer (a_ptr: POINTER)
			-- Initialize Current using `a_ptr' assuming `a_ptr' was not created by the Eiffel code.
			-- Use this if you didn't alloc the poitner yourself. This feature will retain the
			-- object so that it will not go away until the eiffel object is garbage collected
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
			{NS_OBJECT_API}.retain (a_ptr)
--			We should make sure that there can only ever be one dual eiffel object for a cocoa object
			check
				eiffel_dual_not_created: callback_marshal.get_eiffel_object (a_ptr) = Void
			end
		ensure
			item_set: item = a_ptr
			--proper_reference_counting: {NS_OBJECT_API}.retain_count (a_ptr) = old {NS_OBJECT_API}.retain_count (a_ptr) + 1
		end

feature -- Access

	class_: OBJC_CLASS
			-- Identifying class
		do
			create Result.make_from_pointer ({NS_OBJECT_API}.class_ (item))
		end

	item: POINTER
			-- Underlying objective-C object

feature -- Operations

	init
			-- Send an init message to 'item'
		do
			item := {NS_OBJECT_API}.init (item)
		end

feature -- Status report

	exists: BOOLEAN
			-- Does current still have its underlying object and thus is usable?
		do
			Result := item /= default_pointer
		end

	debug_output: STRING
			-- A description of the current object - using {NSObject}.description
		local
			l_string: NS_STRING_BASE
		do
			create l_string.share_from_pointer ({NS_OBJECT_API}.description (item))
			Result := l_string
		end

feature -- Obtaining Information About Methods

--	method_signature_for_selector (a_selector: OBJC_SELECTOR): NS_METHOD_SIGNATURE
--			-- Returns an NS_METHOD_SIGNATURE object that contains a description of the method identified by a given selector.
--		do
--			create Result.share_from_pointer ({NS_OBJECT_API}.method_signature_for_selector (a_selector.item))
--		end

feature -- Duplication

	copy (other: like Current)
			-- Make a copy of the underlying Objective-C object
			-- NS_OBJECT does not support this in general but some descendants may do so by inheriting from NS_COPYING.
		do
			check
				cannot_copy_this_class: False
			end
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := {NS_OBJECT_API}.is_equal (item, other.item)
		end

feature {NONE} -- Memory Management

	do_not_collect: BOOLEAN
			-- Flag that indicates that item must not be released when the Eiffel object is
			-- collected

 	dispose
 			-- <Precursor>
 		local
 			l_null: POINTER
 		do
 			Precursor {IDENTIFIED}
			if item /= l_null and not do_not_collect then
--				{NS_OBJECT_API}.release (item)
--				item := l_null
			end
		end

feature {NONE} -- Implementation

	callback_marshal: OBJC_CALLBACK_MARSHAL
			-- A reference to the global Objective-C callback marshaler
		once
			create Result
		end

end
