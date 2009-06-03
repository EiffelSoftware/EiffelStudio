note
	description: "Wrapper for cocoa's root class (id)."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

create {NS_OBJECT, OBJC_CLASS}
	make_shared

feature {NS_OBJECT} -- Creation

	make_shared (a_pointer: POINTER)
 			-- For internal use by the framework only
 		require
			a_pointer_not_nil: a_pointer /= nil
			-- FIXME: check if the pointer is valid and points to an NS_OBJECT object!
			-- descendants should also check if the type of the cocoa object is what they need
			objective_c_class_matches_eiffel_class: -- class_ = current.wrapped_class
		do
			item := a_pointer
		end

feature -- Identifying Classes

	class_: OBJC_CLASS
		do
			create Result.make_shared ({NS_OBJECT_API}.class_ (item))
		end

feature -- Constants

	frozen nil: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return nil;"
		end

feature {NS_OBJECT} -- Should be used by classes in native only

	item: POINTER
	 	-- The C-pointer to the Cocoa object

invariant
	cocoa_object_allocated: item /= nil
end
