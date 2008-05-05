indexing
	description: "Decoding of arbitrary objects graphs within a session of a same program."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_SESSION_DESERIALIZER

inherit
	SED_UTILITIES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_deserializer: SED_READER_WRITER) is
			-- Initialize current instance
		require
			a_deserializer_not_void: a_deserializer /= Void
			a_deserializer_ready: a_deserializer.is_ready_for_reading
		do
			create internal
			create object_references.make (1)
			deserializer := a_deserializer
		ensure
			deserializer_set: deserializer = a_deserializer
		end

feature -- Access

	deserializer: SED_READER_WRITER
			-- Serializer used to decode data

	last_decoded_object: ?ANY
			-- Object decoded during last call to `decode'

feature -- Status report

	has_error: BOOLEAN
			-- Did we encounter an error during retrieval?

feature -- Settings

	set_deserializer (a_deserializer: like deserializer) is
			-- Set `deserializer' with `a_deserializer'.
		require
			a_deserializer_not_void: a_deserializer /= Void
			a_deserializer_ready: a_deserializer.is_ready_for_reading
		do
			deserializer := a_deserializer
		ensure
			deserializer_set: deserializer = a_deserializer
		end

feature -- Basic operations

	decode (a_is_gc_enabled: BOOLEAN) is
			-- Decode object graph stored in `deserializer'.
		local
			l_count: NATURAL_32
			l_mem: ?like memory
			l_is_collecting: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				has_error := False

					-- Read number of objects we are retrieving
				l_count := deserializer.read_compressed_natural_32
				create object_references.make (l_count.to_integer_32 + 1)

					-- Disable GC as only new memory will be allocated.
				if not a_is_gc_enabled then
					l_mem := memory
					l_is_collecting := l_mem.collecting
					l_mem.collection_off
				end

					-- Read header of serialized data.
				read_header (l_count)

				if not has_error then
						-- Read data from `deserializer' in store it in `object_references'.
					decode_objects (l_count)
				end
			end
				-- Restore GC status
			if l_is_collecting and then l_mem /= Void then
				l_mem.collection_on
			end

				-- Clean data
			clear_internal_data
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: Access

	internal: INTERNAL
			-- Facilities to inspect.

	object_references: SPECIAL [ANY]
			-- Mapping between reference ID and the associated object.

	missing_references: ?SPECIAL [?ARRAYED_LIST [like new_tuple]]
			-- When decoding an object some of its references might not be decoded yet, so
			-- we store the object index, the field position in this object and the reference id.

	is_for_fast_retrieval: BOOLEAN
			-- Was current data stored for fast retrieval?

feature {NONE} -- Implementation: Settings

	set_has_error is
			-- Set `has_error' to True.
		do
			has_error := True
		ensure
			has_error_set: has_error
		end

feature {NONE} -- Cleaning

	clear_internal_data is
			-- Clear all allocated data
		local
			l: like list_stack
			t: like tuple_stack
		do
			missing_references := Void
			create object_references.make (0)
			t := tuple_stack
			if t /= Void then
				t.wipe_out
				tuple_stack := Void
			end
			l := list_stack
			if l /= Void then
				l.wipe_out
				list_stack := Void
			end
		end

feature {NONE} -- Implementation

	read_header (a_count: NATURAL_32) is
			-- Read header of serialized data which has `a_count' objects.
		do
			read_object_table (a_count)
		end

	read_object_table (a_count: NATURAL_32) is
			-- Read object table if any, which has `a_count' objects.
		local
			l_objs: like object_references
			l_deser: like deserializer
			l_int: like internal
			l_mem: like memory
			l_is_collecting: BOOLEAN
			l_nat32: NATURAL_32
			l_ref_id: INTEGER
			l_dtype: INTEGER
			i, nb: INTEGER
			l_obj: ANY
		do
			if deserializer.read_boolean then
				is_for_fast_retrieval := True
				l_mem := memory
				l_is_collecting := l_mem.collecting
				l_deser := deserializer
				l_int := internal
				l_objs := object_references
				from
					i := 0
					nb := a_count.to_integer_32
				until
					i = nb
				loop
					if l_is_collecting and then i // 2000 = 0 then
						l_mem.collection_off
					end
						-- Read dynamic type
					l_dtype := new_dynamic_type_id (l_deser.read_compressed_natural_32.to_integer_32)
						-- Read reference id
					l_nat32 := deserializer.read_compressed_natural_32
					check
						l_nat32_valid: l_nat32 > 0 and l_nat32 < {INTEGER}.max_value.as_natural_32
					end
					l_ref_id := l_nat32.to_integer_32

						-- Read object flags
					inspect
						l_deser.read_natural_8
					when is_special_flag then
							-- We need to first read the `item_type' of the SPECIAL,
							-- and then its count.
						l_obj := new_special_instance (l_dtype,
							l_deser.read_compressed_integer_32,
							l_deser.read_compressed_integer_32)
					when is_tuple_flag then
						l_obj := l_int.new_instance_of (l_dtype)
					else
						l_obj := l_int.new_instance_of (l_dtype)
					end

					l_objs.put (l_obj, l_ref_id)
					i := i + 1
				end
				if l_is_collecting then
					l_mem.collection_on
				end
			else
				is_for_fast_retrieval := False
			end
		end

	new_dynamic_type_id (a_old_type_id: INTEGER): INTEGER is
			-- Given `a_old_type_id', dynamic type id in stored system, retrieve dynamic
			-- type id in current system.
		require
			a_old_type_id_non_negative: a_old_type_id >= 0
		do
			Result := a_old_type_id
		ensure
			new_dynamic_type_id_non_negative: Result >= 0
		end

	new_attribute_offset (a_new_type_id, a_old_offset: INTEGER): INTEGER is
			-- Given attribute offset `a_old_offset' in the stored object whose dynamic type id
			-- is now `a_new_type_id', retrieve new offset in `a_new_type_id'.
		require
			a_new_type_id_non_negative: a_new_type_id >= 0
			a_old_offset_positive: a_old_offset > 0
		do
			Result := a_old_offset
		ensure
			new_attribute_offset_positive: Result > 0
		end

	decode_objects (a_count: NATURAL_32) is
			-- Decode `a_count' object from `deserializer' and store root object in `last_decoded_object'.
		require
			a_count_positive: a_count > 0
		local
			i: NATURAL_32
		do
					-- Decode root object
			decode_object (True)
					-- Decode remaining objects
			from
				i := 1
			until
				i = a_count
			loop
				decode_object (False)
				i := i + 1
			end
		end

	decode_object (is_root: BOOLEAN) is
			-- Decode one object and store it in `last_decoded_object' if `is_root'.
		local
			l_dtype: INTEGER
			l_deser: like deserializer
			l_int: like internal
			l_spec_mapping: like special_type_mapping
			l_obj: ANY
			l_nat32: NATURAL_32
			l_index: INTEGER
			l_flags: NATURAL_8
			l_spec_type, l_spec_count: INTEGER
		do
			l_deser := deserializer
			l_int := internal
			l_spec_mapping := special_type_mapping

			if is_for_fast_retrieval then
					-- Read reference ID.
				l_nat32 := l_deser.read_compressed_natural_32
				check
					l_nat32_valid: l_nat32 < {INTEGER}.max_value.as_natural_32
				end
				l_index := l_nat32.to_integer_32

				l_obj := object_references.item (l_index)
				l_dtype := l_int.dynamic_type (l_obj)

				if l_int.is_special (l_obj) then
						-- Get the abstract element type of the SPECIAL.
					l_spec_mapping.search (l_int.generic_dynamic_type_of_type (l_dtype, 1))
					if l_spec_mapping.found then
						l_spec_type := l_spec_mapping.found_item
					else
						l_spec_type := {INTERNAL}.reference_type
					end

					decode_special (l_obj, l_index, l_spec_type)
				elseif l_int.is_tuple (l_obj) then
					decode_tuple (l_obj, l_dtype, l_index)
				else
					decode_normal_object (l_obj, l_dtype, l_index)
				end
			else
					-- Read object dynamic type
				l_dtype := new_dynamic_type_id (l_deser.read_compressed_natural_32.to_integer_32)

					-- Read reference ID.
				l_nat32 := l_deser.read_compressed_natural_32
				check
					l_nat32_valid: l_nat32 < {INTEGER}.max_value.as_natural_32
				end
				l_index := l_nat32.to_integer_32

					-- Read object flags.
				l_flags := l_deser.read_natural_8

				inspect l_flags
				when is_special_flag then
					l_spec_type := l_deser.read_compressed_integer_32
					l_spec_count := l_deser.read_compressed_integer_32
					l_obj := new_special_instance (l_dtype, l_spec_type, l_spec_count)
					object_references.put (l_obj, l_index)
						-- Reconnect un-connected object to `l_obj' we found so far.
					reconnect_object (l_index)
					decode_special (l_obj, l_index, l_spec_type)
				when is_tuple_flag then
					l_obj := l_int.new_instance_of (l_dtype)
					object_references.put (l_obj, l_index)
						-- Reconnect un-connected object to `l_obj' we found so far.
					reconnect_object (l_index)
					decode_tuple (l_obj, l_dtype, l_index)
				else
					l_obj := l_int.new_instance_of (l_dtype)
					object_references.put (l_obj, l_index)
						-- Reconnect un-connected object to `l_obj' we found so far.
					reconnect_object (l_index)
					decode_normal_object (l_obj, l_dtype, l_index)
				end
			end
			if is_root then
				last_decoded_object := l_obj
			end
		end

	decode_normal_object (an_obj: ANY; a_dtype, an_index: INTEGER) is
			-- Decode an object of type `dtype' and index `an_index' in `an_obj'.
		require
			an_obj_not_void: an_obj /= Void
			an_obj_valid: internal.dynamic_type (an_obj) = a_dtype
			a_dtype_non_negative: a_dtype >= 0
			an_index_non_negative: an_index >= 0
		local
			l_int: like internal
			l_deser: like deserializer
			i, nb: INTEGER
			l_new_offset: INTEGER
		do
			l_int := internal
			l_deser := deserializer

			from
				i := 1
				nb := l_int.field_count_of_type (a_dtype) + 1
			until
				i = nb
			loop
				l_new_offset := new_attribute_offset (a_dtype, i)
				inspect l_int.field_type_of_type (l_new_offset, a_dtype)
				when {INTERNAL}.boolean_type then
					l_int.set_boolean_field (l_new_offset, an_obj, l_deser.read_boolean)

				when {INTERNAL}.character_8_type then
					l_int.set_character_8_field (l_new_offset, an_obj, l_deser.read_character_8)
				when {INTERNAL}.character_32_type then
					l_int.set_character_32_field (l_new_offset, an_obj, l_deser.read_character_32)

				when {INTERNAL}.natural_8_type then
					l_int.set_natural_8_field (l_new_offset, an_obj, l_deser.read_natural_8)
				when {INTERNAL}.natural_16_type then
					l_int.set_natural_16_field (l_new_offset, an_obj, l_deser.read_natural_16)
				when {INTERNAL}.natural_32_type then
					l_int.set_natural_32_field (l_new_offset, an_obj, l_deser.read_natural_32)
				when {INTERNAL}.natural_64_type then
					l_int.set_natural_64_field (l_new_offset, an_obj, l_deser.read_natural_64)

				when {INTERNAL}.integer_8_type then
					l_int.set_integer_8_field (l_new_offset, an_obj, l_deser.read_integer_8)
				when {INTERNAL}.integer_16_type then
					l_int.set_integer_16_field (l_new_offset, an_obj, l_deser.read_integer_16)
				when {INTERNAL}.integer_32_type then
					l_int.set_integer_32_field (l_new_offset, an_obj, l_deser.read_integer_32)
				when {INTERNAL}.integer_64_type then
					l_int.set_integer_64_field (l_new_offset, an_obj, l_deser.read_integer_64)

				when {INTERNAL}.real_32_type then
					l_int.set_real_32_field (l_new_offset, an_obj, l_deser.read_real_32)
				when {INTERNAL}.real_64_type then
					l_int.set_real_64_field (l_new_offset, an_obj, l_deser.read_real_64)

				when {INTERNAL}.pointer_type then
					l_int.set_pointer_field (l_new_offset, an_obj, l_deser.read_pointer)

				when {INTERNAL}.reference_type then
					decode_reference (an_obj, an_index, l_new_offset)

				else
					check
						False
					end
				end
				i := i + 1
			end
		end

	decode_tuple (an_obj: ANY; a_dtype, an_index: INTEGER) is
			-- Decode TUPLE object of type `a_dtype' and index `an_index' in `an_obj'.
		require
			an_obj_not_void: an_obj /= Void
			an_obj_valid: internal.dynamic_type (an_obj) = a_dtype
			an_obj_is_tuple: internal.is_tuple (an_obj)
			a_dtype_non_negative: a_dtype >= 0
			an_index_non_negative: an_index >= 0
		local
			l_deser: like deserializer
			i, nb: INTEGER
		do
			l_deser := deserializer
			if {l_tuple: TUPLE} an_obj then
				from
					i := 1
					nb := l_tuple.count + 1
				until
					i = nb
				loop
					inspect l_deser.read_natural_8
					when {TUPLE}.boolean_code then l_tuple.put_boolean (l_deser.read_boolean, i)

					when {TUPLE}.character_8_code then l_tuple.put_character_8 (l_deser.read_character_8, i)
					when {TUPLE}.character_32_code then l_tuple.put_character_32 (l_deser.read_character_32, i)

					when {TUPLE}.natural_8_code then l_tuple.put_natural_8 (l_deser.read_natural_8, i)
					when {TUPLE}.natural_16_code then l_tuple.put_natural_16 (l_deser.read_natural_16, i)
					when {TUPLE}.natural_32_code then l_tuple.put_natural_32 (l_deser.read_natural_32, i)
					when {TUPLE}.natural_64_code then l_tuple.put_natural_64 (l_deser.read_natural_64, i)

					when {TUPLE}.integer_8_code then l_tuple.put_integer_8 (l_deser.read_integer_8, i)
					when {TUPLE}.integer_16_code then l_tuple.put_integer_16 (l_deser.read_integer_16, i)
					when {TUPLE}.integer_32_code then l_tuple.put_integer_32 (l_deser.read_integer_32, i)
					when {TUPLE}.integer_64_code then l_tuple.put_integer_64 (l_deser.read_integer_64, i)

					when {TUPLE}.real_32_code then l_tuple.put_real_32 (l_deser.read_real_32, i)
					when {TUPLE}.real_64_code then l_tuple.put_real_64 (l_deser.read_real_64, i)

					when {TUPLE}.pointer_code then l_tuple.put_pointer (l_deser.read_pointer, i)

					when {TUPLE}.reference_code then decode_reference (l_tuple, an_index, i)
					else
						check
							False
						end
					end
					i := i + 1
				end
			end
		end

	new_special_instance (a_dtype, a_item_type, a_count: INTEGER): ANY is
			-- Create new special instance of a special object whose dynamic
			-- type is `a_dtype', whose element abstract type is `a_item_type'
			-- and of count `a_count'.
		require
			a_dtype_non_negative: a_dtype >= 0
			a_item_type_non_negative: a_item_type >= 0
			a_count_non_negative: a_count >= 0
		do
			inspect a_item_type
			when {INTERNAL}.boolean_type then create {SPECIAL [BOOLEAN]} Result.make (a_count)

			when {INTERNAL}.character_8_type then create {SPECIAL [CHARACTER_8]} Result.make (a_count)
			when {INTERNAL}.character_32_type then create {SPECIAL [CHARACTER_32]} Result.make (a_count)

			when {INTERNAL}.natural_8_type then create {SPECIAL [NATURAL_8]} Result.make (a_count)
			when {INTERNAL}.natural_16_type then create {SPECIAL [NATURAL_16]} Result.make (a_count)
			when {INTERNAL}.natural_32_type then create {SPECIAL [NATURAL_32]} Result.make (a_count)
			when {INTERNAL}.natural_64_type then create {SPECIAL [NATURAL_64]} Result.make (a_count)

			when {INTERNAL}.integer_8_type then create {SPECIAL [INTEGER_8]} Result.make (a_count)
			when {INTERNAL}.integer_16_type then create {SPECIAL [INTEGER_16]} Result.make (a_count)
			when {INTERNAL}.integer_32_type then create {SPECIAL [INTEGER]} Result.make (a_count)
			when {INTERNAL}.integer_64_type then create {SPECIAL [INTEGER_64]} Result.make (a_count)

			when {INTERNAL}.real_32_type then create {SPECIAL [REAL]} Result.make (a_count)
			when {INTERNAL}.real_64_type then create {SPECIAL [DOUBLE]} Result.make (a_count)

			when {INTERNAL}.pointer_type then create {SPECIAL [POINTER]} Result.make (a_count)
			else
				Result := internal.new_special_any_instance (a_dtype, a_count)
			end
		ensure
			new_special_instance_not_void: Result /= Void
			new_special_instance_is_special: internal.is_special (Result)
		end

	decode_special (an_obj: ANY; an_index, an_item_type: INTEGER) is
			-- Decode SPECIAL object of index `an_index' and element type `an_item_type' in `an_obj'.
		require
			an_obj_not_void: an_obj /= Void
			an_obj_is_special: internal.is_special (an_obj)
			an_index_non_negative: an_index >= 0
		do
			inspect an_item_type
			when {INTERNAL}.boolean_type then
				if {l_spec_boolean: SPECIAL [BOOLEAN]} an_obj then
					decode_special_boolean (l_spec_boolean)
				else
					check l_spec_boolean_not_void: False end
				end

			when {INTERNAL}.character_8_type then
				if {l_spec_character_8: SPECIAL [CHARACTER_8]} an_obj then
					decode_special_character_8 (l_spec_character_8)
				else
					check l_spec_character_8_not_void: False end
				end

			when {INTERNAL}.character_32_type then
				if {l_spec_character_32: SPECIAL [CHARACTER_32]} an_obj then
					decode_special_character_32 (l_spec_character_32)
				else
					check l_spec_character_32_not_void: False end
				end

			when {INTERNAL}.natural_8_type then
				if {l_spec_natural_8: SPECIAL [NATURAL_8]} an_obj then
					decode_special_natural_8 (l_spec_natural_8)
				else
					check l_spec_natural_8_not_void: False end
				end

			when {INTERNAL}.natural_16_type then
				if {l_spec_natural_16: SPECIAL [NATURAL_16]} an_obj then
					decode_special_natural_16 (l_spec_natural_16)
				else
					check l_spec_natural_16_not_void: False end
				end

			when {INTERNAL}.natural_32_type then
				if {l_spec_natural_32: SPECIAL [NATURAL_32]} an_obj then
					decode_special_natural_32 (l_spec_natural_32)
				else
					check l_spec_natural_32_not_void: False end
				end

			when {INTERNAL}.natural_64_type then
				if {l_spec_natural_64: SPECIAL [NATURAL_64]} an_obj then
					decode_special_natural_64 (l_spec_natural_64)
				else
					check l_spec_natural_64_not_void: False end
				end

			when {INTERNAL}.integer_8_type then
				if {l_spec_integer_8: SPECIAL [INTEGER_8]} an_obj then
					decode_special_integer_8 (l_spec_integer_8)
				else
					check l_spec_integer_8_not_void: False end
				end

			when {INTERNAL}.integer_16_type then
				if {l_spec_integer_16: SPECIAL [INTEGER_16]} an_obj then
					decode_special_integer_16 (l_spec_integer_16)
				else
					check l_spec_integer_16_not_void: False end
				end

			when {INTERNAL}.integer_32_type then
				if {l_spec_integer_32: SPECIAL [INTEGER]} an_obj then
					decode_special_integer_32 (l_spec_integer_32)
				else
					check l_spec_integer_32_not_void: False end
				end

			when {INTERNAL}.integer_64_type then
				if {l_spec_integer_64: SPECIAL [INTEGER_64]} an_obj then
					decode_special_integer_64 (l_spec_integer_64)
				else
					check l_spec_integer_64_not_void: False end
				end

			when {INTERNAL}.real_32_type then
				if {l_spec_real_32: SPECIAL [REAL]} an_obj then
					decode_special_real_32 (l_spec_real_32)
				else
					check l_spec_real_32_not_void: False end
				end

			when {INTERNAL}.real_64_type then
				if {l_spec_real_64: SPECIAL [DOUBLE]} an_obj then
					decode_special_real_64 (l_spec_real_64)
				else
					check l_spec_real_64_not_void: False end
				end

			when {INTERNAL}.pointer_type then
				if {l_spec_pointer: SPECIAL [POINTER]} an_obj then
					decode_special_pointer (l_spec_pointer)
				else
					check l_spec_pointer_not_void: False end
				end

			else
				check an_item_type_valid: an_item_type = {INTERNAL}.reference_type end
				if {l_spec_any: SPECIAL [ANY]} an_obj then
					decode_special_reference (l_spec_any, an_index)
				else
					check l_spec_any_not_void: False end
				end
			end
		end

	decode_special_boolean (a_spec: SPECIAL [BOOLEAN]) is
			-- Decode SPECIAL [BOOLEAN].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_boolean, i)
				i := i + 1
			end
		end

	decode_special_character_8 (a_spec: SPECIAL [CHARACTER_8]) is
			-- Decode SPECIAL [CHARACTER_8].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_character_8, i)
				i := i + 1
			end
		end

	decode_special_character_32 (a_spec: SPECIAL [CHARACTER_32]) is
			-- Decode SPECIAL [CHARACTER_32].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_character_32, i)
				i := i + 1
			end
		end

	decode_special_natural_8 (a_spec: SPECIAL [NATURAL_8]) is
			-- Decode SPECIAL [NATURAL_8].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_natural_8, i)
				i := i + 1
			end
		end

	decode_special_natural_16 (a_spec: SPECIAL [NATURAL_16]) is
			-- Decode SPECIAL [NATURAL_16].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_natural_16, i)
				i := i + 1
			end
		end

	decode_special_natural_32 (a_spec: SPECIAL [NATURAL_32]) is
			-- Decode SPECIAL [NATURAL_32].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_natural_32, i)
				i := i + 1
			end
		end

	decode_special_natural_64 (a_spec: SPECIAL [NATURAL_64]) is
			-- Decode SPECIAL [NATURAL_64].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_natural_64, i)
				i := i + 1
			end
		end

	decode_special_integer_8 (a_spec: SPECIAL [INTEGER_8]) is
			-- Decode SPECIAL [INTEGER_8].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_integer_8, i)
				i := i + 1
			end
		end

	decode_special_integer_16 (a_spec: SPECIAL [INTEGER_16]) is
			-- Decode SPECIAL [INTEGER_16].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_integer_16, i)
				i := i + 1
			end
		end

	decode_special_integer_32 (a_spec: SPECIAL [INTEGER]) is
			-- Decode SPECIAL [INTEGER].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_integer_32, i)
				i := i + 1
			end
		end

	decode_special_integer_64 (a_spec: SPECIAL [INTEGER_64]) is
			-- Decode SPECIAL [INTEGER_64].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_integer_64, i)
				i := i + 1
			end
		end

	decode_special_real_32 (a_spec: SPECIAL [REAL]) is
			-- Decode SPECIAL [REAL].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_real_32, i)
				i := i + 1
			end
		end

	decode_special_real_64 (a_spec: SPECIAL [DOUBLE]) is
			-- Decode SPECIAL [DOUBLE].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_real_64, i)
				i := i + 1
			end
		end

	decode_special_pointer (a_spec: SPECIAL [POINTER]) is
			-- Decode SPECIAL [POINTER].
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_deser: like deserializer
		do
			from
				l_deser := deserializer
				nb := a_spec.count
			until
				i = nb
			loop
				a_spec.put (l_deser.read_pointer, i)
				i := i + 1
			end
		end

	decode_special_reference (a_spec: SPECIAL [ANY]; an_index: INTEGER) is
			-- Decode SPECIAL [ANY] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			i, nb: INTEGER
		do
			from
				nb := a_spec.count
			until
				i = nb
			loop
				decode_reference (a_spec, an_index, i)
				i := i + 1
			end
		end

	decode_reference (an_obj: ANY; an_obj_index, an_index: INTEGER) is
			-- Read reference and if found update `an_obj'
			-- with found reference at `an_index' in `an_obj'.
			-- If `an_obj' is a SPECIAL, then `an_index' is actually a SPECIAL index.
		require
			an_obj_not_void: an_obj /= Void
			an_index_non_negative: an_index >= 0
			an_index_positive_for_normal_object: not internal.is_special (an_obj) implies an_index > 0
		local
			l_nat32: NATURAL_32
			l_index: INTEGER
			l_sub_obj: ANY
			l_list: ?ARRAYED_LIST [like new_tuple]
			l_tuple: like new_tuple
			l_missing: like missing_references
		do
			l_nat32 := deserializer.read_compressed_natural_32
			if l_nat32 /= 0 then
				check
					l_nat32_valid: l_nat32 < {INTEGER}.max_value.as_natural_32
				end
				l_index := l_nat32.to_integer_32
				l_sub_obj := object_references.item (l_index)
				if l_sub_obj /= Void then
					update_reference (an_obj, l_sub_obj, an_index)
				else
					l_missing := missing_references
					if l_missing = Void then
						create l_missing.make (object_references.count)
						missing_references := l_missing
					end
					l_list := l_missing.item (l_index)
					if l_list = Void then
						l_list := new_list
						l_missing.put (l_list, l_index)
					end
					l_tuple := new_tuple
					l_tuple.object_index := an_obj_index
					l_tuple.field_position := an_index
					l_list.extend (l_tuple)
				end
			end
		end

	update_reference (an_obj, a_sub_obj: ANY; an_index: INTEGER) is
			-- Connect `a_sub_obj' to `an_obj' at `an_index' position
			-- which can be a field, special or tuple position depending
			-- on type of `an_obj'.
		require
			an_obj_not_void: an_obj /= Void
			an_index_non_negative: an_index >= 0
			an_index_positive_for_normal_object: not internal.is_special (an_obj) implies an_index > 0
		local
			l_int: like internal
		do
			l_int := internal

			if l_int.is_special (an_obj) then
				if {l_spec: SPECIAL [ANY]} an_obj then
					l_spec.put (a_sub_obj, an_index)
				end
			elseif l_int.is_tuple (an_obj) then
				if {l_tuple: TUPLE} an_obj then
					l_tuple.put_reference (a_sub_obj, an_index)
				end
			else
				l_int.set_reference_field (an_index, an_obj, a_sub_obj)
			end
		end

	reconnect_object (an_index: INTEGER) is
			-- Reconnect missing references to `an_index'.
		local
			l_missing_references: like missing_references
			l_object_references: like object_references
			l_tuple: like new_tuple
			l_list: ?ARRAYED_LIST [like new_tuple]
			l_tuple_stack: like tuple_stack
			l_list_stack: like list_stack
		do
			l_missing_references := missing_references
			if l_missing_references /= Void then
				l_list := l_missing_references.item (an_index)
				if l_list /= Void and then not l_list.is_empty then
					from
						l_object_references := object_references
						l_tuple_stack := tuple_stack
						if l_tuple_stack = Void then
							create l_tuple_stack.make (l_list.count)
							tuple_stack := l_tuple_stack
						end
						l_list.finish
					until
						l_list.off
					loop
						l_tuple := l_list.item
						update_reference (
							l_object_references.item (l_tuple.object_index),
							l_object_references.item (an_index),
							l_tuple.field_position)
						l_tuple_stack.extend (l_tuple)
						l_list.remove
						l_list.finish
					end
				end
				if l_list /= Void then
					l_list_stack := list_stack
					if l_list_stack = Void then
						create l_list_stack.make (1)
						list_stack := l_list_stack
					end
					l_list_stack.extend (l_list)
				end
				l_missing_references.put (Void, an_index)
			end
		end

	new_tuple: TUPLE [object_index: INTEGER; field_position: INTEGER] is
			-- Factory of TUPLE.
		local
			l_tuple_stack: like tuple_stack
		do
			l_tuple_stack := tuple_stack
			if l_tuple_stack /= Void and then not l_tuple_stack.is_empty then
				Result := l_tuple_stack.item
				l_tuple_stack.remove
			else
				create Result
			end
		ensure
			new_tuple_not_void: Result /= Void
		end

	new_list: ARRAYED_LIST [like new_tuple] is
			-- Factory of TUPLE.
		local
			l_list_stack: like list_stack
		do
			l_list_stack := list_stack
			if l_list_stack /= Void and then not l_list_stack.is_empty then
				Result := l_list_stack.item
				l_list_stack.remove
			else
				create Result.make (5)
			end
		ensure
			new_list_not_void: Result /= Void
		end

	tuple_stack: ?ARRAYED_STACK [like new_tuple]
			-- Storage for `new_tuple'.

	list_stack: ?ARRAYED_STACK [like new_list]
			-- Storage for `new_list'.

	memory: MEMORY is
			-- Access to MEMORY features without having to create a new instance each time.
		once
			create Result
		ensure
			memory_not_void: Result /= Void
		end

invariant
	internal_not_void: internal /= Void
	deserializer_not_void: deserializer /= Void
	object_references_not_void: object_references /= Void

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
