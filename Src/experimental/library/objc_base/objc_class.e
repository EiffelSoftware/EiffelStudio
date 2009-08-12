note
	description: "Representation of an Objective-C method at runtime."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_CLASS

inherit
	INTERNAL

	DEBUG_OUTPUT

create
	make_from_pointer,
	make_with_name

feature {NONE} -- Creation

	make_from_pointer (a_pointer: POINTER)
		require
			a_pointer_not_null: a_pointer /= default_pointer
		do
			item := a_pointer
			exists := true
		end

	make_with_name (a_class_name: READABLE_STRING_GENERAL)
			-- Returns the class definition of a specified class.
			-- If a class with the
		require
			a_class_name_not_void: a_class_name /= Void
		local
			cstring: C_STRING
		do
			create cstring.make (a_class_name)
			item := {NS_OBJC_RUNTIME}.objc_get_class (cstring.item)
			if item /= default_pointer then
				exists := true
			else
				item := {NS_OBJC_RUNTIME}.objc_allocate_class_pair (default_pointer, cstring.item, 0)
				exists := false
			end
		end

feature -- High Level Eiffel Interface

	exists: BOOLEAN

	register
		require
			not exists
		do
			{NS_OBJC_RUNTIME}.objc_register_class_pair (item)
			exists := true
		ensure
			exists: exists
		end

	add_method (a_method_selector: STRING; a_agent: ROUTINE [ANY, TUPLE])
			--
		require
			-- The method is not already implemented in the current class (though it may be in a superclass)
		local
			l_sel, l_imp, l_types: POINTER
			l_ret: BOOLEAN
			type_encoding: STRING
		do
			type_encoding := type_encoding_for_agent (a_agent)

			l_types := (create {C_STRING}.make (type_encoding)).item
			l_sel := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make (a_method_selector)).item)

			l_imp := imp_for_type_encoding (type_encoding)

			callback_marshal.store_mapping (item, l_sel, a_agent)

			l_ret := {NS_OBJC_RUNTIME}.class_add_method (item, l_sel, l_imp, l_types)
		end

	replace_method (a_method_selector: STRING; a_agent: ROUTINE [ANY, TUPLE]): PROCEDURE [ANY, TUPLE]
			-- Replace a method in an objective-c class by a_agent and returns the previous method.
			-- This can be dangerous as the method is replaced for all objects which are instances of that class
			-- even those that were created before this call.
		require
			a_agent_not_void: a_agent /= void
			-- class exists
			-- opt: class has selector
			-- Signature of a_method  <=>  Signature of eiffel agent
		local
			l_types: POINTER
			l_sel: POINTER
			l_imp: POINTER
			old_imp: POINTER
			type_encoding: STRING
		do
			type_encoding := type_encoding_for_agent (a_agent)
			l_imp := imp_for_type_encoding (type_encoding)

			l_types := (create {C_STRING}.make (type_encoding)).item
			l_sel := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make (a_method_selector)).item)

			-- Store the mapping (class, sel) -> a_agent
			callback_marshal.store_mapping (item, l_sel, a_agent)

			old_imp := {NS_OBJC_RUNTIME}.class_get_method_implementation (item, l_sel)
			l_imp := {NS_OBJC_RUNTIME}.class_replace_method (item, l_sel, l_imp, l_types)
			Result := agent {OBJC_CALLBACK_MARSHAL}.call_old_imp_void_ptr (old_imp, ?, l_sel, ?)
		end

feature -- Instantiating Classes

	create_instance: NS_OBJECT
			--
		require
			exists
		do
			create Result.make_from_pointer ({NS_OBJC_RUNTIME}.class_create_instance (item, 0))

			-- FIXME - should somehow create the right Eiffel subtype
			-- new_instance_of from INTERNAL
		end

feature -- Introspection

	methods: ARRAYED_LIST [OBJC_METHOD]
			-- List of methods of Current Objective-C class.
		local
			l_ptr: POINTER
			l_count: NATURAL_32
			l_method: OBJC_METHOD
			l_managed_pointer: MANAGED_POINTER
			i, nb: INTEGER_32
		do
			l_ptr := {NS_OBJC_RUNTIME}.class_copy_method_list (item, $l_count)
			check valid_count: l_count <= {INTEGER_32}.max_value.as_natural_32 end
			if l_ptr /= default_pointer then
				nb := l_count.to_integer_32
				create Result.make (nb)
				create l_managed_pointer.own_from_pointer (l_ptr, {PLATFORM}.pointer_bytes * nb)
				from
					i := 0
				until
					i = nb
				loop
					create l_method.make_from_pointer (l_managed_pointer.read_pointer (i * {PLATFORM}.pointer_bytes))
					Result.extend (l_method)
					i := i + 1
				end
			else
				create Result.make (0)
			end
		end

	instance_method (a_selector: POINTER): detachable OBJC_METHOD
			-- The method that corresponds to the implementation of the selector specified by a_selector,
			-- or Void if the specified class or its superclasses do not contain an instance method with the specified selector.
		local
			l_ptr: POINTER
		do
			l_ptr := {NS_OBJC_RUNTIME}.class_get_instance_method (item, a_selector)
			if l_ptr /= default_pointer then
				create Result.make_from_pointer (l_ptr)
			end
		end

	properties: ARRAYED_LIST [OBJC_PROPERTY]
			-- List of properties of Current Objective-C class.
		local
			l_ptr: POINTER
			l_count: NATURAL_32
			l_property: OBJC_PROPERTY
			l_managed_pointer: MANAGED_POINTER
			i, nb: INTEGER_32
		do
			l_ptr := {NS_OBJC_RUNTIME}.class_copy_property_list (item, $l_count)
			check valid_count: l_count <= {INTEGER_32}.max_value.as_natural_32 end
			if l_ptr /= default_pointer then
				nb := l_count.to_integer_32
				create Result.make (nb)
				create l_managed_pointer.own_from_pointer (l_ptr, {PLATFORM}.pointer_bytes * nb)
				from
					i := 0
				until
					i = nb
				loop
					create l_property.make_from_pointer (l_managed_pointer.read_pointer (i * {PLATFORM}.pointer_bytes))
					Result.extend (l_property)
					i := i + 1
				end
			else
				create Result.make (0)
			end
		end

feature -- Access

	method_implementation (a_sel: POINTER): POINTER
			-- Returns the function pointer that would be called if a particular message were sent to an instance of a class.
			-- The function pointer that would be called if [object name] were called with an instance of the class.
			-- class.get_method_implementation may be faster than method.get_implementation(class.get_instance_method(cls, name)).
			-- The function pointer returned may be a function internal to the runtime instead of an actual method implementation.
			-- For example, if instances of the class do not respond to the selector, the function pointer returned will be part of the runtime's message forwarding machinery.
		do
			Result := {NS_OBJC_RUNTIME}.class_get_method_implementation (item, a_sel)
		end

	superclass: detachable OBJC_CLASS
			-- Returns the superclass of a class. Void if Current is a root class.
		local
			l_super: POINTER
		do
			l_super := {NS_OBJC_RUNTIME}.class_get_superclass (item)
			if l_super /= default_pointer then
				create Result.make_from_pointer (l_super)
			end
		end

	set_superclass (a_class: OBJC_CLASS)
		require
			not exists
		do
			-- class_set_superclass should not be called according to apple's documentation. And indeed it does not seem to give the desired results here.
			item := {NS_OBJC_RUNTIME}.objc_allocate_class_pair (a_class.item, (create {C_STRING}.make (name)).item, 0)
		end

	name: STRING_8
			-- Returns the name of a class.
		local
			cstring: C_STRING
		do
			create cstring.make_by_pointer ({NS_OBJC_RUNTIME}.class_get_name (item))
			Result := cstring.string
		end

feature -- Status report

	debug_output: STRING
			-- <Precursor>
		do
			Result := name
		end

feature {NONE} -- Implementation

	type_encoding_for_agent (a_agent: ROUTINE [ANY, TUPLE]): STRING
		local
			pointer: POINTER
			ns_rect: detachable NS_RECT
			type: STRING
		do
			create Result.make_from_string ("@:")
			if attached {FUNCTION [ANY, TUPLE, BOOLEAN]} a_agent as l_function then
				Result.prepend ("b") -- BOOL return type
			elseif attached {ROUTINE [ANY, TUPLE]} a_agent as l_routine then
				-- Command / No return type
				Result.prepend ("v")
				type := l_routine.empty_operands.generating_type.name

				if type.is_equal ("TUPLE") then
					-- No arguments
				elseif type.is_equal ("TUPLE [POINTER]") then
					Result.append ("*")
				elseif type.is_equal ("TUPLE [!NS_OBJECT]") or type.is_equal ("TUPLE [NS_OBJECT]") or
					type.is_equal ("TUPLE [!NS_EVENT]") or type.is_equal ("TUPLE [NS_EVENT]")  then
					Result.append ("*")
				elseif type.is_equal ("TUPLE [!NS_RECT]") or type.is_equal ("TUPLE [NS_RECT]") then
					Result.append ("{_NSRect={_NSPoint=ff}{_NSSize=ff}}")
				else
					check
						bridging_not_supported_for_method_signature: False
					end
					io.error.put_string ("ERROR: No callback for your argument types: '" + l_routine.empty_operands.generating_type.name + "' " + a_agent.out + "%N")
				end
			else
				-- ERROR: The type a_agent is not supported
				check
					bridging_not_supported_for_method_signature: False
				end
				io.error.put_string ("ERROR: No callback for your function type. " + a_agent.generator + "%N")
			end
		end

	imp_for_type_encoding (a_type_enc: STRING): POINTER
		do
			if a_type_enc.is_equal ("b@:") then
				Result := {OBJC_CALLBACK_MARSHAL}.bridge_bool_address
--			elseif a_type_enc.is_equal ("v@:") then
--				Result := {OBJC_CALLBACK_MARSHAL}.bridge_void_address
--			elseif a_type_enc.is_equal ("v@:*") then
--				Result := {OBJC_CALLBACK_MARSHAL}.bridge_void_ptr_address
			elseif a_type_enc.starts_with ("v@:") then
				Result := {OBJC_CALLBACK_MARSHAL}.bridge_void_general_address
			else
				check
					not_implemented: False
				end
				io.error.put_string ("ERROR: No callback for your function type%N")
			end
		end

	callback_marshal: OBJC_CALLBACK_MARSHAL
			-- A reference to the global Objective-C callback marshaler
		once
			create Result
		end

feature {OBJC_CALLBACK_MARSHAL, OBJC_CLASS, NS_OBJECT} -- C Object

	item: POINTER
			-- Pointer to the underlying C 'Class' struct

invariant
	item_not_null: item /= default_pointer
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
