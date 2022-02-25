note
	description: "A visitor to generate JSON representation of Eiffel code."

class
	B_NODE_JSON_GENERATOR

inherit
	BYTE_NODE_ITERATOR
		redefine
			process_argument_b,
			process_attribute_b,
			process_assign_b,
			process_creation_expr_b,
			process_guard_b,
			process_elsif_b,
			process_feature_b,
			process_if_b,
			process_local_b,
			process_loop_b
		end

	SHARED_BYTE_CONTEXT
	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Creation

	make (o: PLAIN_TEXT_FILE)
			-- Initialize the visitor with output stream `o`.
		require
			o.is_open_append
			o.is_open_write
		do
			create printer.make_with_file (o)
		end

feature {NONE} -- Access

	printer: JSON_STREAM_FILE_WRITER
			-- The printer to generate output strings.

feature -- Setup and tear down

	enter_system
			-- Start a system.
		do
			printer.enter_array
		end

	leave_system
			-- End a previously started system.
		do
			printer.leave_array
		end

feature -- Feature declaration

	process_feature (x: BYTE_CODE; f: FEATURE_I)
			-- Process code `x` of feature `f`.
		do
			context.set_current_feature (f)
			printer.enter_object
			printer.put_property_name (key_routine)
			printer.enter_object
			printer.put_property_name (key_name)
			printer.put_string_value (f.feature_name_32)
			if x.is_deferred then
				printer.put_property_name (key_is_deferred)
				printer.put_boolean_value (True)
			elseif x.is_external then
				printer.put_property_name (key_is_external)
				printer.put_boolean_value (True)
			else
				if attached {ATTRIBUTE_BYTE_CODE} x then
					printer.put_property_name (key_attribute)
				elseif x.is_once then
					printer.put_property_name (key_once)
				else
					printer.put_property_name (key_do)
				end
				printer.enter_array
				x.process (Current)
				printer.leave_array
			end
			printer.leave_object
			printer.leave_object
			context.clear_feature_data
		end

feature -- Root creation procedures

	process_root (r: SYSTEM_ROOT)
			-- Process a root entry `r`.
		do
				-- "entry" := create {ROOT_CLASS}
			printer.enter_object
			printer.put_property_name (key_assign)
			printer.enter_object
			printer.put_property_name (key_target)
			printer.enter_object
			printer.put_property_name (key_attribute)
			printer.put_string_value (key_entry) -- attribute
			printer.leave_object -- target
			printer.put_property_name (key_source)
			printer.enter_object
			printer.put_property_name (key_create)
			printer.enter_object
			printer.put_property_name (key_type)
			put_utf_8_value (r.class_type.name) -- type
			printer.leave_object -- create
			printer.leave_object -- source
			printer.leave_object -- assign
			printer.leave_object
				-- "entry".root_procedure
				-- TODO: replace an unqualified call with a quialified call when it is available.
			printer.enter_object
			printer.put_property_name (key_unqualified_call)
			printer.enter_object
			printer.put_property_name (key_routine)
			put_utf_8_value (r.procedure_name) -- routine
			printer.leave_object -- unqualified_call
			printer.leave_object
		end

feature -- Visitor: entities

	process_argument_b (x: ARGUMENT_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_formal)
			printer.put_integer_64_value (x.position)
			printer.put_property_name (key_name)
			printer.put_string_value (x.context.current_feature.arguments.item_name_32 (x.position))
			printer.leave_object
		end

	process_attribute_b (x: ATTRIBUTE_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_attribute)
			printer.put_string_value (names_heap.item_32 (x.attribute_name_id))
			printer.leave_object
		end

	process_local_b (x: LOCAL_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_local)
			printer.put_integer_64_value (x.position)
			printer.leave_object
		end

feature -- Visitor: calls

	process_feature_b (x: FEATURE_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_unqualified_call)
			printer.enter_object
			printer.put_property_name (key_routine)
			printer.put_string_value (names_heap.item_32 (x.feature_name_id))
			printer.put_property_name (key_arguments)
			printer.enter_array
			safe_process (x.parameters)
			printer.leave_array
			printer.leave_object -- unqualified_call
			printer.leave_object
		end

feature -- Visitor: expressions

	process_creation_expr_b (x: CREATION_EXPR_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_create)
			printer.enter_object
			printer.put_property_name (key_type)
			put_utf_8_value (x.type.name)
			printer.leave_object
			printer.leave_object
		end

feature -- Visitor: instructions

	process_assign_b (x: ASSIGN_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_assign)
			printer.enter_object
			printer.put_property_name (key_target)
			x.target.process (Current)
			printer.put_property_name (key_source)
			x.source.process (Current)
			printer.leave_object
			printer.leave_object
		end

	process_guard_b (x: GUARD_B)
			-- <Precursor>
		do
				-- TODO: handle assertion clauses.
			process_compound (x.compound)
		end

	process_elsif_b (x: ELSIF_B)
			-- <Precursor>
		do
				-- TODO: handle conditional expression.
				-- The compound of the "then" clause.
			process_compound (x.compound)
		end

	process_if_b (x: IF_B)
			-- <Precursor>
		do
			printer.enter_object
			printer.put_property_name (key_conditional)
				-- The beginning of a sequence of "if/elseif ... then ..." clauses.
			printer.enter_array
				-- TODO: handle conditional expression.
				-- The compound of the first "then" clause.
			process_compound (x.compound)
			safe_process (x.elsif_list)
			process_compound (x.else_part)
			printer.leave_array
			printer.leave_object
		end

	process_loop_b (x: LOOP_B)
			-- <Precursor>
		do
			safe_process (x.iteration_initialization)
			safe_process (x.from_part)
			printer.enter_object
			printer.put_property_name (key_loop)
				-- TODO: handle exit condition and iteration exit condition condition.
				-- TODO: handle invariant.
				-- Because the code to advance iteration is separate, `process_compound` is not used.
			printer.enter_array
			safe_process (x.compound)
			safe_process (x.advance_code)
				-- TODO: handle variant.
			printer.leave_array
			printer.leave_object
		end

feature {NONE} -- Visitor: instruction collection

	process_compound (x: detachable BYTE_LIST [BYTE_NODE])
			-- Generate representation for compound `x`.
		do
			printer.enter_array
			safe_process (x)
			printer.leave_array
		end

feature {NONE} -- Keys

	key_arguments: STRING_32 = "args"
			-- A key for actual arguments.

	key_assign: STRING_32 = "assign"
			-- A key for an assignment.

	key_attribute: STRING_32 = "attribute"
			-- A key for an attribute.

	key_conditional: STRING_32 = "conditional"
			-- A key for a conditional.

	key_create: STRING_32 = "create"
			-- A key for a creation.

	key_do: STRING_32 = "body"
			-- A key for a "do" routine.

	key_entry: STRING_32 = "%"entry%""
			-- A key for an entry point.

	key_formal: STRING_32 = "formal"
			-- A key for a formal argument.

	key_is_deferred: STRING_32 = "is_deferred"
			-- A key for "is_deferred" property.

	key_is_external: STRING_32 = "is_external"
			-- A key for "is_external" property.

	key_local: STRING_32 = "local"
			-- A key for a local variable.

	key_loop: STRING_32 = "loop"
			-- A key for a loop.

	key_name: STRING_32 = "name"
			-- A key for a name.

	key_once: STRING_32 = "once"
			-- A key for a "once" routine.

	key_routine: STRING_32 = "routine"
			-- A key for a routine.

	key_source: STRING_32 = "source"
			-- A key for a source of an assignment.

	key_target: STRING_32 = "target"
			-- A key for a target of an assignment.

	key_type: STRING_32 = "type"
			-- A key for a type of a creation.

	key_unqualified_call: STRING_32 = "u_call"
			-- A key for an unqualified call.

feature {NONE} -- Output

	put_utf_8_value (s: READABLE_STRING_8)
			-- Output property value `s` encoded in UTF-8.
		do
			printer.put_string_value ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (s))
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	author: "Alexander Kogtenkov"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
