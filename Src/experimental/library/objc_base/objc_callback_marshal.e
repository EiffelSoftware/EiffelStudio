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
			connect_callbacks (Current, $callback_bool, $callback_void_ptr)
		end

feature {OBJC_CLASS} -- Eiffel interaction

	store_mapping (a_class: POINTER; a_selector: POINTER; a_agent: ROUTINE [ANY, TUPLE])
		local
			object_table: HASH_TABLE [ROUTINE [ANY, TUPLE], POINTER]
		do
			map.search (a_class)
			if map.found then
				map.found_item.extend (a_agent, a_selector)
			else
				create object_table.make (1000)
				object_table.extend (a_agent, a_selector)
				map.extend (object_table, a_class)
			end
		end

	get_agent (a_object: POINTER; a_selector: POINTER): ROUTINE [ANY, TUPLE]
		local
			l_object: NS_OBJECT
			l_class: OBJC_CLASS
		do
			create l_object.share_from_pointer (a_object)
			from
				l_class := l_object.class_
			until
				l_class = void or Result /= void
			loop
				map.search (l_class.item)
				if map.found then
					map.found_item.search (a_selector)
					if map.found_item.found then
						Result := map.found_item.found_item
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

	callback_bool (a_object: POINTER; a_selector: POINTER): BOOLEAN
		local
			c_string: C_STRING
			l_agent: FUNCTION [ANY, TUPLE [], BOOLEAN]
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			io.put_string ("B Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N")
			l_agent ?= get_agent (a_object, a_selector)
			l_agent.call ([])
			Result := l_agent.last_result
		end

	callback_void_ptr (a_object: POINTER; a_selector: POINTER; arg1: POINTER): BOOLEAN
		local
			c_string: C_STRING
			l_agent: ROUTINE [ANY, TUPLE [POINTER]]
		do
			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
			io.put_string ("VP Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N")
			l_agent ?= get_agent (a_object, a_selector)
			l_agent.call ([arg1])
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

	frozen connect_callbacks (a_object: like Current; a_callback_bool: POINTER; a_callback_void_ptr: POINTER)
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"connect_callbacks ($a_object, $a_callback_bool, $a_callback_void_ptr);"
		end

feature {OBJC_CLASS} -- Externals, Get addresses of the C bridge functions

	frozen bridge_bool_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_bool"
		end

	frozen bridge_void_ptr_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_void_ptr"
		end

feature {OBJC_CLASS} -- Externals, to be able to call the superclass or previous definition

	call_old_imp_void_ptr (imp: POINTER; a_object, a_selector: POINTER; arg1: POINTER)
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"((void (*) (id, SEL, void*))$imp) ($a_object, $a_selector, $arg1);"
		end

end
