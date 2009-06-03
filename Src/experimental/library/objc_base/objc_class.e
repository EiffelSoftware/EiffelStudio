note
	description: "Summary description for {OBJC_CLASS}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_CLASS

create
	make_shared,
	make_with_name

feature -- Creation

	make_shared (a_pointer: POINTER)
		do
			item := a_pointer
		end

	make_with_name (a_class_name: STRING_GENERAL)
			-- Returns the class definition of a specified class.
		local
			cstring: C_STRING
		do
			create cstring.make (a_class_name)
			item := {NS_OBJC_RUNTIME}.objc_get_class (cstring.item)
		end

feature -- High Level Eiffel Interface

	replace_method (a_method_selector: STRING; a_agent: PROCEDURE [ANY, TUPLE]): PROCEDURE [ANY, TUPLE]
			-- Replace a method in an objective-c class by a_agent and returns the previous method.
			-- This can be dangerous as the method is replaced for all objects which are instances of that class
			-- even those that were created before this call.
		require
			-- class exists
			-- opt: class has selector
			-- Signature of a_method  <=>  Signature of eiffel agent
		local
			l_types: POINTER
			l_sel: POINTER
			l_imp: POINTER
			old_imp: POINTER
			type_encoding: STRING
			callback_marshal: OBJC_CALLBACK_MARSHAL
		do
			-- FIXME: types string and callback_imp currently hardcoded to type (id, sel) -> boolean
			create type_encoding.make_from_string ("@:")
			if attached {FUNCTION [ANY, TUPLE, BOOLEAN]} a_agent as l_function then
				type_encoding.prepend ("b") -- BOOL return type
				l_imp := {OBJC_CALLBACK_MARSHAL}.bridge_bool_address
			elseif attached {ROUTINE [ANY, TUPLE]} a_agent as l_routine then
				type_encoding.prepend ("v")
				l_imp := {OBJC_CALLBACK_MARSHAL}.bridge_void_ptr_address
			else
				-- ERROR: The type a_agent is not supported
				check
					bridging_not_supported_for_method_signature: False
				end
			end

			l_types := (create {C_STRING}.make (type_encoding)).item
			l_sel := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make (a_method_selector)).item)

			-- Store the mapping (class, sel) -> a_agent
			create callback_marshal
			callback_marshal.store_mapping (item, l_sel, a_agent)

			old_imp := {NS_OBJC_RUNTIME}.class_get_method_implementation (item, l_sel)
			l_imp := {NS_OBJC_RUNTIME}.class_replace_method (item, l_sel, l_imp, l_types)
			Result := agent {OBJC_CALLBACK_MARSHAL}.call_old_imp_void_ptr (old_imp, ?, l_sel, ?)
		end

feature -- Instantiating Classes

	create_instance: NS_OBJECT
			--
		do
			create Result.make_shared ({NS_OBJC_RUNTIME}.class_create_instance (item, 0))
			-- FIXME - should somehow create the right Eiffel subtype
		end

feature -- Runtime Support: Working with Classes

	get_method_implementation (a_sel: POINTER): POINTER
		do
			Result := {NS_OBJC_RUNTIME}.class_get_method_implementation (item, a_sel)
		end

feature {NONE} -- C Object

	item: POINTER

end
