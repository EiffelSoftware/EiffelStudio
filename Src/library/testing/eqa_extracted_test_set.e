note
	description: "[
		Sets of tests which make use of an extracted application state to reproduce a failure.
	]"
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
			on_clean_frozen,
			is_prepared
		end

	INTERNAL
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Access

	context: ARRAY [TUPLE [type: TYPE [ANY]; attributes: TUPLE; inv: BOOLEAN]]
			-- List of objects needed to reconstruct application state as it was when test routines were
			--     extracted. Once the content is restored (after `prepare' was called), each object can
			--     be accessed through `object_for_id', where id is is in the form of '#' + index.
			--
			-- type:       Type for object
			-- attributes: Actual content of object.
			--             If type is {STRING_8} or {STRING_32}, attributes must only contain a string. This
			--                 string is used to restore original string object.
			--             If type is {TUPLE} or {SPECIAL [ANY]}, attributes contains the objects element.
			--                 In case of manifest types, these are the actual values. Otherwise
			--                 strings referring to other objects in `context'.
			--             Otherwise attributes are pairs of the actual attribute name and the corresponding
			--                 value. Again this can be the values for manifest type, otherwise object ids.
			-- inv:        True if object must satisfy its invariants. False if object was part of call
			--                 stack when test was extracted, so it does not have to satisfy its invariants.
		deferred
		end

	object_cache: detachable ARRAY [ANY]
			-- Cache containing restored objects from `context'

feature -- Status report

	is_prepared: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and object_cache /= Void
		ensure then
			result_implies_cache_loaded: Result implies object_cache /= Void
		end

feature {NONE} -- Status report

	is_existing_id (a_id: STRING): BOOLEAN
			-- Is `a_id' an id of an existing object in `context'?
		require
			a_id_attached: a_id /= Void
		local
			n: like index_of_id
		do
			if is_valid_id (a_id) then
				n := index_of_id (a_id)
				Result := context.valid_index (n.to_integer_32)
			end
		end

	is_cache_loaded: BOOLEAN
			-- Is `object_cache' filled with all object from `context'?
		do
			Result := object_cache /= Void
		ensure
			definition: Result implies object_cache /= Void
		end

feature {NONE} -- Query

	is_valid_id (a_id: STRING): BOOLEAN
			-- Is `a_id' a possible identifier for an object in `context'?
		require
			a_id_attached: a_id /= Void
		do
			if a_id.count > 1 and then a_id.item (1) = '#' then
				Result := a_id.substring (2, a_id.count).is_natural
			end
		ensure
			result_implies_count_great_enough: Result implies a_id.count > 1
			result_implies_has_pound: Result implies a_id.item (1) = '#'
			result_implies_is_natural: Result implies a_id.substring (2, a_id.count).is_natural
		end

	index_of_id (a_id: STRING): NATURAL
			-- Index component of `a_id'.
		require
			a_id_attached: a_id /= Void
			a_id_valid: is_valid_id (a_id)
		do
			Result := a_id.substring (2, a_id.count).to_natural
		ensure
			result_valid: ({STRING} "#" + Result.out).same_string_general (a_id)
		end

	object_for_id (a_id: STRING): detachable ANY
			-- Cached instance restored from `context' for given id.
			--
			-- `a_id': ID used in `context' for requested object.
			-- `Result': Cached instance of object restored from `context'.
		require
			a_id_attached: a_id /= Void
			a_id_valid: is_existing_id (a_id)
		do
			if attached object_cache as l_cache then
				Result := l_cache.item (index_of_id (a_id).to_integer_32)
			end
		end

	is_valid_item_tuple (a_special: SPECIAL [ANY]; a_tuple: TUPLE): BOOLEAN
			-- Does `a_tuple' contain valid elements for `a_special'?
		require
			a_special_attached: a_special /= Void
			a_tuple_attached: a_tuple /= Void
		do
			if attached {SPECIAL [BOOLEAN]} a_special as l_b_special then
				Result := a_tuple.is_uniform_boolean
			elseif attached {SPECIAL [CHARACTER_8]} a_special as l_c8_special then
				Result := a_tuple.is_uniform_character_8
			elseif attached {SPECIAL [CHARACTER_32]} a_special as l_c32_special then
				Result := a_tuple.is_uniform_character_32
			elseif attached {SPECIAL [INTEGER_8]} a_special as l_i8_special then
				Result := a_tuple.is_uniform_integer_8
			elseif attached {SPECIAL [INTEGER_16]} a_special as l_i16_special then
				Result := a_tuple.is_uniform_integer_16
			elseif attached {SPECIAL [INTEGER_32]} a_special as l_i32_special then
				Result := a_tuple.is_uniform_integer_32
			elseif attached {SPECIAL [INTEGER_64]} a_special as l_i64_special then
				Result := a_tuple.is_uniform_integer_64
			elseif attached {SPECIAL [NATURAL_8]} a_special as l_n8_special then
				Result := a_tuple.is_uniform_natural_8
			elseif attached {SPECIAL [NATURAL_16]} a_special as l_n16_special then
				Result := a_tuple.is_uniform_natural_16
			elseif attached {SPECIAL [NATURAL_32]} a_special as l_n32_special then
				Result := a_tuple.is_uniform_natural_32
			elseif attached {SPECIAL [NATURAL_64]} a_special as l_n64_special then
				Result := a_tuple.is_uniform_natural_64
			elseif attached {SPECIAL [REAL]} a_special as l_r_special then
				Result := a_tuple.is_uniform_real
			elseif attached {SPECIAL [DOUBLE]} a_special as l_d_special then
				Result := a_tuple.is_uniform_double
			elseif attached {SPECIAL [POINTER]} a_special as l_p_special then
				Result := a_tuple.is_uniform_pointer
			else
				Result := a_tuple.is_uniform_reference
			end
		ensure
			tuple_uniform_boolean: (Result and attached {SPECIAL [BOOLEAN]} a_special as l_b) implies a_tuple.is_uniform_boolean
			tuple_uniform_character_8: (Result and attached {SPECIAL [CHARACTER_8]} a_special as l_c8) implies a_tuple.is_uniform_character_8
			tuple_uniform_character_32: (Result and attached {SPECIAL [CHARACTER_32]} a_special as l_c32) implies a_tuple.is_uniform_character_32
			tuple_uniform_integer_8: (Result and attached {SPECIAL [INTEGER_8]} a_special as l_i8) implies a_tuple.is_uniform_integer_8
			tuple_uniform_integer_16: (Result and attached {SPECIAL [INTEGER_16]} a_special as l_i16) implies a_tuple.is_uniform_integer_16
			tuple_uniform_integer_32: (Result and attached {SPECIAL [INTEGER_32]} a_special as l_i32) implies a_tuple.is_uniform_integer_32
			tuple_uniform_integer_64: (Result and attached {SPECIAL [INTEGER_64]} a_special as l_i64) implies a_tuple.is_uniform_integer_64
			tuple_uniform_natural_8: (Result and attached {SPECIAL [NATURAL_8]} a_special as l_n8) implies a_tuple.is_uniform_natural_8
			tuple_uniform_natural_16: (Result and attached {SPECIAL [NATURAL_16]} a_special as l_n16) implies a_tuple.is_uniform_natural_16
			tuple_uniform_natural_32: (Result and attached {SPECIAL [NATURAL_32]} a_special as l_n32) implies a_tuple.is_uniform_natural_32
			tuple_uniform_natural_64: (Result and attached {SPECIAL [NATURAL_64]} a_special as l_n64) implies a_tuple.is_uniform_natural_64
			tuple_uniform_real: (Result and attached {SPECIAL [REAL]} a_special as l_r) implies a_tuple.is_uniform_real
			tuple_uniform_double: (Result and attached {SPECIAL [DOUBLE]} a_special as l_d) implies a_tuple.is_uniform_double
			tuple_uniform_pointer: (Result and attached {SPECIAL [POINTER]} a_special as l_p) implies a_tuple.is_uniform_pointer
			tuple_uniform_reference: (Result and not attached {SPECIAL [BOOLEAN]} a_special as l_nb and not attached {SPECIAL [CHARACTER_8]} a_special as l_nc8 and not
				attached {SPECIAL [CHARACTER_32]} a_special as l_nc32 and not attached {SPECIAL [INTEGER_8]} a_special as l_ni8 and not attached {SPECIAL [INTEGER_16]} a_special as l_ni16 and not
				attached {SPECIAL [INTEGER_32]} a_special as l_ni32 and not attached {SPECIAL [INTEGER_64]} a_special as l_ni64 and not attached {SPECIAL [NATURAL_8]} a_special as l_nn8 and not
				attached {SPECIAL [NATURAL_16]} a_special as l_nn16 and not attached {SPECIAL [NATURAL_32]} a_special as l_nn32 and not attached {SPECIAL [NATURAL_64]} a_special as l_nn64 and not
				attached {SPECIAL [REAL]} a_special as l_nr and not attached {SPECIAL [DOUBLE]} a_special as l_nd and not attached {SPECIAL [POINTER]} a_special as l_np) implies a_tuple.is_uniform_reference


		end

feature {NONE} -- Events

	frozen on_prepare_frozen
			-- <Precursor>
		do
			fill_object_cache
			on_prepare
		end

	on_prepare
			-- Called after `prepare' has performed all initialization.
		require
			object_cache_loaded: object_cache /= Void
		do
		ensure
			prepared: is_prepared
		end

	frozen on_clean_frozen
			-- <Precursor>
		do
			on_clean
			object_cache := Void
		ensure then
			object_cache_detached: object_cache = Void
		end

	on_clean
			-- Called before `clean' performs any cleaning up.
		require
			prepared: is_prepared
		do
		ensure
			object_cache_loaded: object_cache /= Void
		end

feature {NONE} -- Basic operations

	run_extracted_test (a_routine: ROUTINE; a_operands: TUPLE)
			-- Call routine with given operands.
			--
			-- `a_routine': Arbitrary Eiffel routine.
			-- `a_operands': Tuple containing operands for `a_routine'.
			--
			-- Note: items in `a_operands' of the form #ID where ID is a valid index for `context', will be
			--       replaced with the corresponding object instance. If any item in `a_operands' does not
			--       conform to the operand needed to call `a_routine', an exception will be triggered.
		require
			a_routine_attached: a_routine /= Void
			a_operands_attached: a_operands /= Void
		do
			if
				attached resolved_attributes (a_operands) as ops and then
				a_routine.valid_operands (ops)
			then
				a_routine.flexible_call (ops)
			else
				assert_32 ("Correct operands for a feature call", False)
			end
		end

feature {NONE} -- Object initialization

	fill_object_cache
			-- Set up `object_under_test' and `routine_arguments' with content from `context'.
		local
			i, l_gtype: INTEGER
			l_object: detachable ANY
			l_type: TYPE [ANY]
			l_cache: like object_cache
		do
			create l_cache.make_filled (create {ANY}, context.lower, context.upper)
			object_cache := l_cache
				-- Create instance for each object in `context'
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_type := context.item (i).type
				if attached {TYPE [SPECIAL [ANY]]} l_type as l_stype then
					l_object := create_special_object (l_stype, context.item (i).attributes.count)
				else
					if attached {TYPE [STRING]} l_type or attached {TYPE [STRING_32]} l_type then
						if attached {STRING} context.item (i).attributes.item (1) as l_string_object then
							l_object := l_string_object
						else
							assert_32 ("first attribute of a STRING_8 or STRING_32 object must be a manifest string", False)
						end
					else
						l_gtype := generic_dynamic_type (context.item (i).type, 1)
						if attached {ANY} new_instance_of (l_gtype) as l_any then
							l_object := l_any
						else
							assert_32 ({STRING_32} "objects of type " + type_name_of_type (l_gtype) + " are not supported", False)
						end
					end
					check l_object /= Void end
				end
				if l_object /= Void then
					l_cache.put (l_object, i)
				end
				i := i + 1
			end

				-- Populate each instanciated object with attributes
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_object := l_cache.item (i)
				if not (attached {STRING_8} l_object as l_s8 or attached {STRING_32} l_object as l_s32) then
					if attached {SPECIAL [ANY]} l_object as l_special_object then
						if is_valid_item_tuple (l_special_object, context.item (i).attributes) then
							set_special_attributes (l_special_object, context.item (i).attributes)
						else
							assert_32 ("all items of a special object must be of the same type", False)
						end
					elseif attached {TUPLE} l_object as l_tuple_object then
							-- First item of `an_attribute_list' describes whether
							-- `a_tuple' shall compare objects and not references
						if context.item (i).attributes.count > 0 and then context.item (i).attributes.is_boolean_item (1) then
							if context.item (i).attributes.boolean_item (1) then
								l_tuple_object.compare_objects
							else
								l_tuple_object.compare_references
							end
						else
							assert_32 ("first item of tuple object must be boolean", False)
						end
						set_tuple_attributes (l_tuple_object, context.item (i).attributes, 1)
					else
						set_attributes (l_object, context.item (i).attributes)
					end
				end
				i := i + 1
			end

				-- Check if each object in context fulfills its invariants if it has to
			from
				i := l_cache.lower
			until
				i > l_cache.upper
			loop
				if context.item (i).inv then
					l_cache.item (i).do_nothing
				end
				i := i + 1
			end
		ensure
			object_cache_loaded: object_cache /= Void
		end

	create_special_object (a_special: TYPE [SPECIAL [ANY]]; a_count: INTEGER): detachable SPECIAL [detachable ANY]
			-- Creates a special object of type `a_class_name' for `a_count' elements.
		require
			a_special_attached: a_special /= Void
			a_count_not_negative: a_count >= 0
		local
			l_type: INTEGER
		do
			if attached {TYPE [SPECIAL [BOOLEAN]]} a_special as l_b_special then
				Result := create {SPECIAL [BOOLEAN]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [CHARACTER_8]]} a_special as l_c8_special then
				Result := create {SPECIAL [CHARACTER_8]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [CHARACTER_32]]} a_special as l_c32_special then
				Result := create {SPECIAL [CHARACTER_32]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [INTEGER_8]]} a_special as l_i8_special then
				Result := create {SPECIAL [INTEGER_8]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [INTEGER_16]]} a_special as l_i16_special then
				Result := create {SPECIAL [INTEGER_16]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [INTEGER_32]]} a_special as l_i32_special then
				Result := create {SPECIAL [INTEGER_32]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [INTEGER_64]]} a_special as l_i64_special then
				Result := create {SPECIAL [INTEGER_64]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [NATURAL_8]]} a_special as l_n8_special then
				Result := create {SPECIAL [NATURAL_8]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [NATURAL_16]]} a_special as l_n16_special then
				Result := create {SPECIAL [NATURAL_16]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [NATURAL_32]]} a_special as l_n32_special then
				Result := create {SPECIAL [NATURAL_32]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [NATURAL_64]]} a_special as l_n64_special then
				Result := create {SPECIAL [NATURAL_64]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [REAL]]} a_special as l_r_special then
				Result := create {SPECIAL [REAL]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [DOUBLE]]} a_special as l_d_special then
				Result := create {SPECIAL [DOUBLE]}.make_empty (a_count)
			elseif attached {TYPE [SPECIAL [POINTER]]} a_special as l_p_special then
				Result := create {SPECIAL [POINTER]}.make_empty (a_count)
			else

					-- TYPE [SPECIAL [ANY]]
					--       ^
				l_type := generic_dynamic_type (a_special, 1)

				if l_type >= 0 and then is_special_any_type (l_type) then
					Result := new_special_any_instance (l_type, a_count)
				else
					assert_32 ("special type not supported", False)
				end
			end
		end

	set_attributes (an_object: ANY; an_attributes: TUPLE)
			-- TODO: Missing header comment.
		require
			an_object_not_void: an_object /= Void
			an_object_valid: not is_tuple (an_object) and not is_special (an_object)
			an_attributes_attached: an_attributes /= Void
		local
			i, j: INTEGER
			l_attributes: HASH_TABLE [INTEGER, STRING]
			l_name: like field_name
		do
			create l_attributes.make (an_attributes.count // 2)
			from
				i := 1
			until
				not an_attributes.valid_index (i + 1)
			loop
				if an_attributes.is_reference_item (i) and then attached {STRING} an_attributes.reference_item (i) as l_key then
					l_attributes.force (i + 1, l_key)
				else
					assert_32 ("attribute tuple for normal object must always be a pair of strings and values", False)
				end
				i := i + 2
			end

			from
				i := 1
			until
				i > field_count (an_object)
			loop
				l_name := field_name (i, an_object)
				check l_name /= Void end
				if l_attributes.has (l_name) then
					j := l_attributes.item (l_name)
					inspect field_type (i, an_object)
					when reference_type then
						if an_attributes.is_reference_item (j) and then attached {STRING} an_attributes.reference_item (j) as l_id then
							if is_existing_id (l_id) and then attached object_for_id (l_id) as l_obj then
								if field_conforms_to (dynamic_type (l_obj), field_static_type_of_type (i, dynamic_type (an_object))) then
									set_reference_field (i, an_object, l_obj)
								end
							end
						end
					when boolean_type then
						if an_attributes.is_boolean_item (j) then
							set_boolean_field (i, an_object, an_attributes.boolean_item (j))
						end
					when character_8_type then
						if an_attributes.is_character_8_item (j) then
							set_character_8_field (i, an_object, an_attributes.character_8_item (j))
						end
					when character_32_type then
						if an_attributes.is_character_32_item (j) then
							set_character_32_field (i, an_object, an_attributes.character_32_item (j))
						end
					when integer_8_type then
						if an_attributes.is_integer_8_item (j) then
							set_integer_8_field (i, an_object, an_attributes.integer_8_item (j))
						end
					when integer_16_type then
						if an_attributes.is_integer_16_item (j) then
							set_integer_16_field (i, an_object, an_attributes.integer_16_item (j))
						end
					when integer_32_type then
						if an_attributes.is_integer_32_item (j) then
							set_integer_32_field (i, an_object, an_attributes.integer_32_item (j))
						end
					when integer_64_type then
						if an_attributes.is_integer_64_item (j) then
							set_integer_64_field (i, an_object, an_attributes.integer_64_item (j))
						end
					when natural_8_type then
						if an_attributes.is_natural_8_item (j) then
							set_natural_8_field (i, an_object, an_attributes.natural_8_item (j))
						end
					when natural_16_type then
						if an_attributes.is_natural_16_item (j) then
							set_natural_16_field (i, an_object, an_attributes.natural_16_item (j))
						end
					when natural_32_type then
						if an_attributes.is_natural_32_item (j) then
							set_natural_32_field (i, an_object, an_attributes.natural_32_item (j))
						end
					when natural_64_type then
						if an_attributes.is_natural_64_item (j) then
							set_natural_64_field (i, an_object, an_attributes.natural_64_item (j))
						end
					when real_32_type then
						if an_attributes.is_real_item (j) then
							set_real_field (i, an_object, an_attributes.real_item (j))
						end
					when real_64_type then
						if an_attributes.is_double_item (j) then
							set_double_field (i, an_object, an_attributes.double_item (j))
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
				i := i + 1
			end
		end

	resolved_attributes (an_attributes: TUPLE): detachable TUPLE
			-- New TUPLE object with object id string values from `an_attribute_list' replaced by the associated object.
		require
			an_attributes_attached: an_attributes /= Void
		local
			i: INTEGER
			l_values: SPECIAL [detachable separate ANY]
			l_reflector: REFLECTOR
			l_type: STRING_8
			--l_type_id: INTEGER
		do
			create l_reflector
			l_type := "TUPLE ["
			create l_values.make_filled (Void, an_attributes.count)
			from
				i := 0
			until
				i = an_attributes.count
			loop
		         if
					an_attributes.is_reference_item (i + 1) and then
					attached {STRING} an_attributes.reference_item (i + 1) as l_id and then
					is_existing_id (l_id)
				then
					l_values.put (object_for_id (l_id), i)
				else
					l_values.put (an_attributes.item (i + 1), i)
				end
				l_type.append ("separate ANY")
				i := i + 1
				if i < an_attributes.count then
					l_type.append (", ")
				else
					l_type.append (" ]")
				end
			end
			Result := l_reflector.new_tuple_from_special (l_reflector.dynamic_type_from_string (l_type), l_values)
		end


	set_tuple_attributes (a_tuple: TUPLE; an_attributes: TUPLE; a_offset: NATURAL)
			-- Set items of `a_tuple' with values from `an_attribute_list'.
		require
			a_tuple_attached: a_tuple /= Void
			an_attributes_attached: an_attributes /= Void
		local
			i, j: INTEGER
		do
			from
				i := 1
			until
				i > a_tuple.count or i > (an_attributes.count - a_offset.to_integer_32)
			loop
				j := i + a_offset.to_integer_32
				inspect
					a_tuple.item_code (i)
				when {TUPLE}.reference_code then
					if an_attributes.is_reference_item (j) and then attached {STRING} an_attributes.reference_item (j) as l_id then
						if is_existing_id (l_id) and then attached object_for_id (l_id) as l_obj then
							if a_tuple.valid_type_for_index (l_obj, i) then
								a_tuple.put_reference (l_obj, i)
							end
						end
					end
				when {TUPLE}.boolean_code then
					if an_attributes.is_boolean_item (j) then
						a_tuple.put_boolean (an_attributes.boolean_item (j), i)
					end
				when {TUPLE}.character_8_code then
					if an_attributes.is_character_8_item (j) then
						a_tuple.put_character_8 (an_attributes.character_8_item (j), i)
					end
				when {TUPLE}.character_32_code then
					if an_attributes.is_character_32_item (j) then
						a_tuple.put_character_32 (an_attributes.character_32_item (j), i)
					end
				when {TUPLE}.integer_8_code then
					if an_attributes.is_integer_8_item (j) then
						a_tuple.put_integer_8 (an_attributes.integer_8_item (j), i)
					end
				when {TUPLE}.integer_16_code then
					if an_attributes.is_integer_16_item (j) then
						a_tuple.put_integer_16 (an_attributes.integer_16_item (j), i)
					end
				when {TUPLE}.integer_32_code then
					if an_attributes.is_integer_32_item (j) then
						a_tuple.put_integer_32 (an_attributes.integer_32_item (j), i)
					end
				when {TUPLE}.integer_64_code then
					if an_attributes.is_integer_64_item (j) then
						a_tuple.put_integer_64 (an_attributes.integer_64_item (j), i)
					end
				when {TUPLE}.natural_8_code then
					if an_attributes.is_natural_8_item (j) then
						a_tuple.put_natural_8 (an_attributes.natural_8_item (j), i)
					end
				when {TUPLE}.natural_16_code then
					if an_attributes.is_natural_16_item (j) then
						a_tuple.put_natural_16 (an_attributes.natural_16_item (j), i)
					end
				when {TUPLE}.natural_32_code then
					if an_attributes.is_natural_32_item (j) then
						a_tuple.put_natural_32 (an_attributes.natural_32_item (j), i)
					end
				when {TUPLE}.natural_64_code then
					if an_attributes.is_natural_64_item (j) then
						a_tuple.put_natural_64 (an_attributes.natural_64_item (j), i)
					end
				when {TUPLE}.real_32_code then
					if an_attributes.is_real_item (j) then
						a_tuple.put_real (an_attributes.real_item (j), i)
					end
				when {TUPLE}.real_64_code then
					if an_attributes.is_double_item (j) then
						a_tuple.put_double (an_attributes.double_item (j), i)
					end
				when {TUPLE}.pointer_code then

				else
					assert_32 ("Tuple item type not supported", False)
				end
				i := i + 1
			end
		end

	set_special_attributes (a_special: SPECIAL [ANY]; an_attributes: TUPLE)
			-- Assign items of `an_attributes' to items of `a_special'.
		require
			a_special_attached: a_special /= Void
			an_attributes_attached: an_attributes /= Void
			attributes_uniform: is_valid_item_tuple (a_special, an_attributes)
		local
			i, l_type, l_gtype: INTEGER
			l_b_special: detachable SPECIAL [BOOLEAN]
			l_c8_special: detachable SPECIAL [CHARACTER_8]
			l_c32_special: detachable SPECIAL [CHARACTER_32]
			l_i8_special: detachable SPECIAL [INTEGER_8]
			l_i16_special: detachable SPECIAL [INTEGER_16]
			l_i32_special: detachable SPECIAL [INTEGER_32]
			l_i64_special: detachable SPECIAL [INTEGER_64]
			l_n8_special: detachable SPECIAL [NATURAL_8]
			l_n16_special: detachable SPECIAL [NATURAL_16]
			l_n32_special: detachable SPECIAL [NATURAL_32]
			l_n64_special: detachable SPECIAL [NATURAL_64]
			l_r_special: detachable SPECIAL [REAL]
			l_d_special: detachable SPECIAL [DOUBLE]
			l_p_special: detachable SPECIAL [POINTER]
		do
			if attached {SPECIAL [BOOLEAN]} a_special as l_s_b then
				l_b_special := l_s_b
				l_type := boolean_type
			elseif attached {SPECIAL [CHARACTER_8]} a_special as l_s_c8 then
				l_c8_special := l_s_c8
				l_type := character_8_type
			elseif attached {SPECIAL [CHARACTER_32]} a_special as l_s_c32 then
				l_c32_special := l_s_c32
				l_type := character_32_type
			elseif attached {SPECIAL [INTEGER_8]} a_special as l_s_i8 then
				l_i8_special := l_s_i8
				l_type := integer_8_type
			elseif attached {SPECIAL [INTEGER_16]} a_special as l_s_i16 then
				l_i16_special := l_s_i16
				l_type := integer_16_type
			elseif attached {SPECIAL [INTEGER_32]} a_special as l_s_i32 then
				l_i32_special := l_s_i32
				l_type := integer_32_type
			elseif attached {SPECIAL [INTEGER_64]} a_special as l_s_i64 then
				l_i64_special := l_s_i64
				l_type := integer_64_type
			elseif attached {SPECIAL [NATURAL_8]} a_special as l_s_n8 then
				l_n8_special := l_s_n8
				l_type := natural_8_type
			elseif attached {SPECIAL [NATURAL_16]} a_special as l_s_n16 then
				l_n16_special := l_s_n16
				l_type := natural_16_type
			elseif attached {SPECIAL [NATURAL_32]} a_special as l_s_n32 then
				l_n32_special := l_s_n32
				l_type := natural_32_type
			elseif attached {SPECIAL [NATURAL_64]} a_special as l_s_n64 then
				l_n64_special := l_s_n64
				l_type := natural_64_type
			elseif attached {SPECIAL [REAL]} a_special as l_s_r then
				l_r_special := l_s_r
				l_type := real_type
			elseif attached {SPECIAL [DOUBLE]} a_special as l_s_d then
				l_d_special := l_s_d
				l_type := double_type
			elseif attached {SPECIAL [POINTER]} a_special as l_s_p then
				l_p_special := l_s_p
				l_type := pointer_type
			else
				l_type := reference_type
				l_gtype := generic_dynamic_type (a_special, 1)
			end

			from
				i := 1
			until
				i > a_special.capacity or not an_attributes.valid_index (i)
			loop
				inspect
					l_type
				when reference_type then
					if attached {STRING} an_attributes.reference_item (i) as l_id then
						if is_existing_id (l_id) and then attached object_for_id (l_id) as l_obj then
							if field_conforms_to (dynamic_type (l_obj), l_gtype) then
								a_special.extend (l_obj)
							end
						end
					end
				when boolean_type then
					check l_b_special /= Void then
						l_b_special.extend (an_attributes.boolean_item (i))
					end
				when character_8_type then
					check l_c8_special /= Void then
						l_c8_special.extend (an_attributes.character_8_item (i))
					end
				when character_32_type then
					check l_c32_special /= Void then
						l_c32_special.extend (an_attributes.character_32_item (i))
					end
				when integer_8_type then
					check l_i8_special /= Void then
						l_i8_special.extend (an_attributes.integer_8_item (i))
					end
				when integer_16_type then
					check l_i16_special /= Void then
						l_i16_special.extend (an_attributes.integer_16_item (i))
					end
				when integer_32_type then
					check l_i32_special /= Void then
						l_i32_special.extend (an_attributes.integer_32_item (i))
					end
				when integer_64_type then
					check l_i64_special /= Void then
						l_i64_special.extend (an_attributes.integer_64_item (i))
					end
				when natural_8_type then
					check l_n8_special /= Void then
						l_n8_special.extend (an_attributes.natural_8_item (i))
					end
				when natural_16_type then
					check l_n16_special /= Void then
						l_n16_special.extend (an_attributes.natural_16_item (i))
					end
				when natural_32_type then
					check l_n32_special /= Void then
						l_n32_special.extend (an_attributes.natural_32_item (i))
					end
				when natural_64_type then
					check l_n64_special /= Void then
						l_n64_special.extend (an_attributes.natural_64_item (i))
					end
				when real_type then
					check l_r_special /= Void then
						l_r_special.extend (an_attributes.real_32_item (i))
					end
				when double_type then
					check l_d_special /= Void then
						l_d_special.extend (an_attributes.real_64_item (i))
					end
				when pointer_type then
					check l_p_special /= Void then
						l_p_special.extend (an_attributes.pointer_item (i))
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Constants

	dynamic_boolean_type: INTEGER once Result := ({BOOLEAN}).type_id end
	dynamic_character_8_type: INTEGER once Result := ({CHARACTER_8}).type_id end
	dynamic_character_32_type: INTEGER once Result := ({CHARACTER_32}).type_id end
	dynamic_integer_8_type: INTEGER once Result := ({INTEGER_8}).type_id end
	dynamic_integer_16_type: INTEGER once Result := ({INTEGER_16}).type_id end
	dynamic_integer_32_type: INTEGER once Result := ({INTEGER_32}).type_id end
	dynamic_integer_64_type: INTEGER once Result := ({INTEGER_64}).type_id end
	dynamic_natural_8_type: INTEGER once Result := ({NATURAL_8}).type_id end
	dynamic_natural_16_type: INTEGER once Result := ({NATURAL_16}).type_id end
	dynamic_natural_32_type: INTEGER once Result := ({NATURAL_32}).type_id end
	dynamic_natural_64_type: INTEGER once Result := ({NATURAL_64}).type_id end
	dynamic_real_32_type: INTEGER once Result := ({REAL_32}).type_id end
	dynamic_real_64_type: INTEGER once Result := ({REAL_64}).type_id end
	dynamic_pointer_type: INTEGER once Result := ({POINTER}).type_id end

	dynamic_string_8_type: INTEGER once Result := ({STRING_8}).type_id end
	dynamic_string_32_type: INTEGER once Result := ({STRING_32}).type_id end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
