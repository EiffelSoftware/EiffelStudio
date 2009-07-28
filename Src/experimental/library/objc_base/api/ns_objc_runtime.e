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

	frozen class_add_method (a_class: POINTER; a_sel: POINTER; a_imp: POINTER; a_types: POINTER): BOOLEAN
			-- BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
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

	frozen class_get_instance_method (a_class: POINTER; a_selector: POINTER): POINTER
			-- Method class_getInstanceMethod(Class aClass, SEL aSelector)
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_getInstanceMethod((Class)$a_class, (SEL) $a_selector);"
		end

	frozen class_copy_ivar_list (a_class: POINTER; a_count: TYPED_POINTER [NATURAL_32]): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"[
				Ivar *result;
				unsigned int l_count = 0;
				
				result = class_copyIvarList((Class)$a_class, &l_count);
				*(EIF_NATURAL_32 *) $a_count = l_count;
				return result;
			]"
		end

	frozen class_copy_method_list (a_class: POINTER; a_count: TYPED_POINTER [NATURAL_32]): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"[
				Method *result;
				unsigned int l_count = 0;
				
				result = class_copyMethodList((Class)$a_class, &l_count);
				*(EIF_NATURAL_32 *) $a_count = l_count;
				return result;
			]"
		end

	frozen class_copy_property_list (a_class: POINTER; a_count: TYPED_POINTER [NATURAL_32]): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"[
				objc_property_t *result;
				unsigned int l_count = 0;
				
				result = class_copyPropertyList((Class)$a_class, &l_count);
				*(EIF_NATURAL_32 *) $a_count = l_count;
				return result;
			]"
		end

	frozen class_copy_protocol_list (a_class: POINTER; a_count: TYPED_POINTER [NATURAL_32]): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"[
				Protocol **result;
				unsigned int l_count = 0;
				
				result = class_copyProtocolList((Class)$a_class, &l_count);
				*(EIF_NATURAL_32 *) $a_count = l_count;
				return result;
			]"
		end

feature -- Working with methods

	frozen method_name (a_method: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) sel_getName(method_getName((Method) $a_method));"
		end

	frozen method_argument_count (a_method: POINTER): NATURAL_32
		external
			"C inline use <objc/runtime.h>"
		alias
			"return method_getNumberOfArguments((Method) $a_method);"
		end

	frozen method_return_type (a_method, a_cstr: POINTER; a_length: NATURAL_32)
		external
			"C inline use <objc/runtime.h>"
		alias
			"method_getReturnType((Method) $a_method, (char *) $a_cstr, (size_t) $a_length);"
		end

	frozen method_argument_type (a_method: POINTER; a_index: NATURAL_32; a_cstr: POINTER; a_length: NATURAL_32)
		external
			"C inline use <objc/runtime.h>"
		alias
			"method_getArgumentType((Method) $a_method, (unsigned int) $a_index, (char *) $a_cstr, (size_t) $a_length);"
		end

	frozen method_type_encoding (a_method: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) method_getTypeEncoding((Method) $a_method);"
		end

	frozen method_set_implementation(a_method, a_imp: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return method_setImplementation((Method) $a_method, (IMP) $a_imp);"
		end

feature -- Working with properties

	frozen property_name (a_property: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) property_getName((objc_property_t) $a_property);"
		end

	frozen property_attributes (a_property: POINTER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return (EIF_POINTER) property_getAttributes((objc_property_t) $a_property);"
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

feature -- Instantiating Classes

	frozen class_create_instance (a_class: POINTER; a_extra_bytes: INTEGER): POINTER
		external
			"C inline use <objc/runtime.h>"
		alias
			"return class_createInstance((Class)$a_class, $a_extra_bytes);"
		end

feature -- Working with Instances

	frozen object_set_instance_variable (a_object: POINTER; a_name: POINTER; a_value: POINTER)
		external
			"C inline use <objc/runtime.h>"
		alias
			"return object_setInstanceVariable((id)$a_object, $a_name, $a_value);"
		end

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

	frozen sel_get_name (a_selector: POINTER): POINTER
			-- const char* sel_getName(SEL aSelector)
			-- Returns the name of the method specified by a given selector.
		external
			"C inline use <objc/runtime.h>"
		alias
			"return sel_getName($a_selector);"
		end

	frozen sel_get_uid (a_name: POINTER): POINTER
			-- SEL sel_getUid(const char *str)
		obsolete
			"Use sel_register_name instead."
		external
			"C inline use <objc/runtime.h>"
		alias
			"return sel_getUid($a_name);"
		end

	frozen sel_is_equal (a_lhs_sel, a_rhs_sel: POINTER): BOOLEAN
			-- BOOL sel_isEqual(SEL lhs, SEL rhs)
			-- Returns a Boolean value that indicates whether two selectors are equal.
		external
			"C inline use <objc/runtime.h>"
		alias
			"return sel_isEqual($a_lhs_sel, $a_rhs_sel);"
		end

	frozen sel_register_name (a_name: POINTER): POINTER
			-- SEL sel_registerName(const char *str)
			-- Registers a method with the Objective-C runtime system, maps the method name to a selector, and returns the selector value.
		external
			"C inline use <objc/runtime.h>"
		alias
			"return sel_registerName($a_name);"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
