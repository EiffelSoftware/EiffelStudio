note
	description: "Objective-C 2.0 Runtime library. Support for using the dynamic properties of the Objective-C language."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECTIVE_C

feature -- Eiffel interaction

	redefine_method (a_class_name: STRING; a_method_selector: STRING; a_agent: PROCEDURE [ANY, TUPLE])
			-- Replace a method in an objective-c class by a_agent
			-- This can be dangerous as the method is replaced for all objects which are instances of that class
			-- even those that were created before this call.
		require
			-- class exists
			-- opt: class has selector
			-- Signature of a_method  <=>  Signature of eiffel agent
		local
			l_class: POINTER
			l_types: POINTER
			l_sel: POINTER
			l_imp: POINTER
		do
			l_class := objc_get_class ((create {C_STRING}.make (a_class_name)).item)

			l_types := (create {C_STRING}.make ("b@:")).item
			l_sel := sel_register_name ((create {C_STRING}.make (a_method_selector)).item)
			l_imp := {NS_OBJECT}.nil -- get the implementation that handles l_types
			class_add_method (l_class, l_sel, l_imp, l_types)

			objc_register_class_pair (l_class)
--			make_shared (class_create_instance (l_class, 0))
--			view_init (item)
		end

feature -- Working with Classes

	frozen class_get_method_implementation (a_class, a_sel: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return class_getMethodImplementation((Class)$a_class, (SEL) $a_sel);"
		end

feature -- Adding Classes

	frozen objc_get_class (a_name: POINTER): POINTER
			-- Returns the class definition of a specified class.
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return objc_getClass($a_name);"
		end

	frozen objc_allocate_class_pair (a_superclass: POINTER; a_name: POINTER; a_extra_bytes: INTEGER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return objc_allocateClassPair((Class)$a_superclass, $a_name, $a_extra_bytes);"
		end

	frozen objc_register_class_pair (a_class: POINTER)
		external
			"C inline use <objc/objc-class.h>"
		alias
			"objc_registerClassPair((Class)$a_class);"
		end

	frozen class_add_method (a_class: POINTER; a_sel: POINTER; a_imp: POINTER; a_types: POINTER)
		external
			"C inline use <objc/objc-class.h>"
		alias
			"class_addMethod((Class)$a_class, $a_sel, $a_imp, $a_types);"
		end

	frozen class_create_instance (a_class: POINTER; a_extra_bytes: INTEGER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return class_createInstance((Class)$a_class, $a_extra_bytes);"
		end

feature -- Working with Instances

	frozen object_get_class (a_object: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return object_getClass((id)$a_object);"
		end

	frozen object_get_class_name (a_object: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return object_getClassName((id)$a_object);"
		end

feature -- Sending Messages

	frozen objc_msg_send (a_receiver: POINTER; a_selector: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return objc_msgSend((id)$a_receiver, $a_selector);"
		end

feature -- Working with Selectors

	frozen sel_register_name (a_name: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return sel_registerName($a_name);"
		end

end
