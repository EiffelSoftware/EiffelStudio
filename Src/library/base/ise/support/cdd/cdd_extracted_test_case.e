indexing
	description: "Objects that represent an abstract extracted cdd test case"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_EXTRACTED_TEST_CASE

inherit

	CDD_TEST_CASE
		rename
			class_name as exc_class_name
		redefine
			default_create,
			set_up
		end

	INTERNAL
		export
			{NONE} all
		undefine
			default_create
		end


feature -- Access

	is_set_up: BOOLEAN is
			-- Has the `context' and the `routine' been initialized yet?
		do
			Result := is_context_set_up and is_routine_set_up and then
				routine_under_test.valid_operands (operands)
		end

feature -- Basic operations

	set_up is
			-- Initialize all objects in `context' needed to run `current'.
		do
			set_up_routine
			set_up_context
		ensure then
			is_set_up: is_set_up
		end

	call_routine_under_test is
			-- Call `routine_under_test'. This is the default
			-- test feature of extracted test cases.
		require
			set_up: is_set_up
		do
			routine_under_test.call (operands)
		end

feature {NONE} -- Initialization

	default_create is
			-- Create `object_map'.
		do
			create object_map.make (context.count)
		end

feature {NONE} -- Implementation (Access)

	routine_under_test: ROUTINE [ANY, like operands]
			-- Agent for calling the feature under test

	is_context_set_up: BOOLEAN is
			-- Is test case set up?
		do
			Result := operands /= Void
		end

	is_routine_set_up: BOOLEAN is
			-- Is feature under test ready for execution?
		do
			Result := routine_under_test /= Void
		end

feature {NONE} -- Implementation

	operands: TUPLE
			-- Arguments for calling `routine_under_test'

	context: ARRAY [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: ARRAY [STRING]]] is
			-- Context of the captured test case;
			-- TODO: explain components.
		deferred
		ensure
			not_void: Result /= Void
			not_empty: not Result.is_empty
			items_not_void: not Result.has (Void)
			-- NOTE (Arno): of some reason this postcondition does
			-- not work when this class is precompiled. Segmentation
			-- fault is thrown when calling `is_valid_context_entry'
			-- in fast_item of PREDICATE.
			--context_entries_valid: Result.for_all (agent is_valid_context_entry)
		end

	is_valid_context_entry (an_entry: TUPLE [id: STRING; name: STRING; inv: BOOLEAN; attributes: ARRAY [STRING]]): BOOLEAN is
			-- Is `a_pair' a valid context pair? I.e. can it appear in as an array
			-- item in `context'?
		require
			an_entry_not_void: an_entry /= Void
		local
			i: INTEGER
			l_attribute: STRING
		do
			Result := (an_entry.id /= Void and an_entry.name /= Void and an_entry.attributes /= Void) and then
					  not an_entry.id.is_empty and not an_entry.name.is_empty
			if Result then
				from
					i := an_entry.attributes.lower
				until
					i > an_entry.attributes.upper or not Result
				loop
					l_attribute := an_entry.attributes.item (i)
					Result := l_attribute /= Void -- TODO: The following does not work for empty strings!!:: and then not l_attribute.is_empty
					i := i + 1
				end
			end
		end

	object_map: HASH_TABLE [ANY, STRING]
			-- Objects created from `context' mapped with the given id in `context'.

feature {NONE} -- Object initialization

	set_up_routine is
			-- Set up `routine_under_test'.
		deferred
		ensure
			routine_set_up: is_routine_set_up
		end

	set_up_context is
			-- Set up `object_under_test' and `routine_arguments' with content from `context'.
		local
			i: INTEGER
			l_name: STRING
			l_object: ANY
			l_string8_object: STRING_8
			l_string32_object: STRING_32
			l_tuple_object: TUPLE
			l_special_object: SPECIAL [ANY]
			l_routine: ROUTINE[ANY,TUPLE]
			l_routine_attr_adj_success: BOOLEAN
		do
				-- Create instance for each object in `context'
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_name := context.item (i).type
				if l_name.is_equal ("STRING_8") then
					create l_string8_object.make_from_string (context.item (i).attributes.item (1))
					l_object := l_string8_object
				elseif l_name.is_equal ("STRING_32") then
					create l_string32_object.make_from_string (context.item (i).attributes.item (1))
					l_object := l_string32_object
				elseif is_valid_type_string (l_name) and then is_special_type (dynamic_type_from_string (l_name)) then
					l_object := create_special_object (l_name, context.item (i).attributes.count)
				elseif is_valid_type_string (l_name) then
					l_object := create_object (l_name)
					l_routine ?= l_object
					if l_routine /= void then
						l_routine_attr_adj_success := adjust_routine_attributes(l_routine, context.item (i).attributes)
						if not l_routine_attr_adj_success then
							l_object := void
						end
					end
				else
						-- Class we do not support yet
					check invalid_class_name: False end
				end
				object_map.put (l_object, context.item (i).id)
				i := i + 1
			end

				-- Populate each instanciated object with attributes
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_name := context.item (i).type
				if
					(object_map.item (context.item (i).id) /= void) and then
					not (l_name.is_equal ("STRING_8") or l_name.is_equal ("STRING_32"))
				then
					if is_special (object_map.item (context.item (i).id)) then
						l_special_object ?= object_map.item (context.item (i).id)
						set_special_attributes (l_special_object, context.item (i).attributes)
					elseif is_tuple (object_map.item (context.item (i).id)) then
						l_tuple_object ?= object_map.item (context.item (i).id)
						check is_tuple_objects: l_tuple_object /= Void end
						set_tuple_attributes (l_tuple_object, context.item (i).attributes)
					else
						set_attributes (object_map.item (context.item (i).id), context.item (i).attributes)
					end
				end
				i := i + 1
			end

				-- Check if each object in context fulfills its invariants if it has to
			from
				i := context.lower
			until
				i > context.upper
			loop
				if object_map.item (context.item (i).id) /= void and then context.item (i).inv then
					object_map.item (context.item (i).id).do_nothing
				end
				i := i + 1
			end

			operands ?= object_map.item (context.item (1).id)
				-- First object in context did not conform to operands type
			if operands = Void then
				raise ("operands in context have wrong type")
			end
		ensure
			context_set_up: is_context_set_up
		end

	create_object (a_class_name: STRING): ANY is
			-- Creates an object of type `a_class_name'.
		require
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
			a_class_name_valid: is_valid_type_string (a_class_name)
			not_special_class: not is_special_type (dynamic_type_from_string (a_class_name))
		local
			l_type: INTEGER
		do
			l_type := dynamic_type_from_string (a_class_name)
			Result := new_instance_of (l_type)
		ensure
			not_void: Result /= Void
			correct_type: type_name (Result).is_equal (a_class_name)
		end

	create_special_object (a_class_name: STRING; a_count: INTEGER): ANY is
			-- Creates a special object of type `a_class_name' for `a_count' elements.
		require
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
			a_class_name_valid: is_valid_type_string (a_class_name)
			special_class: is_special_type (dynamic_type_from_string (a_class_name))
		local
			l_type: INTEGER
		do
			l_type := dynamic_type_from_string (a_class_name)
			if is_special_any_type (l_type) then
				Result := new_special_any_instance (l_type, a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("BOOLEAN") then
				Result := create {SPECIAL [BOOLEAN]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("CHARACTER_8") then
				Result := create {SPECIAL [CHARACTER_8]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("CHARACTER_32") then
				Result := create {SPECIAL [CHARACTER_32]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("INTEGER_8") then
				Result := create {SPECIAL [INTEGER_8]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("INTEGER_16") then
				Result := create {SPECIAL [INTEGER_16]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("INTEGER_32") then
				Result := create {SPECIAL [INTEGER_32]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("INTEGER_64") then
				Result := create {SPECIAL [INTEGER_64]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("NATURAL_8") then
				Result := create {SPECIAL [NATURAL_8]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("NATURAL_16") then
				Result := create {SPECIAL [NATURAL_16]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("NATURAL_32") then
				Result := create {SPECIAL [NATURAL_32]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("NATURAL_64") then
				Result := create {SPECIAL [NATURAL_64]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("REAL") then
				Result := create {SPECIAL [REAL]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("DOUBLE") then
				Result := create {SPECIAL [DOUBLE]}.make (a_count)
			elseif generic_dynamic_type_of_type (l_type, 1) = dynamic_type_from_string ("POINTER") then
				Result := create {SPECIAL [POINTER]}.make (a_count)
			else
				check special_type_not_supported: False end
				-- User defined expanded or type we do not support yet
			end
		ensure
			not_void: Result /= Void
			correct_type: type_name (Result).is_equal (a_class_name)
		end

	set_attributes (an_object: ANY; an_attributes_list: ARRAY [STRING]) is
			-- TODO: Missing header comment.
		require
			an_object_not_void: an_object /= Void
			an_object_valid: not is_tuple (an_object) and not is_special (an_object)
			an_attributes_list_not_void: an_attributes_list /= Void
		local
			i: INTEGER
			l_name, l_value: STRING
			l_attributes: HASH_TABLE [STRING, STRING]
		do
			create l_attributes.make (an_attributes_list.count)
			from
				i := 2
			until
				i > an_attributes_list.count
			loop
				l_attributes.put (an_attributes_list.item (i), an_attributes_list.item (i-1))
				i := i + 2
			end

			from
				i := 1
			until
				i > field_count (an_object)
			loop
				l_name := field_name (i, an_object)
				if l_attributes.has (l_name) then
					l_value := l_attributes.item (l_name)
					inspect field_type (i, an_object)
					when reference_type then
						if object_map.valid_key (l_value) then
							set_reference_field (i, an_object, object_map.item (l_value))
						end
					when boolean_type then
						if l_value.is_boolean then
							set_boolean_field (i, an_object, l_value.to_boolean)
						end
					when character_8_type then
						if l_value.count > 0 then
							set_character_field (i, an_object, l_value.item (1))
						end
					when character_32_type then
						if l_value.count > 0 then
							set_character_field (i, an_object, l_value.item (1))
						end
					when integer_8_type then
						if l_value.is_integer_8 then
							set_integer_8_field (i, an_object, l_value.to_integer_8)
						end
					when integer_16_type then
						if l_value.is_integer_16 then
							set_integer_16_field (i, an_object, l_value.to_integer_16)
						end
					when integer_32_type then
						if l_value.is_integer_32 then
							set_integer_32_field (i, an_object, l_value.to_integer_32)
						end
					when integer_64_type then
						if l_value.is_integer_64 then
							set_integer_64_field (i, an_object, l_value.to_integer_64)
						end
					when natural_8_type then
						if l_value.is_natural_8 then
							set_natural_8_field (i, an_object, l_value.to_natural_8)
						end
					when natural_16_type then
						if l_value.is_natural_16 then
							set_natural_16_field (i, an_object, l_value.to_natural_16)
						end
					when natural_32_type then
						if l_value.is_natural_32 then
							set_natural_32_field (i, an_object, l_value.to_natural_32)
						end
					when natural_64_type then
						if l_value.is_natural_64 then
							set_natural_64_field (i, an_object, l_value.to_natural_64)
						end
					when real_32_type then
						if l_value.is_real then
							set_real_32_field (i, an_object, l_value.to_real)
						end
					when real_64_type then
						if l_value.is_double then
							set_real_64_field (i, an_object, l_value.to_double)
						end
					when pointer_type then
							-- in general pointer type attributes are not supported (default initialisation).
						set_pointer_field (i, an_object, create {POINTER}.default_create)
					else
						check attribute_type_not_supported: False end
							-- Type we do not cover yet.
					end
				else
					-- Test case does not reflect this attribute
					-- NOTE: so far this is not considered to be an error, since a class
					-- interface can change. If the invariants are not satisfied, an error
					-- will still come up.
				end
				i := i + 1
			end
		end

	set_tuple_attributes (a_tuple: TUPLE; an_attribute_list: ARRAY [STRING]) is
			-- Set items of `a_tuple' with values from `an_attribute_list'.
		require
			a_tuple_not_void: a_tuple /= Void
			an_attributes_list_not_void: an_attribute_list /= Void
			an_attribute_list_valid: not (an_attribute_list.has (Void) or an_attribute_list.is_empty) and then
				an_attribute_list.item (1).is_boolean
		local
			i: INTEGER
			l_value: STRING
		do
				-- First item of `an_attribute_list' describes whether
				-- `a_tuple' shall compare objects and not references
			if an_attribute_list.item (1).to_boolean then
				a_tuple.compare_objects
			else
				a_tuple.compare_references
			end

			from
				i := 1
			until
				i > a_tuple.count or i > (an_attribute_list.count - 1)
			loop
				l_value := an_attribute_list.item (i + 1)
				if a_tuple.is_reference_item (i) and object_map.valid_key (l_value) then
					a_tuple.put_reference (object_map.item (l_value), i)
				elseif a_tuple.is_boolean_item (i) and l_value.is_boolean then
					a_tuple.put_boolean (l_value.to_boolean, i)
				elseif a_tuple.is_character_8_item (i) and l_value.count > 0 then
					a_tuple.put_character_8 (l_value.item (1), i)
				elseif a_tuple.is_character_32_item (i) and l_value.count > 0 then
					a_tuple.put_character_32 (l_value.item (1).to_character_32, i)
				elseif a_tuple.is_integer_8_item (i) and l_value.is_integer_8 then
					a_tuple.put_integer_8 (l_value.to_integer_8, i)
				elseif a_tuple.is_integer_16_item (i) and l_value.is_integer_16 then
					a_tuple.put_integer_16 (l_value.to_integer_16, i)
				elseif a_tuple.is_integer_32_item (i) and l_value.is_integer_32 then
					a_tuple.put_integer_32 (l_value.to_integer_32, i)
				elseif a_tuple.is_integer_64_item (i) and l_value.is_integer_64 then
					a_tuple.put_integer_64 (l_value.to_integer_64, i)
				elseif a_tuple.is_natural_8_item (i) and l_value.is_natural_8 then
					a_tuple.put_natural_8 (l_value.to_natural_8, i)
				elseif a_tuple.is_natural_16_item (i) and l_value.is_natural_16 then
					a_tuple.put_natural_16 (l_value.to_natural_16, i)
				elseif a_tuple.is_natural_32_item (i) and l_value.is_natural_32 then
					a_tuple.put_natural_32 (l_value.to_natural_32, i)
				elseif a_tuple.is_natural_64_item (i) and l_value.is_natural_64 then
					a_tuple.put_natural_64 (l_value.to_natural_64, i)
				elseif a_tuple.is_real_item (i) and l_value.is_real then
					a_tuple.put_real (l_value.to_real, i)
				elseif a_tuple.is_double_item (i) and l_value.is_double then
					a_tuple.put_double (l_value.to_double, i)
				elseif a_tuple.is_pointer_item (i) then
						-- Do nothing. I.e. leave the tuple item at the default value.
				else
					check
							-- Type we do not cover yet. I.e. Pointers
						tuple_item_type_not_supported: False
					end
				end
				i := i + 1
			end
		end

	set_special_attributes (a_special: SPECIAL [ANY]; an_attribute_list: ARRAY [STRING]) is
			-- TODO: Missing header comment.
		require
			a_special_not_void: a_special /= Void
			an_attributes_list_not_void: an_attribute_list /= Void
		local
			i, l_type: INTEGER
			l_value: STRING
			l_b_special: SPECIAL [BOOLEAN]
			l_c8_special: SPECIAL [CHARACTER_8]
			l_c32_special: SPECIAL [CHARACTER_32]
			l_i8_special: SPECIAL [INTEGER_8]
			l_i16_special: SPECIAL [INTEGER_16]
			l_i32_special: SPECIAL [INTEGER_32]
			l_i64_special: SPECIAL [INTEGER_64]
			l_n8_special: SPECIAL [NATURAL_8]
			l_n16_special: SPECIAL [NATURAL_16]
			l_n32_special: SPECIAL [NATURAL_32]
			l_n64_special: SPECIAL [NATURAL_64]
			l_r_special: SPECIAL [REAL]
			l_d_special: SPECIAL [DOUBLE]
		do
			if generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("CHARACTER_8") then
				l_c8_special ?= a_special
				check not_void: l_c8_special /= Void end
				l_type := character_8_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("CHARACTER_32") then
				l_c32_special ?= a_special
				check not_void: l_c32_special /= Void end
				l_type := character_32_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("BOOLEAN") then
				l_b_special ?= a_special
				check not_void: l_b_special /= Void end
				l_type := boolean_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("INTEGER_8") then
				l_i8_special ?= a_special
				check not_void: l_i8_special /= Void end
				l_type := integer_8_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("INTEGER_16") then
				l_i16_special ?= a_special
				check not_void: l_i16_special /= Void end
				l_type := integer_16_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("INTEGER_32") then
				l_i32_special ?= a_special
				check not_void: l_i32_special /= Void end
				l_type := integer_32_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("INTEGER_64") then
				l_i64_special ?= a_special
				check not_void: l_i64_special /= Void end
				l_type := integer_64_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("NATURAL_8") then
				l_n8_special ?= a_special
				check not_void: l_n8_special /= Void end
				l_type := natural_8_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("NATURAL_16") then
				l_n16_special ?= a_special
				check not_void: l_n16_special /= Void end
				l_type := natural_16_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("NATURAL_32") then
				l_n32_special ?= a_special
				check not_void: l_n32_special /= Void end
				l_type := natural_32_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("NATURAL_64") then
				l_n64_special ?= a_special
				check not_void: l_n64_special /= Void end
				l_type := natural_64_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("REAL") then
				l_r_special ?= a_special
				check not_void: l_r_special /= Void end
				l_type := real_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("DOUBLE") then
				l_d_special ?= a_special
				check not_void: l_d_special /= Void end
				l_type := double_type
			elseif generic_dynamic_type (a_special, 1) = dynamic_type_from_string ("POINTER") then
				l_type := pointer_type
			else
				l_type := reference_type
			end

			from
				i := 1
			until
				i > a_special.capacity
			loop
				l_value := an_attribute_list.item (i)
				inspect l_type
				when reference_type then
					if object_map.valid_key (l_value) then
						a_special.put (object_map.item (l_value), i-1)
					end
				when boolean_type then
					if l_value.is_boolean then
						l_b_special.put (l_value.to_boolean, i-1)
					end
				when character_8_type then
					if l_value.count > 0 then
						l_c8_special.put (l_value.item (1), i-1)
					end
				when character_32_type then
					if l_value.count > 0 then
						l_c32_special.put (l_value.item (1), i-1)
					end
				when integer_8_type then
					if l_value.is_integer_8 then
						l_i8_special.put (l_value.to_integer_8, i-1)
					end
				when integer_16_type then
					if l_value.is_integer_16 then
						l_i16_special.put (l_value.to_integer_16, i-1)
					end
				when integer_32_type then
					if l_value.is_integer_32 then
						l_i32_special.put (l_value.to_integer_32, i-1)
					end
				when integer_64_type then
					if l_value.is_integer_64 then
						l_i64_special.put (l_value.to_integer_64, i-1)
					end
				when natural_8_type then
					if l_value.is_natural_8 then
						l_n8_special.put (l_value.to_natural_8, i-1)
					end
				when natural_16_type then
					if l_value.is_natural_16 then
						l_n16_special.put (l_value.to_natural_16, i-1)
					end
				when natural_32_type then
					if l_value.is_natural_32 then
						l_n32_special.put (l_value.to_natural_32, i-1)
					end
				when natural_64_type then
					if l_value.is_natural_64 then
						l_n64_special.put (l_value.to_natural_64, i-1)
					end
				when real_32_type then
					if l_value.is_real then
						l_r_special.put (l_value.to_real, i-1)
					end
				when real_64_type then
					if l_value.is_double then
						l_d_special.put (l_value.to_double, i-1)
					end
				when pointer_type then
						-- Do nothing. I.e. leave the tuple item at the default value.
				else
					check
							-- Type we do not cover yet
						special_item_type_not_supported: False
					end
				end
				i := i + 1
			end
		end

	adjust_routine_attributes(a_routine: ROUTINE[ANY,TUPLE]; some_attributes: ARRAY[STRING_8]): BOOLEAN is
			-- replace class_id and feature_id to ids of current system
		do
			Result := false
		end

invariant
	object_map_valid: object_map /= Void and then object_map.capacity >= context.count

end
