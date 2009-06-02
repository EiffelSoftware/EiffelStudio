note
	description: "Objective-C 2.0 Runtime library. Support for using the dynamic properties of the Objective-C language."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECTIVE_C

feature -- Eiffel interaction

	setup
		do
			connect_callbacks (Current, $callback_bool, $callback_void_ptr)
			create map.make (10000)
		end

	frozen connect_callbacks (a_object: like Current; a_callback_bool: POINTER; a_callback_void_ptr: POINTER)
		external
			"C inline use %"ns_responder_category.h%""
		alias
			"connect_callbacks ($a_object, $a_callback_bool, $a_callback_void_ptr);"
		end

	redefine_method (a_class_name: STRING; a_method_selector: STRING; a_agent: PROCEDURE [ANY, TUPLE]): PROCEDURE [ANY, TUPLE]
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
			old_imp: POINTER
			l_ret: BOOLEAN
			object_table: HASH_TABLE [PROCEDURE [ANY, TUPLE], POINTER]
			type_encoding: STRING
		do
			l_class := objc_get_class ((create {C_STRING}.make (a_class_name)).item)
			-- FIXME: types string and callback_imp currently hardcoded to type (id, sel) -> boolean

			create type_encoding.make_from_string ("@:")
			if attached {FUNCTION [ANY, TUPLE, BOOLEAN]} a_agent as l_function then
				type_encoding.prepend ("b") -- BOOL return type
				l_imp := bridge_bool_address
			elseif attached {ROUTINE [ANY, TUPLE]} a_agent as l_routine then
				type_encoding.prepend ("v")
				l_imp := bridge_void_ptr_address
			else
				-- ERROR
				check
					bridging_not_supported_for_method_signature: False
				end
			end

			l_types := (create {C_STRING}.make (type_encoding)).item
			l_sel := sel_register_name ((create {C_STRING}.make (a_method_selector)).item)

			map.search (l_class)
			if map.found then
				map.found_item.extend (a_agent, l_sel)
			else
				create object_table.make (1000)
				object_table.extend (a_agent, l_sel)
				map.extend (object_table, l_class)
			end

			old_imp := class_get_method_implementation (l_class, l_sel)
			l_imp := class_replace_method (l_class, l_sel, l_imp, l_types)
			Result := agent call_old_imp_void_ptr (old_imp, ?, l_sel, ?)
		end

	call_old_imp_void_ptr (imp: POINTER; a_object, a_selector: POINTER; arg1: POINTER)
		external
			"C inline use %"ns_responder_category.h%""
		alias
			"((void (*) (id, SEL, void*))$imp) ($a_object, $a_selector, $arg1);"
		end

	map: HASH_TABLE [HASH_TABLE [PROCEDURE [ANY, TUPLE], POINTER], POINTER]

	callback_bool (a_object: POINTER; a_selector: POINTER): BOOLEAN
		local
			c_string: C_STRING
			l_agent: FUNCTION [ANY, TUPLE [], BOOLEAN]
		do
			--object_get_class (a_object).to_integer_32.to_integer_64.bit_shift (32).plus (a_selector)
			create c_string.make_by_pointer (object_get_class_name (a_object))
			io.put_string ("B Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N ")
			map.start
			map.item_for_iteration.at (a_selector).call ([])
			l_agent.call ([])
			Result := l_agent.last_result
		end

	callback_void_ptr (a_object: POINTER; a_selector: POINTER; arg1: POINTER): BOOLEAN
		local
			c_string: C_STRING
			l_agent: ROUTINE [ANY, TUPLE [POINTER]]
		do
			create c_string.make_by_pointer (object_get_class_name (a_object))
			io.put_string ("VP Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N ")
			map.start
			l_agent ?= map.item_for_iteration.at (a_selector)
			if l_agent /= void then
				l_agent.call ([arg1])
			end
		end

	frozen bridge_bool_address: POINTER
		external
			"C inline use %"ns_responder_category.h%""
		alias
			"bridge_bool"
		end

	frozen bridge_void_ptr_address: POINTER
		external
			"C inline use %"ns_responder_category.h%""
		alias
			"bridge_void_ptr"
		end

feature -- Contract Support

	types_match (a_agent: PROCEDURE [ANY, TUPLE]; type_encoding: STRING): BOOLEAN
		do

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

	frozen class_add_method (a_class: POINTER; a_sel: POINTER; a_imp: POINTER; a_types: POINTER): BOOLEAN
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return class_addMethod((Class)$a_class, $a_sel, $a_imp, $a_types);"
		end

	frozen class_replace_method (a_class: POINTER; a_sel: POINTER; a_imp: POINTER; a_types: POINTER): POINTER
		external
			"C inline use <objc/objc-class.h>"
		alias
			"return class_replaceMethod((Class)$a_class, $a_sel, $a_imp, $a_types);"
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
