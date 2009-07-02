note
	description: "[
		Objective-C 2.0 Runtime library. Support for using the dynamic properties of the Objective-C language.
		This class handles the callbacks from C/Objective-C.
		]"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"



class
	OBJC_CALLBACK_MARSHAL

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create the dispatcher, one object per system.
		do
			initialize
		end

	initialize
			-- Initialize callbacks - only once
		note
			once_status: global
		once
			connect_callbacks (Current, $callback_void, $callback_bool, $callback_void_ptr, $callback_void_ptr_ptr)
		end

feature {OBJC_CLASS} -- Eiffel interaction

	store_mapping (a_class: POINTER; a_selector: POINTER; a_agent: ROUTINE [ANY, TUPLE])
		local
			object_table: HASH_TABLE [ROUTINE [ANY, TUPLE], POINTER]
		do
			map.search (a_class)
			if map.found and then attached map.found_item as l_item then
				l_item.extend (a_agent, a_selector)
			else
				create object_table.make (1000)
				object_table.extend (a_agent, a_selector)
				map.extend (object_table, a_class)
			end
		end

	get_agent (a_object: POINTER; a_selector: POINTER): detachable ROUTINE [ANY, TUPLE]
		local
			l_object: NS_OBJECT
			l_class: detachable OBJC_CLASS
		do
			create l_object.share_from_pointer (a_object)
			from
				l_class := l_object.class_
			until
				l_class = void or Result /= void
			loop
				map.search (l_class.item)
				if map.found and then attached map.found_item as l_item then
					l_item.search (a_selector)
					if l_item.found then
						Result := l_item.found_item
					end
				end
				l_class := l_class.superclass
			end
			check
				Result /= void
			end
		ensure
			Result /= void
		end

feature {NONE}

	callback_void (a_object: POINTER; a_selector: POINTER): BOOLEAN
		local
			c_string: C_STRING
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			if attached {FUNCTION [ANY, TUPLE [], BOOLEAN]} get_agent (a_object, a_selector) as l_agent then
				Result := l_agent.item (Void)
			end
		end

	callback_bool (a_object: POINTER; a_selector: POINTER): BOOLEAN
		local
			c_string: C_STRING
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			--io.put_string ("B Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N")
			if attached {FUNCTION [ANY, TUPLE [], BOOLEAN]} get_agent (a_object, a_selector) as l_agent then
				Result := l_agent.item (Void)
			end
		end

	callback_void_ptr (a_object: POINTER; a_selector: POINTER; arg1: POINTER): BOOLEAN
		local
			c_string: C_STRING
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			--io.put_string ("VP Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N")
			if attached {ROUTINE [ANY, TUPLE [POINTER]]} get_agent (a_object, a_selector) as l_agent then
				l_agent.call ([arg1])
			end
		end

	callback_void_ptr_ptr (a_object: POINTER; a_selector: POINTER; arg1: POINTER; arg2: POINTER): BOOLEAN
		local
			c_string: C_STRING
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			if attached {ROUTINE [ANY, TUPLE [POINTER]]} get_agent (a_object, a_selector) as l_agent then
				l_agent.call ([arg1, arg2])
			end
		end

	callback_void_rect (a_object: POINTER; a_selector: POINTER; arg1: POINTER): BOOLEAN
			-- FIXME: how should a NSRect be transfered/copied?
		local
			c_string: C_STRING
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			if attached {ROUTINE [ANY, TUPLE [POINTER]]} get_agent (a_object, a_selector) as l_agent then
				l_agent.call ([arg1])
			end
		end

feature -- Contract Support

	types_match (a_agent: PROCEDURE [ANY, TUPLE]; type_encoding: STRING): BOOLEAN
			-- Check if a_agent m
		do

		end

feature {NONE} -- Implementation

	map: HASH_TABLE [HASH_TABLE [ROUTINE [ANY, TUPLE], POINTER], POINTER]
			-- Maps to store an eiffel agent per selector for a class
		note
			once_status: global
		once
			create Result.make (10000)
		end

feature {NONE} -- Externals, Initialization

	frozen connect_callbacks (a_object: like Current; a_callback_void: POINTER; a_callback_bool: POINTER;
					a_callback_void_ptr: POINTER; a_callback_void_ptr_ptr: POINTER)
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"connect_callbacks ($a_object, $a_callback_void, $a_callback_bool, $a_callback_void_ptr, $a_callback_void_ptr_ptr);"
		end

feature {OBJC_CLASS} -- Externals, Get addresses of the C bridge functions

	frozen bridge_bool_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_bool"
		end

	frozen bridge_void_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_void"
		end

	frozen bridge_void_ptr_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_void_ptr"
		end

	frozen bridge_void_ptr_ptr_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_void_ptr_ptr"
		end

--	frozen bridge_void_rect_address: POINTER
--		external
--			"C inline use %"objc_callback_marshal.h%""
--		alias
--			"bridge_void_rect"
--		end

feature {OBJC_CLASS} -- Externals, to be able to call the superclass or previous definition

	call_old_imp_void_ptr (imp: POINTER; a_object, a_selector: POINTER; arg1: POINTER)
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"((void (*) (id, SEL, void*))$imp) ($a_object, $a_selector, $arg1);"
		end

end
