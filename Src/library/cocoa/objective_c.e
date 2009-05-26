note
	description: "Objective-C 2.0 Runtime library. Support for using the dynamic properties of the Objective-C language."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECTIVE_C

feature -- Working with Classes

	frozen class_get_method_implementation (a_class, a_sel: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return class_getMethodImplementation((Class)$a_class, (SEL) $a_sel);"
		end

feature -- Adding Classes

	frozen objc_get_class (a_name: POINTER): POINTER
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
