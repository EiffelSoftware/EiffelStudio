note
	description: "Summary description for {NS_OBJC_RUNTIME}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJC_RUNTIME

feature -- Working with Classes

	frozen class_get_name (a_class: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) class_getName((Class)$a_class);"
		end

	frozen class_get_method_implementation (a_class, a_sel: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_getMethodImplementation((Class)$a_class, (SEL) $a_sel);"
		end

	frozen class_get_superclass (a_class: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_getSuperclass((Class)$a_class);"
		end

	frozen class_add_protocol (a_class: POINTER; a_protocol: POINTER): BOOLEAN
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_addProtocol((Class)$a_class, (Protocol *) $a_protocol);"
		end

feature -- Conformance

	frozen class_conformsToProtocol (a_class: POINTER; a_protocol: POINTER): BOOLEAN
		external
			"C inline use <objc/runtime.h>"
		alias
			"return EIF_TEST(class_conformsToProtocol((Class) $a_class, (Protocol *) $a_protocol));"
		end

feature -- Adding Classes

	frozen objc_allocate_class_pair (a_superclass: POINTER; a_name: POINTER; a_extra_bytes: INTEGER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return objc_allocateClassPair((Class)$a_superclass, $a_name, $a_extra_bytes);"
		end

	frozen objc_register_class_pair (a_class: POINTER)
		external
			"C inline use <objc/runtime.h>"
		alias
			"objc_registerClassPair((Class)$a_class);"
		end

	frozen class_add_method (a_class: POINTER; a_sel: POINTER; a_imp: POINTER; a_types: POINTER): BOOLEAN
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_addMethod((Class)$a_class, $a_sel, $a_imp, $a_types);"
		end

	frozen class_replace_method (a_class: POINTER; a_sel: POINTER; a_imp: POINTER; a_types: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_replaceMethod((Class)$a_class, $a_sel, $a_imp, $a_types);"
		end

feature -- Instantiating Classes

	frozen class_create_instance (a_class: POINTER; a_extra_bytes: INTEGER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_createInstance((Class)$a_class, $a_extra_bytes);"
		end

feature -- Working with Instances

	frozen object_get_class (a_object: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return object_getClass((id)$a_object);"
		end

	frozen object_get_class_name (a_object: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) object_getClassName((id)$a_object);"
		end

feature -- Obtaining Class Definitions

	frozen objc_get_class (a_name: POINTER): POINTER
			-- Returns the class definition of a specified class.
		external
			"C inline use <objc/runtime.h>"
		alias
			"return objc_getClass($a_name);"
		end

feature -- Sending Messages

	frozen objc_msg_send (a_receiver: POINTER; a_selector: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return objc_msgSend((id)$a_receiver, $a_selector);"
		end

feature -- Working with Selectors

	frozen sel_register_name (a_name: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return sel_registerName($a_name);"
		end

end
