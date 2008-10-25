indexing
	description: "[
		Sets of tests which make use of an extracted application state to reproduce a failure.
	]"
	author: ""
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

	context: !ARRAY [!TUPLE [type: !TYPE [ANY]; attributes: !TUPLE; inv: BOOLEAN]] is
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
			--                 strings refering to other objects in `context'.
			--             Otherwise attributes are pairs of the actual attribute name and the corresponding
			--                 value. Again this can be the values for manifest type, otherwise object ids.
			-- inv:        True if object must satisfy its invariants. False if object was part of call
			--                 stack when test was extracted, so it does not have to satisfy its invariants.
		deferred
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
			result_valid: a_id.is_equal (("#" + Result.out).as_attached)
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
			set_tuple_attributes (l_new, a_operands, 0)
			a_routine.call (l_new)
		end

feature {NONE} -- Object initialization

	fill_object_cache is
			-- Set up `object_under_test' and `routine_arguments' with content from `context'.
		local
			i: INTEGER
			l_type: INTEGER
			l_object: !ANY
			l_routine_attr_adj_success: BOOLEAN
		do
			create object_cache.make (context.lower, context.upper)
				-- Create instance for each object in `context'
			from
				i := context.lower
			until
				i > context.upper
			loop
				l_type := generic_dynamic_type (context.item (i).type, 1)
				if l_type = dynamic_string_8_type then
					if {l_string8_object: !STRING} context.item (i).attributes.item (1) then
						l_object := l_string8_object
					else
						assert ("first attribute of a STRING_8 object must be a string", False)
					end
				elseif l_type = dynamic_string_32_type then
					if {l_string32_object: !STRING} context.item (i).attributes.item (1) then
						l_object := l_string32_object
					else
						assert ("first attribute of a STRING_32 object must be a string", False)
					end
				elseif is_special_type (l_type) then
					l_object := create_special_object (l_type, context.item (i).attributes.count)
				else
					if {l_any: !ANY} new_instance_of (l_type) then
						l_object := l_any
					else
						assert ("objects of type " + type_name_of_type (l_type) + " are not supported", False)
					end
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
							-- First item of `an_attribute_list' describes whether
							-- `a_tuple' shall compare objects and not references
						if context.item (i).attributes.count > 0 and then context.item (i).attributes.is_boolean_item (1) then
							if context.item (i).attributes.boolean_item (1) then
								l_tuple_object.compare_objects
							else
								l_tuple_object.compare_references
							end
						else
							assert ("first item of tuple object must be boolean", False)
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

	create_special_object (a_type, a_count: INTEGER): !SPECIAL [ANY] is
			-- Creates a special object of type `a_class_name' for `a_count' elements.
		require
			a_type_valid: is_special_type (a_type)
		local
			l_gtype: INTEGER
		do
			l_gtype := generic_dynamic_type_of_type (a_type, 1)
			if is_special_any_type (a_type) then
				Result ?= new_special_any_instance (a_type, a_count)
			elseif l_gtype = dynamic_boolean_type then
				Result := create {SPECIAL [BOOLEAN]}.make (a_count)
			elseif l_gtype = dynamic_character_8_type then
				Result := create {SPECIAL [CHARACTER_8]}.make (a_count)
			elseif l_gtype = dynamic_character_32_type then
				Result := create {SPECIAL [CHARACTER_32]}.make (a_count)
			elseif l_gtype = dynamic_integer_8_type then
				Result := create {SPECIAL [INTEGER_8]}.make (a_count)
			elseif l_gtype = dynamic_integer_16_type then
				Result := create {SPECIAL [INTEGER_16]}.make (a_count)
			elseif l_gtype = dynamic_integer_32_type then
				Result := create {SPECIAL [INTEGER_32]}.make (a_count)
			elseif l_gtype = dynamic_integer_64_type then
				Result := create {SPECIAL [INTEGER_64]}.make (a_count)
			elseif l_gtype = dynamic_natural_8_type then
				Result := create {SPECIAL [NATURAL_8]}.make (a_count)
			elseif l_gtype = dynamic_natural_16_type then
				Result := create {SPECIAL [NATURAL_16]}.make (a_count)
			elseif l_gtype = dynamic_natural_32_type then
				Result := create {SPECIAL [NATURAL_32]}.make (a_count)
			elseif l_gtype = dynamic_natural_64_type then
				Result := create {SPECIAL [NATURAL_64]}.make (a_count)
			elseif l_gtype = dynamic_real_32_type then
				Result := create {SPECIAL [REAL]}.make (a_count)
			elseif l_gtype = dynamic_real_64_type then
				Result := create {SPECIAL [DOUBLE]}.make (a_count)
			elseif l_gtype = dynamic_pointer_type then
				Result := create {SPECIAL [POINTER]}.make (a_count)
			else
				assert ("special type not supported", False)
			end
		end

	set_attributes (an_object: !ANY; an_attributes: !TUPLE) is
			-- TODO: Missing header comment.
		require
			an_object_not_void: an_object /= Void
			an_object_valid: not is_tuple (an_object) and not is_special (an_object)
		local
			i, j: INTEGER
			l_attributes: HASH_TABLE [INTEGER, !STRING]
			l_obj: !ANY
		do
			create l_attributes.make (an_attributes.count // 2)
			from
				i := 1
			until
				not an_attributes.valid_index (i + 1)
			loop
				if an_attributes.is_reference_item (i) and then {l_key: !STRING} an_attributes.reference_item (i) then
					l_attributes.force (i + 1, l_key)
				else
					assert ("attribute tuple for normal object must always be a pair of strings and values", False)
				end
				i := i + 2
			end

			from
				i := 1
			until
				i > field_count (an_object)
			loop
				if {l_name: !STRING} field_name (i, an_object) then
					if l_attributes.has (l_name) then
						j := l_attributes.item (l_name)
						inspect field_type (i, an_object)
						when reference_type then
							if an_attributes.is_reference_item (j) and then {l_id: !STRING} an_attributes.reference_item (j) then
								if is_valid_id (l_id) and then is_existing_id (l_id) then
									l_obj := object_for_id (l_id)
									if type_conforms_to (dynamic_type (l_obj), field_static_type_of_type (i, dynamic_type (an_object))) then
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
				end
				i := i + 1
			end
		end

	set_tuple_attributes (a_tuple: !TUPLE; an_attributes: !TUPLE; a_offset: NATURAL) is
			-- Set items of `a_tuple' with values from `an_attribute_list'.
		local
			i, j: INTEGER
			l_value: !STRING
			l_obj: !ANY
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
					if an_attributes.is_reference_item (j) and then {l_id: !STRING} an_attributes.reference_item (j) then
						if is_valid_id (l_id) and then is_existing_id (l_id) then
							l_obj := object_for_id (l_id)
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
					assert ("Tuple item type not supported", False)
				end
				i := i + 1
			end
		end

	set_special_attributes (a_special: !SPECIAL [ANY]; an_attributes: !TUPLE) is
			-- Assign items of `an_attributes' to items of `a_special'.
		local
			i, l_type, l_gtype: INTEGER
			l_obj: !ANY
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
			l_gtype := generic_dynamic_type (a_special, 1)
			if is_special_any_type (dynamic_type (a_special)) then
				l_type := reference_type
			else
				if l_gtype = dynamic_boolean_type then
					l_b_special ?= a_special
					check not_void: l_b_special /= Void end
					l_type := boolean_type
				elseif l_gtype = dynamic_character_8_type then
					l_c8_special ?= a_special
					check not_void: l_c8_special /= Void end
					l_type := character_8_type
				elseif l_gtype = dynamic_character_32_type then
					l_c32_special ?= a_special
					check not_void: l_c32_special /= Void end
					l_type := character_32_type
				elseif l_gtype = dynamic_integer_8_type then
					l_i8_special ?= a_special
					check not_void: l_i8_special /= Void end
					l_type := integer_8_type
				elseif l_gtype = dynamic_integer_16_type then
					l_i16_special ?= a_special
					check not_void: l_i16_special /= Void end
					l_type := integer_16_type
				elseif l_gtype = dynamic_integer_32_type then
					l_i32_special ?= a_special
					check not_void: l_i32_special /= Void end
					l_type := integer_32_type
				elseif l_gtype = dynamic_integer_64_type then
					l_i64_special ?= a_special
					check not_void: l_i64_special /= Void end
					l_type := integer_64_type
				elseif l_gtype = dynamic_natural_8_type then
					l_n8_special ?= a_special
					check not_void: l_n8_special /= Void end
					l_type := natural_8_type
				elseif l_gtype = dynamic_natural_16_type then
					l_n16_special ?= a_special
					check not_void: l_n16_special /= Void end
					l_type := natural_16_type
				elseif l_gtype = dynamic_natural_32_type then
					l_n32_special ?= a_special
					check not_void: l_n32_special /= Void end
					l_type := natural_32_type
				elseif l_gtype = dynamic_natural_64_type then
					l_n64_special ?= a_special
					check not_void: l_n64_special /= Void end
					l_type := natural_64_type
				elseif l_gtype = dynamic_real_32_type then
					l_r_special ?= a_special
					check not_void: l_r_special /= Void end
					l_type := real_type
				elseif l_gtype = dynamic_real_64_type then
					l_d_special ?= a_special
					check not_void: l_d_special /= Void end
					l_type := double_type
				elseif l_gtype = dynamic_pointer_type then
					l_type := pointer_type
				end
			end

			from
				i := 1
			until
				i > a_special.capacity or not an_attributes.valid_index (i)
			loop
				inspect
					l_type
				when reference_type then
					if an_attributes.is_reference_item (i) and then {l_id: !STRING} an_attributes.reference_item (i) then
						if is_valid_id (l_id) and then is_existing_id (l_id) then
							l_obj := object_for_id (l_id)
							if type_conforms_to (dynamic_type (l_obj), l_gtype) then
								a_special.put (l_obj, i-1)
							end
						end
					end
				when boolean_type then
					if an_attributes.is_boolean_item (i) then
						l_b_special.put (an_attributes.boolean_item (i), i-1)
					end
				when character_8_type then
					if an_attributes.is_character_8_item (i) then
						l_c8_special.put (an_attributes.character_8_item (i), i-1)
					end
				when character_32_type then
					if an_attributes.is_character_32_item (i) then
						l_c32_special.put (an_attributes.character_32_item (i), i-1)
					end
				when integer_8_type then
					if an_attributes.is_integer_8_item (i) then
						l_i8_special.put (an_attributes.integer_8_item (i), i-1)
					end
				when integer_16_type then
					if an_attributes.is_integer_16_item (i) then
						l_i16_special.put (an_attributes.integer_16_item (i), i-1)
					end
				when integer_32_type then
					if an_attributes.is_integer_32_item (i) then
						l_i32_special.put (an_attributes.integer_32_item (i), i-1)
					end
				when integer_64_type then
					if an_attributes.is_integer_64_item (i) then
						l_i64_special.put (an_attributes.integer_64_item (i), i-1)
					end
				when natural_8_type then
					if an_attributes.is_natural_8_item (i) then
						l_n8_special.put (an_attributes.natural_8_item (i), i-1)
					end
				when natural_16_type then
					if an_attributes.is_natural_16_item (i) then
						l_n16_special.put (an_attributes.natural_16_item (i), i-1)
					end
				when natural_32_type then
					if an_attributes.is_natural_32_item (i) then
						l_n32_special.put (an_attributes.natural_32_item (i), i-1)
					end
				when natural_64_type then
					if an_attributes.is_natural_64_item (i) then
						l_n64_special.put (an_attributes.natural_64_item (i), i-1)
					end
				when real_32_type then
					if an_attributes.is_real_item (i) then
						l_r_special.put (an_attributes.real_32_item (i), i-1)
					end
				when real_64_type then
					if an_attributes.is_double_item (i) then
						l_d_special.put (an_attributes.real_64_item (i), i-1)
					end
				when pointer_type then
						-- Do nothing. I.e. leave the tuple item at the default value.
				end
				i := i + 1
			end
		end

feature {NONE} -- Constants

	dynamic_boolean_type: INTEGER once Result := dynamic_type_from_string ((False).generating_type) end
	dynamic_character_8_type: INTEGER once Result := dynamic_type_from_string (({CHARACTER_8} '%U').generating_type) end
	dynamic_character_32_type: INTEGER once Result := dynamic_type_from_string (({CHARACTER_32} '%U').generating_type) end
	dynamic_integer_8_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_8} 0).generating_type) end
	dynamic_integer_16_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_16} 0).generating_type) end
	dynamic_integer_32_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_32} 0).generating_type) end
	dynamic_integer_64_type: INTEGER once Result := dynamic_type_from_string (({INTEGER_64} 0).generating_type) end
	dynamic_natural_8_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_8} 0).generating_type) end
	dynamic_natural_16_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_16} 0).generating_type) end
	dynamic_natural_32_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_32} 0).generating_type) end
	dynamic_natural_64_type: INTEGER once Result := dynamic_type_from_string (({NATURAL_64} 0).generating_type) end
	dynamic_real_32_type: INTEGER once Result := dynamic_type_from_string (({REAL_32} 0.0).generating_type) end
	dynamic_real_64_type: INTEGER once Result := dynamic_type_from_string (({REAL_64} 0.0).generating_type) end
	dynamic_pointer_type: INTEGER once Result := dynamic_type_from_string ((default_pointer).generating_type) end

	dynamic_string_8_type: INTEGER once Result := dynamic_type_from_string ((create {STRING_8}.make_empty).generating_type) end
	dynamic_string_32_type: INTEGER once Result := dynamic_type_from_string ((create {STRING_32}.make_empty).generating_type) end

end
