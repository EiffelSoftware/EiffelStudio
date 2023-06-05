note
	description: "[
		Objects retrieving the application state for given call stack elements. Each object referenced by
	    the given call stack elements will be reported to `observers' in form of a
	    {TEST_CAPTURED_OBJECT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURER

inherit
	TEST_CAPTURING_STATE
		rename
			prepare as prepare_state
		redefine
			on_prepare,
			on_prepare_for_objects,
			on_clean
		end

	DEBUG_VALUE_EXPORTER

	CHARACTER_ROUTINES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create observers.make (10)
		end

feature -- Access

	observers: ARRAYED_LIST [TEST_CAPTURE_OBSERVER]
			-- Observers retrieving captured data

feature {NONE} -- Access

	object_map: detachable HASH_TABLE [NATURAL, INTEGER_64]
			-- Map containing a table of all objects which `Current' has traversed.
			--
			-- values: Identifier for object.
			-- key: Address in memeory where object is located.

	object_queue: detachable LINKED_QUEUE [TUPLE [object: ABSTRACT_DEBUG_VALUE; depth: NATURAL]]
			-- Queue containing objects of `object_map' which have not been captured yet.
			--
			-- object: Abstract debug value of object
			-- depth: Steps it took to reach object starting from stack frame

	object_counter: NATURAL
			-- Counter for creating unique object identifier

	last_value: detachable STRING
			-- Last value computed through `compute_string_representation'

feature {NONE} -- Status report

	is_object_mapped (an_adv: ABSTRACT_DEBUG_VALUE): BOOLEAN
			-- Has `an_adv' been stored in `object_map'?
		require
			capturing: is_capturing
			an_adv_reference_value: is_reference_value (an_adv)
			an_adv_attached: is_attached_eiffel_class (an_adv)
		do
			Result := object_map.has (an_adv.address.as_integer_64)
		end

feature -- Status setting

	prepare
			-- Prepare for capturing
		require
			ready: is_ready
		do
			create object_map.make (initial_object_map_size)
			create object_queue.make
			prepare_state
		ensure
			capturing_invocations: is_capturing_invocations
		end

feature -- Query

	is_valid_call_stack_element (a_cse: EIFFEL_CALL_STACK_ELEMENT): BOOLEAN
			-- Is call stack element valid for extraction?
			--
			-- `a_cse': Eiffel call stack element.
			-- `Result': True is `a_cse' is valid for extraction, False otherwise.
			--
			-- Note: for a stack element to be valid, it must fullfill all of the follwing conditions:
			--           1) not represent a call to an external feature
			--           2) not be a call to an inline agent
			--           3) exported to any or be a creation procedure
		do
			if
				attached a_cse.routine as l_feature and
				attached {EIFFEL_CLASS_C} a_cse.dynamic_class as l_class
			then
				if not (l_feature.is_external or l_feature.is_inline_agent) then
					Result := l_feature.export_status.is_all or else
						l_class.creation_feature = l_feature.associated_feature_i or else
						(l_class.has_creator_named_with (l_feature))
				end
			end
		end

feature {NONE} -- Query

	is_expanded_basic_type (an_adv: ABSTRACT_DEBUG_VALUE): BOOLEAN
			-- Is `an_adv' a expanded basic type?
		do
			Result := an_adv.kind = {VALUE_TYPES}.immediate_value
		end

	is_reference_value (an_adv: ABSTRACT_DEBUG_VALUE): BOOLEAN
			-- Is `an_adv' a reference to some object?
		do
			inspect
				an_adv.kind
			when {VALUE_TYPES}.reference_value then
				Result := True
			when {VALUE_TYPES}.special_value then
				Result := True
			else

			end
		end

	is_attached_eiffel_class (an_adv: ABSTRACT_DEBUG_VALUE): BOOLEAN
			-- Does `an_adv' represent a Void reference value?
		require
			reference_value: is_reference_value (an_adv)
		do
			if not an_adv.address.is_void then
				Result := attached {EIFFEL_CLASS_C} an_adv.dynamic_class as l_class
			end
		end

	object_identifier (an_adv: ABSTRACT_DEBUG_VALUE): NATURAL
		require
			an_adv_reference_value: is_reference_value (an_adv)
			an_adv_attached: is_attached_eiffel_class (an_adv)
			capturing: is_capturing
			an_adv_mapped: is_object_mapped (an_adv)
		do
			Result := object_map.item (an_adv.address.as_integer_64)
		end

feature {NONE} -- Element change

	map_object (an_adv: ABSTRACT_DEBUG_VALUE; a_depth: NATURAL)
			-- Add new identifier for object to `object_map' and add debug value to `object_queue'.
		require
			an_adv_reference_value: is_reference_value (an_adv)
			an_adv_attached: is_attached_eiffel_class (an_adv)
			capturing: is_capturing
			not_an_adv_mapped: not is_object_mapped (an_adv)
			object_counter_less_max: object_counter < max_object_count
			a_depth_less_or_equal_max: a_depth <= max_reference_depth
		do
			object_counter := object_counter + 1
			object_map.force (object_counter, an_adv.address.as_integer_64)
			object_queue.force ([an_adv, a_depth])
		ensure
			an_adv_mapped: is_object_mapped (an_adv)
		end

feature -- Basic operations

	capture_call_stack_element (a_cse: EIFFEL_CALL_STACK_ELEMENT)
			-- Capture objects referenced by call stack element.
			--
			-- `a_cse': Active Eiffel call stack element.
		require
			a_cse_valid: is_valid_call_stack_element (a_cse)
			capturing_invocations: is_capturing_invocations
		local
			l_element: TEST_CAPTURED_STACK_ELEMENT
			i: INTEGER
			l_abort: BOOLEAN
			l_type: STRING_32
		do
			if attached a_cse.routine as l_feature then
				create l_type.make_from_string (a_cse.current_object_value.dump_value.generating_type_representation (True))
				create l_element.make (l_feature, {UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_type))
				if not l_element.is_creation_procedure then
					if attached a_cse.current_object_value as l_dbg_value then
						compute_string_representation (l_dbg_value, 0)
						if attached last_value as l_last_value then
							l_element.add_operand
								({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_last_value),
								{UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_type))
						else
							l_abort := True
						end
					end
				end
				from
					i := 1
				until
					i > l_feature.argument_count or l_abort
				loop
					l_abort := True
					if attached a_cse.argument (i) as l_dbg_value then
						compute_string_representation (l_dbg_value, 0)
						if attached last_value as l_last_value then
							create l_type.make_from_string (l_dbg_value.dump_value.generating_type_representation (True))
							l_element.add_operand (l_last_value, l_type)
							l_abort := False
						end
					end
					i := i + 1
				end
				if not l_abort then
					observers.do_all (agent {attached TEST_CAPTURE_OBSERVER}.on_invocation_capture (l_element))
				end
			end
		ensure
			capturing_invocations: is_capturing_invocations
		end

	capture_objects
			-- Start capturing all reachable objects form previously captured stack elements. For each
			-- captured object notify observers.
		require
			capturing_invocations: is_capturing_invocations
		do
			prepare_for_objects

			from until
				object_queue.is_empty
			loop
				process_next_object
			end

			object_map := Void
			object_queue := Void
			object_counter := 0
			clean
		ensure
			ready: is_ready
		end

feature {NONE} -- Basic operations

	compute_string_representation (an_adv: ABSTRACT_DEBUG_VALUE; a_depth: NATURAL)
			-- If value is a expanded type, store its string representation in `last_value'. If value is an
			-- attached reference type store its identifier from `object_map' in `last_value'. If adv is a
			-- detached reference type, `last_value' will be set to "Void". If type is not supported (e.g.
			-- pointers), `last_value' is left Void.
		require
			a_depth_not_negative: a_depth >= 0
		local
			l_type, l_manifest: STRING
		do
			last_value := Void
			if is_reference_value (an_adv) then
				last_value := {EIFFEL_KEYWORD_CONSTANTS}.void_keyword
				if is_attached_eiffel_class (an_adv) then
					if is_object_mapped (an_adv) then
						last_value := object_identifier (an_adv).out
					else
						if object_counter < max_object_count and a_depth <= max_reference_depth then
							map_object (an_adv, a_depth)
							last_value := object_identifier (an_adv).out
						end
					end
				end
			elseif is_expanded_basic_type (an_adv) then
				if attached {DEBUG_BASIC_VALUE [BOOLEAN]} an_adv as l_bool then
					last_value := l_bool.value.out
				elseif attached {DEBUG_BASIC_VALUE [POINTER]} an_adv as l_pointer then

						-- Note: we do not store pointer values

				elseif attached {DEBUG_BASIC_VALUE [ANY]} an_adv as l_value then
					l_type := l_value.dynamic_class.name
					create last_value.make (l_type.count + 20)
					last_value.append_character ('{')
					last_value.append (l_type)
					last_value.append_character ('}')
					last_value.append_character (' ')
					if attached {DEBUG_BASIC_VALUE [CHARACTER]} l_value as l_char_value then
						last_value.append_character ('%'')
						last_value.append (char_text (l_char_value.value))
						last_value.append_character ('%'')
					else
						l_manifest := l_value.dump_value.output_value (False).to_string_8
						if attached {DEBUG_BASIC_VALUE [REAL_32]} l_value or attached {DEBUG_BASIC_VALUE [REAL_64]} l_value then
							if not l_manifest.has ('.') then
								l_manifest.append (".0")
							end
						end
						last_value.append (l_manifest)
					end
				end
			end
		end

	process_next_object
			-- Retrieve content (attributes) of next object in `object_queue'. Create
			--    appropriate {TEST_CAPTURED_OBJECT} and notify observers. Remove item from
			--    `object_queue'.
		require
			capturing_objects: is_capturing_objects
			object_queue_not_empty: not object_queue.is_empty
		local
			l_adv: ABSTRACT_DEBUG_VALUE
			l_id, l_depth: NATURAL
			l_system: SYSTEM_I
			l_classi: EIFFEL_CLASS_I
			l_type, l_dump: STRING_32
			l_object: TEST_CAPTURED_OBJECT
		do
			l_adv := object_queue.item.object
			l_depth := object_queue.item.depth
			object_queue.remove

			create l_type.make_from_string (l_adv.dump_value.generating_type_representation (True))
			l_id := object_identifier (l_adv)

			if attached {EIFFEL_CLASS_C} l_adv.dynamic_class as l_class then
				l_classi := l_class.original_class
				l_system := l_class.system
				if l_system.string_32_class = l_classi or l_system.string_8_class = l_classi then
					l_dump := l_adv.dump_value.attached_truncated_string_representation (0, -1)
					if l_dump /= Void then
						create {TEST_CAPTURED_STRING_OBJECT} l_object.make (l_id, l_type, l_dump)
					else
						check has_dump: False end
					end

					-- TODO: Store agents in a way they can restored again later (this is currently not possible).
--				elseif l_system.routine_class = l_classi or l_system.predicate_class = l_classi or l_system.procedure_class = l_classi then
--					create {TEST_CAPTURED_ITEM_OBJECT} l_object.make (l_id, l_type, 0)

				else
					if l_class.is_special or l_class.is_tuple then
						create {TEST_CAPTURED_ITEM_OBJECT} l_object.make (l_id, l_type, l_adv.children.count)
					else
						create {TEST_CAPTURED_ATTRIBUTE_OBJECT} l_object.make (l_id, l_type, l_adv.children.count)
					end
					if attached l_adv.children as l_children then
						fill_object (l_object, l_children.to_array, l_depth)
					end
				end
			end
			observers.do_all (agent {attached TEST_CAPTURE_OBSERVER}.on_object_capture (l_object))
		end

	fill_object (a_object: TEST_CAPTURED_OBJECT; a_list: ARRAY [ABSTRACT_DEBUG_VALUE]; a_depth: NATURAL)
			-- Fill captured object with content retrieved from abstract debug values.
			--
			-- `a_object': Object to be filled with content.
			-- `a_list': List of abstract debug values, usually the object original attributes or item.
			-- `a_depth': Current reference depth.
		require
			a_object_has_items_or_attributes: a_object.has_attributes or a_object.has_items
		local
			i: INTEGER
		do
			from
				i := a_list.lower
			until
				i > a_list.upper
			loop
				if attached a_list.item (i) as l_dbg_value then
					if
						attached l_dbg_value.dump_value.generating_type_representation (True) as l_type and then
						not a_object.type.same_string_general (l_type)
					then
							-- If the content referes to the same type, we do not increase the depth. That prevents
							-- datastructures like linked list not to be cut off after `max_reference_depth' elements.
						compute_string_representation (l_dbg_value, a_depth)
					else
						compute_string_representation (l_dbg_value, a_depth + 1)
					end
					if attached last_value as l_value then
						if a_object.has_items then
							a_object.items.force (l_value)
						else
							if attached l_dbg_value.name as l_name then
								a_object.attributes.force (l_value, l_name)
							else
								check has_name: False end
							end
						end
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			observers.do_all (agent (a_obs: TEST_CAPTURE_OBSERVER)
				do
					if a_obs.is_ready then
						a_obs.prepare
					end
				end)
		end

	on_prepare_for_objects
			-- <Precursor>
		do
			observers.do_all (agent (a_obs: TEST_CAPTURE_OBSERVER)
				do
					if a_obs.is_capturing_invocations then
						a_obs.prepare_for_objects
					end
				end)
		end

	on_clean
			-- <Precursor>
		do
			observers.do_all (agent (a_obs: TEST_CAPTURE_OBSERVER)
				do
					if a_obs.is_capturing_objects then
						a_obs.clean
					end
				end)
		end

feature {NONE} -- Constants

	initial_object_map_size: INTEGER = 1000
			-- Starting size of `object_map'
			--
			-- Note: this value basically describes how many objects are captured on avarage

	max_object_count: NATURAL = 2000
	max_reference_depth: NATURAL = 5

invariant
	capturing_equals_object_map_attached: is_capturing = (object_map /= Void)
	capturing_equals_object_queue_attached: is_capturing = (object_queue /= Void)

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
