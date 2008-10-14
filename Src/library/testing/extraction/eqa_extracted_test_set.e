indexing
	description: "Objects that represent an abstract extracted cdd test case"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_EXTRACTED_TEST_SET

inherit

	EQA_TEST_SET
		rename
			on_prepare as on_prepare_frozen,
			on_clean as on_clean_frozen
		redefine
			on_prepare_frozen,
			on_clean_frozen
		end

	INTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Access

	context: !ARRAY [!TUPLE [type: !STRING; inv: BOOLEAN; attributes: !ARRAY [!STRING]]] is
			-- Context of the captured test case;
			-- TODO: explain components.
		deferred
		ensure
			context_entries_valid: Result.for_all (agent is_valid_context_item)
		end

	object_cache: ?ARRAY [!ANY]
			-- Cache containing restored objects from `context'

feature {NONE} -- Status report

	is_existing_id (a_id: !STRING): BOOLEAN
			-- Is `a_id' an id of an existing object in `context'?
		require
			a_id_valid: is_valid_id (a_id)
		local
			n: like index_of_id
		do
			n := index_of_id (a_id)
			Result := context.valid_index (n.to_integer_32)
		end

	is_cache_loaded: BOOLEAN
			-- Is `object_cache' filled with all object from `context'?
		local
			i: INTEGER
		do
			if object_cache /= Void then
				if context.lower = object_cache.lower and context.upper = object_cache.upper then
					from
						i := context.lower
						Result := True
					until
						i > context.upper or not Result
					loop
							-- TODO: find a way to assure all objects in `object_cache' have the correct type
						Result := True -- type_name (object_cache.item (i)).is_equal (context.item (i).type)
						i := i + 1
					end
				end
			end
		ensure
			result_implies_attached: Result implies object_cache /= Void
			result_implies_equal_range: Result implies (context.lower = object_cache.lower and context.upper = object_cache.upper)
		end

feature {NONE} -- Query

	is_valid_id (a_id: !STRING): BOOLEAN
			-- Is `a_id' a possible identifier for an object in `context'?
		local
			l_nat: STRING
			n: NATURAL
		do
			if a_id.count > 1 and then a_id.item (1) = '#' then
				Result := a_id.substring (2, a_id.count).is_natural
			end
		ensure
			result_implies_count_great_enough: Result implies a_id.count > 1
			result_implies_has_pound: Result implies a_id.item (1) = '#'
			result_implies_is_natural: Result implies a_id.substring (2, a_id.count).is_natural
		end

	index_of_id (a_id: !STRING): NATURAL
			-- Index component of `a_id'.
		require
			a_id_valid: is_valid_id (a_id)
		do
			Result := a_id.substring (2, a_id.count).to_natural
		ensure
			result_valid: a_id.is_equal ({!STRING} #? "#" + Result.out)
		end

	object_for_id (a_id: !STRING): !ANY
			-- Cached instance restored from `context' for given id.
			--
			-- `a_id': ID used in `context' for requested object.
			-- `Result': Cached instance of object restored from `context'.
		require
			a_id_valid: is_existing_id (a_id)
			object_cache_loaded: is_cache_loaded
		do
			Result := object_cache.item (index_of_id (a_id).to_integer_32)
		end

	is_valid_context_item (an_item: !TUPLE [type: !STRING; inv: !BOOLEAN; attributes: !ARRAY [!STRING]]): BOOLEAN is
			-- Is `a_pair' a valid context pair? I.e. can it appear in as an array
			-- item in `context'?
		local
			i: INTEGER
			l_attribute: STRING
		do
			if is_valid_type_string (an_item.type) then
				if not (an_item.type.is_equal (string_8_type_name) or an_item.type.is_equal (string_32_type_name)) then
					Result := not an_item.attributes.there_exists (agent {!STRING}.is_empty)
				else
					Result := True
				end
			end
		end

feature {NONE} -- Events

	frozen on_prepare_frozen
			-- <Precursor>
		do
			fill_object_cache
			on_prepare
		ensure then
			object_cache_loaded: is_cache_loaded
		end

	on_prepare
			-- Called immediatly before `prepare' returns.
		require
			object_cache_loaded: is_cache_loaded
		do
		ensure
			object_cache_loaded: is_cache_loaded
		end

	frozen on_clean_frozen
			-- <Precursor>
		do
			object_cache := Void
			on_clean
		ensure then
			object_cache_detached: object_cache = Void
		end

	on_clean
			-- Called immediatly before `prepare' returns.
		do
		ensure
			object_cache_detached: object_cache = Void
		end

feature {NONE} -- Basic operations

	run_extracted_test (a_routine: !ROUTINE [ANY, TUPLE]; a_operands: !TUPLE)
			-- Call routine with given operands.
			--
			-- `a_routine': Arbitrary eiffel routine.
			-- `a_operands': Tuple containing operands for `a_routine'.
			--
			-- Note: items in `a_operands' of the form #ID where ID is a valid index for `context', will be
			--       replaced with the corresponding object instance. If any item in `a_operands' does not
			--       conform to the operand needed to call `a_routine', an exception will be triggered.
		local
			l_new: !TUPLE
			l_attrs: !ARRAY [!STRING]
			i: INTEGER
		do
			l_new ?= a_routine.empty_operands
			if a_operands.count < l_new.count then
				assert ("size of operands not correct", False)
			end
			from
				i := 1
			until
				i > l_new.count
			loop
				if l_new.is_reference_item (i) then
					if {l_id: !STRING} a_operands.item (i) and then is_valid_id (l_id) and then is_existing_id (l_id) then
						l_new.put_reference (object_for_id (l_id), i)
					elseif l_new.valid_type_for_index (a_operands.item (i), i) then
						l_new.put (a_operands.item (i), i)
					else
						assert ("operand " + i.out + " must refer to object in context", False)
					end
				elseif l_new.valid_type_for_index (a_operands.item (i), i) then
					l_new.put (a_operands.item (i), i)
				else
					assert ("operand " + i.out + " has wrong type for routine" + i.out, False)
				end
				i := i + 1
			end
			a_routine.call (l_new)
		end

feature {NONE} -- Object initialization

	fill_object_cache is
			-- Set up `object_under_test' and `routine_arguments' with content from `context'.
		local
			i: INTEGER
			l_name: !STRING
			l_object: !ANY
			l_string8_object: !STRING_8
			l_string32_object: !STRING_32
			l_routine_attr_adj_success: BOOLEAN
		do
			create object_cache.make (context.lower, context.upper)
				-- Create instance for each object in `context'
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_name := context.item (i).type
				if l_name.is_equal (string_8_type_name) then
					create l_string8_object.make_from_string (context.item (i).attributes.item (1))
					l_object := l_string8_object
				elseif l_name.is_equal (string_32_type_name) then
					create l_string32_object.make_from_string (context.item (i).attributes.item (1))
					l_object := l_string32_object
				elseif is_valid_type_string (l_name) and then is_special_type (dynamic_type_from_string (l_name)) then
					l_object := create_special_object (l_name, context.item (i).attributes.count)
				elseif is_valid_type_string (l_name) then
					l_object ?= create_object (l_name)
				else
						-- Class we do not support yet
					assert ("objects of type " + l_name + " are not supported", False)
				end
				object_cache.put (l_object, i)
				i := i + 1
			end

				-- Populate each instanciated object with attributes
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_object := object_cache.item (i)
				if not ({l_s8: !STRING_8} l_object or {l_s32: !STRING_32} l_object) then
					if {l_special_object: !SPECIAL [ANY]} l_object then
						set_special_attributes (l_special_object, context.item (i).attributes)
					elseif {l_tuple_object: !TUPLE} l_object then
						set_tuple_attributes (l_tuple_object, context.item (i).attributes)
					else
						set_attributes (l_object, context.item (i).attributes)
					end
				end
				i := i + 1
			end

				-- Check if each object in context fulfills its invariants if it has to
			from
				i := object_cache.lower
			until
				i > object_cache.upper
			loop
				if context.item (i).inv then
					object_cache.item (i).do_nothing
				end
				i := i + 1
			end
		ensure
			object_cache_loaded: is_cache_loaded
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
			--correct_type: type_name (Result).is_equal (a_class_name)
		end

	create_special_object (a_class_name: STRING; a_count: INTEGER): !SPECIAL [ANY] is
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
				Result ?= new_special_any_instance (l_type, a_count)
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
				assert ("special type " + a_class_name + " not supported", False)
			end
		ensure
			--correct_type: type_name (Result).is_equal (a_class_name)
		end

	set_attributes (an_object: !ANY; an_attributes_list: !ARRAY [!STRING]) is
			-- TODO: Missing header comment.
		require
			an_object_not_void: an_object /= Void
			an_object_valid: not is_tuple (an_object) and not is_special (an_object)
			an_attributes_list_not_void: an_attributes_list /= Void
		local
			i: INTEGER
			l_value: !STRING
			l_attributes: HASH_TABLE [!STRING, !STRING]
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
				if {l_name: !STRING} field_name (i, an_object) then
					if l_attributes.has (l_name) then
						l_value := l_attributes.item (l_name)
						inspect field_type (i, an_object)
						when reference_type then
							if is_valid_id (l_value) and then is_existing_id (l_value) then
								set_reference_field (i, an_object, object_for_id (l_value))
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
						-- `context' does not contain this attribute, whic is not considered to be an error, since a
						-- class interface can change. If the invariants are not satisfied, an error will still occur.
					end
				end
				i := i + 1
			end
		end

	set_tuple_attributes (a_tuple: !TUPLE; an_attribute_list: !ARRAY [!STRING]) is
			-- Set items of `a_tuple' with values from `an_attribute_list'.
		require
			an_attribute_list_valid: not an_attribute_list.is_empty and then
				an_attribute_list.item (1).is_boolean
		local
			i: INTEGER
			l_value: !STRING
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
				if a_tuple.is_reference_item (i) then
					if is_valid_id (l_value) and then is_existing_id (l_value) then
						a_tuple.put_reference (object_for_id (l_value), i)
					end
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

	set_special_attributes (a_special: !SPECIAL [ANY]; an_attribute_list: !ARRAY [!STRING]) is
			-- TODO: Missing header comment.
		require
			a_special_not_void: a_special /= Void
			an_attributes_list_not_void: an_attribute_list /= Void
		local
			i, l_type: INTEGER
			l_value: !STRING
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
				inspect
					l_type
				when reference_type then
					if is_valid_id (l_value) and then is_existing_id (l_value) then
						a_special.put (object_for_id (l_value), i-1)
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

feature {NONE} -- Constants

	string_8_type_name: STRING = "STRING_8"
	string_32_type_name: STRING = "STRING_32"

end
