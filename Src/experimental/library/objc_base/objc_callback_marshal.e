note
	description: "[
		Objective-C 2.0 Runtime library. Support for using the dynamic properties of the Objective-C language.
		This class handles the callbacks from C/Objective-C.
		]"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"



class
	OBJC_CALLBACK_MARSHAL

inherit
	ANY
		redefine
			default_create
		end

	IDENTIFIED_ROUTINES
		export
			{NONE} all
		undefine
			is_equal, copy
		redefine
			default_create
		end

	INTERNAL
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
			connect_callbacks (Current, $callback_void, $callback_bool, $callback_void_ptr, $callback_void_ptr_ptr, $callback_void_general)
		end

feature {OBJC_CLASS} -- Eiffel interaction

	store_mapping (a_class: POINTER; a_selector: POINTER; a_agent: ROUTINE [ANY, TUPLE])
		local
			object_table: HASH_TABLE [ROUTINE [ANY, TUPLE], POINTER]
		do
			selector_to_agent_map.search (a_class)
			if selector_to_agent_map.found and then attached selector_to_agent_map.found_item as l_item then
				l_item.extend (a_agent, a_selector)
			else
				create object_table.make (1000)
				object_table.extend (a_agent, a_selector)
				selector_to_agent_map.extend (object_table, a_class)
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
				selector_to_agent_map.search (l_class.item)
				if selector_to_agent_map.found and then attached selector_to_agent_map.found_item as l_item then
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

feature -- Eiffel interaction

	register_object (a_object: NS_OBJECT)
			-- Registers an Eiffel object so that we can later query for it by Cocoa pointer
		do
			objc_to_eiffel_object_map.force (a_object.object_id, a_object.item)
			-- FIXME: perform cleanup after a number of insertions
		end

	register_object_for_item (a_object: NS_OBJECT; a_item: POINTER)
			-- Registers an Eiffel object so that it will receive callbacks sent to the given Cocoa Object
		do
			objc_to_eiffel_object_map.force (a_object.object_id, a_item)
			-- FIXME: perform cleanup after a number of insertions
		end

	get_eiffel_object (a_ptr: POINTER): detachable NS_OBJECT
			-- Given a pointer to the Objective-C object, returns a reference to the associated Eiffel object
		do
			objc_to_eiffel_object_map.search (a_ptr)
			if objc_to_eiffel_object_map.found then
				Result ?= eif_id_object (objc_to_eiffel_object_map.found_item)
			end
		end

feature {NONE}

	callback_void (a_object: POINTER; a_selector: POINTER): BOOLEAN
		do
			if attached {FUNCTION [ANY, TUPLE [], BOOLEAN]} get_agent (a_object, a_selector) as l_agent then
				Result := l_agent.item (Void)
			end
		end

	callback_bool (a_object: POINTER; a_selector: POINTER): BOOLEAN
--		local
--			c_string: C_STRING
		do
--			create c_string.make_by_pointer ({NS_OBJC_RUNTIME}.object_get_class_name (a_object))
--			io.put_string ("B Callback with object and selector: " + a_object.out + "  " + a_selector.out + "    type: " + c_string.string + "%N")
			if attached {FUNCTION [ANY, TUPLE [], BOOLEAN]} get_agent (a_object, a_selector) as l_agent then
				Result := l_agent.item (Void)
			end
		end

	callback_void_ptr (a_object: POINTER; a_selector: POINTER; arg1: POINTER): BOOLEAN
		do
			if attached {ROUTINE [ANY, TUPLE [POINTER]]} get_agent (a_object, a_selector) as l_agent then
				if attached {NS_WINDOW} get_eiffel_object (a_object) as obj then
					l_agent.set_target (obj)
				end
				l_agent.call ([arg1])
			end
		end

	callback_void_ptr_ptr (a_object: POINTER; a_selector: POINTER; arg1: POINTER; arg2: POINTER): BOOLEAN
		do
			if attached {ROUTINE [ANY, TUPLE [POINTER]]} get_agent (a_object, a_selector) as l_agent then
				l_agent.call ([arg1, arg2])
			end
		end

	callback_void_rect (a_object: POINTER; a_selector: POINTER; arg1: POINTER): BOOLEAN
			-- FIXME: how should a NSRect be transfered/copied?
		do
			if attached {ROUTINE [ANY, TUPLE [POINTER]]} get_agent (a_object, a_selector) as l_agent then
				l_agent.call ([arg1])
			end
		end

	callback_void_general (a_object: POINTER; a_selector: POINTER; args: POINTER; nargs: INTEGER): BOOLEAN
		local
			args_managed: MANAGED_POINTER
			arg: TUPLE
			type: STRING
		do
			debug ("callbacks")
				io.put_string ("Callback '" + (create {OBJC_SELECTOR}.make_from_pointer (a_selector)).name + "'%N")
			end
			if attached {ROUTINE [ANY, TUPLE]} get_agent (a_object, a_selector) as l_agent then
				if attached get_eiffel_object (a_object) as target then
					if attached target.class_.instance_method (a_selector) as method then
						debug ("callbacks")
							io.put_string ("  no-args: " + method.argument_count.out + "  " + nargs.out + "%N")
						end
					else
						check selector_not_found: False end
					end

					debug ("callbacks")
						io.put_string ("  -> target object: " + target.generator + " (id: " + target.object_id.out + ", item: " + target.item.out + ")%N")
					end
					l_agent.set_target (target)
				else
					check
						target_object_not_registered: False
						-- Register the Eiffel-object by calling register_object.
					end
				end
				if nargs > 2 then
					create args_managed.own_from_pointer (args, nargs*4)
					type := l_agent.empty_operands.generating_type.name
					if type.is_equal ("TUPLE [!NS_RECT]") or type.is_equal ("TUPLE [NS_RECT]") then
						arg := [create {NS_RECT}.make_by_pointer (args_managed.read_pointer (0))]
					elseif type.is_equal ("TUPLE [!NS_OBJECT]") or type.is_equal ("TUPLE [NS_OBJECT]") then
--						debug ("callbacks")
--							io.put_string ("  -> argument1: " + argX.class_.name + ": " + argX.debug_output + "%N")
--						end
						arg := [create {NS_OBJECT}.share_from_pointer (args_managed.read_pointer (0))]
					elseif type.is_equal ("TUPLE [!NS_EVENT]") or type.is_equal ("TUPLE [NS_EVENT]") then
						arg := [create {NS_EVENT}.share_from_pointer (args_managed.read_pointer (0))]
					else
						arg := [args_managed.read_pointer (0)]
					end
					l_agent.call (arg)
				else
					create arg.default_create
					l_agent.call (arg)
				end
			end
		end

feature -- Contract Support

	types_match (a_agent: PROCEDURE [ANY, TUPLE]; type_encoding: STRING): BOOLEAN
			-- Check if a_agent m
		do

		end

feature {NONE} -- Implementation

	selector_to_agent_map: HASH_TABLE [HASH_TABLE [ROUTINE [ANY, TUPLE], POINTER], POINTER]
			-- Maps to store an eiffel agent per selector for a class
		note
			once_status: global
		once
			create Result.make (10000)
		end

	objc_to_eiffel_object_map: HASH_TABLE [INTEGER, POINTER]
		once
			create Result.make (1000)
		end

feature {NONE} -- Externals, Initialization

	frozen connect_callbacks (a_object: like Current; a_callback_void: POINTER; a_callback_bool: POINTER;
					a_callback_void_ptr: POINTER; a_callback_void_ptr_ptr: POINTER; a_callback_void_general: POINTER)
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"connect_callbacks ($a_object, $a_callback_void, $a_callback_bool, $a_callback_void_ptr, $a_callback_void_ptr_ptr, $a_callback_void_general);"
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

	frozen bridge_void_general_address: POINTER
		external
			"C inline use %"objc_callback_marshal.h%""
		alias
			"bridge_void_general"
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
