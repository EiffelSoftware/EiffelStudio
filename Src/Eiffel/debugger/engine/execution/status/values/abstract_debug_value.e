note

	description:
		"Abstract notion of value during the execution of the application."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ABSTRACT_DEBUG_VALUE

inherit
	COMPARABLE

	ABSTRACT_DEBUG_VALUE_CONSTANTS
		undefine
			is_equal
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_ABSTRACT_DEBUG_VALUE_SORTER
		undefine
			is_equal
		end

	SHARED_DEBUGGER_MANAGER
		undefine
			is_equal
		end

	VALUE_TYPES
		export
			{NONE} all
		undefine
			is_equal
		end

	SK_CONST
		undefine
			is_equal
		end

	REFACTORING_HELPER
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	DEBUGGER_COMPILER_UTILITIES
		undefine
			is_equal
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

feature -- Properties

	is_attribute: BOOLEAN;
			-- Is current value an attribute

	name: STRING_32
			-- Name of attribute or argument or local

	is_external_type: BOOLEAN
			-- Is this value an instance of an external type ?
			-- which means whose information are not completly known
			-- by the compiler

feature {DEBUG_VALUE_EXPORTER} -- Internal Properties

	e_class: CLASS_C;
			-- Class where attribute is defined
			-- (Void for if not attribute)

feature -- Access

	dynamic_class: CLASS_C
			-- Return class of value
		deferred
		end;

	item_number: INTEGER
			-- number of the object in the local list, attribute list, etc...

	dump_value: DUMP_VALUE
			-- Dump_value corresponding to `Current'.
		deferred
		ensure
			valid_result: Result /= Void
		end

	static_class: CLASS_C
			-- Static type used if Current represents a Void/NULL value
			-- if current does not represent a Void value
			-- this value may be Void

feature -- Change

	set_static_class (cl: like static_class)
			-- Set `static_class' as `cl'.
		do
			static_class := cl
		end

	reset_children
			-- Reset internal data related to children
		do
		end

feature -- Comparison

	is_less alias "<" (other: ABSTRACT_DEBUG_VALUE): BOOLEAN
			-- Is `Current''s name lexicographically lower than `other''s?
		do
			Result := name < other.name
		end;

feature -- Output for debugger

	extra_output_details: STRING_32
		do
		end

feature {DEBUG_VALUE_EXPORTER} -- Computed Value access

	output_value: STRING_32
			-- A STRING representation of the value of `Current'.
		deferred
		ensure
			Result_attached: Result /= Void
		end

	type_and_value: STRING_32
			-- Return a string representing `Current'.
		deferred
		ensure
			Result_attached: Result /= Void
		end

feature -- Output

	expandable: BOOLEAN
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		deferred
		end

	children: DEBUG_VALUE_LIST
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		deferred
		end

	sorted_children: DEBUG_VALUE_LIST
			-- sort `children' and return it.
		do
			Result := children
			if
				Result /= Void
			then
				sort_debug_values (Result)
			end
		end

	address: DBG_ADDRESS
			-- Address of the object represented by `Current'. Void if none.
		do
		end

	kind: INTEGER
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		deferred
		ensure
			valid_kind: Result >= Immediate_value and then Result <= Error_message_value
		end

feature {DUMP_VALUE, CALL_STACK_ELEMENT, DBG_EVALUATOR, ABSTRACT_DEBUG_VALUE, IPC_REQUEST, OBJECT_ADDR} -- Hector address

	set_hector_addr
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		require
			is_classic: debugger_manager.is_classic_project
		do
		end

feature {ATTR_REQUEST, CALL_STACK_ELEMENT} -- Setting

	set_item_number (n: like item_number)
			-- set `item_number' to `n'
		require
			n >= 0
		do
			item_number := n
		ensure
			item_number = n
		end

feature {RECV_VALUE, CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER, ABSTRACT_DEBUG_VALUE, APPLICATION_EXECUTION} -- Setting

	set_name (n: like name)
			-- Set `name' to `n'.
		do
			name := n
		ensure
			set: name = n
		end

feature {NONE} -- Implementation

	set_default_name
			-- Set the name to `default' in order to	
			-- satisfy the invariant and the less than routine.
			-- When the client uses this
			-- class the name will be set after the call info is
			-- processed. This is done for optimization reasons.
		require
			not_is_attribute: not is_attribute
		do
			name := "default"
		end

	Any_class: CLASS_C
		once
			Result := Eiffel_system.any_class.compiled_class
		end

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			if attached name as n then
				Result.append ({STRING_32} "name=")
				Result.append (n)
			end
			if address = Void or else address.is_void then
				Result.append ({STRING_32} " Is_Void")
			end
			if attached dynamic_class as cl then
				Result.append ({STRING_32} " type=")
				Result.append (cl.name_in_upper)
			end
		end

feature {NONE} -- Constants

	NONE_representation: STRING = "NONE = Void"

	Left_address_delim: STRING = " <"

	Right_address_delim: STRING = ">"

	Equal_sign_str: STRING = " = "

	Is_unknown: STRING = " = Unknown"

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER
		do
			Result := abstract_debug_value_id
		end

invariant

	non_void_name: name /= Void
	valid_attribute: is_attribute implies e_class /= Void
	valid_dynamic_class: attached dynamic_class as cl implies not cl.is_deferred

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
