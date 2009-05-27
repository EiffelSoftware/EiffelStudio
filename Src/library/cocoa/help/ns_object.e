note
	description: "Wrapper for cocoa's root class (id)."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

create {NS_OBJECT}
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

	class_: POINTER
		do
			Result := object_class (item)
		end

feature -- Constants

	font_attribute_name: NS_STRING
		once
			create Result.make_shared (ns_font_attribute_name)
		ensure
			Result /= void
		end

	frozen ns_font_attribute_name: POINTER
			-- NSFontAttributeName
			-- TODO Not sure where this should go
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSFontAttributeName;"
		end

	frozen nil: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return nil;"
		end

feature {NONE} -- Shared functionality

	frozen target_new (a_object: POINTER; a_method: POINTER): POINTER
		external
			"C inline use %"actions.h%""
		alias
			"return [[SelectorWrapper new] initWithCallbackObject: $a_object andMethod: $a_method];"
		end

	frozen object_class (a_object: POINTER): POINTER
		external
			"C inline use %"actions.h%""
		alias
			"return [(NSObject*)$a_object class];"
		end

feature {NS_OBJECT} -- Should be used by classes in native only

	item: POINTER
	 	-- The C-pointer to the Cocoa object

invariant
	cocoa_object_allocated: item /= nil
end
