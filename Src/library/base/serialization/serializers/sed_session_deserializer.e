indexing
	description: "Decoding of arbitrary objects graphs within a session of a same program."
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

	last_decoded_object: ANY
			-- Object decoded during last call to `decode'

feature -- Basic operations

	decode is
			-- Decode object graph stored in `deserializer'.
		local
			l_count: NATURAL_32
		do
				-- Write number of objects we are storing
			l_count := deserializer.read_compressed_natural_32
			create object_references.make (l_count.to_integer_32 + 1)

				-- Read header of serialized data.
			read_header

				-- Read data from `deserializer' in store it in `object_references'.
			decode_objects (l_count)

				-- Reconnect all inter-object references that could not be reconnected
				-- during `decode_objects'.
			reconnect_objects
		end

feature {NONE} -- Implementation: Access

	internal: INTERNAL
			-- Facilities to inspect.

	object_references: SPECIAL [ANY]
			-- Mapping between reference ID and the associated object.

	missing_references: ARRAYED_LIST [TUPLE [ANY, INTEGER, INTEGER]]
			-- When decoding an object some of its references might not be decoded yet, so
			-- we store the object, the field position in this object and the reference id.

feature {NONE} -- Implementation

	read_header is
			-- Read header of serialized data
		do
			-- Do nothing
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

	decode_objects (a_count: NATURAL_32) is
			-- Decode `a_count' object from `deserializer' and store root object in `last_decoded_object'.
		require
			a_count_positive: a_count > 0
		local
			i, nb: NATURAL_32
			l_root_object: ANY
		do
				-- Decode root object
			decode_object
			l_root_object := last_decoded_object

				-- Decode remaining objects
			from
				i := 2
				nb := a_count + 1
			until
				i = nb
			loop
				decode_object
				i := i + 1
			end

				-- Set `last_decoded_object' with `l_root_object'.
			last_decoded_object := l_root_object
		end

	decode_object is
			-- Decode one object and store it in `last_decoded_object'.
		local
			l_dtype: INTEGER
			l_deser: like deserializer
			l_nat32: NATURAL_32
			l_index: INTEGER
			l_flags: NATURAL_8
		do
			l_deser := deserializer

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

			if (l_flags & is_special_flag) = is_special_flag then
				decode_special (l_dtype, l_index)
			elseif (l_flags & is_tuple_flag) = is_tuple_flag then
				decode_tuple (l_dtype, l_index)
			else
				decode_normal_object (l_dtype, l_index)
			end
		end

	decode_normal_object (a_dtype, an_index: INTEGER) is
			-- Decode an object of type `dtype' and index `an_index'.
		require
			a_dtype_non_negative: a_dtype >= 0
			an_index_non_negative: an_index >= 0
		local
			l_int: like internal
			l_deser: like deserializer
			l_obj: ANY
			i, nb: INTEGER
		do
			l_int := internal
			l_deser := deserializer

			from
				l_obj := l_int.new_instance_of (a_dtype)
				object_references.put (l_obj, an_index)
				last_decoded_object := l_obj
				i := 1
				nb := l_int.field_count_of_type (a_dtype) + 1
			until
				i = nb
			loop
				inspect l_int.field_type_of_type (i, a_dtype)
				when {INTERNAL}.boolean_type then
					l_int.set_boolean_field (i, l_obj, l_deser.read_boolean)
	
				when {INTERNAL}.character_type then
					l_int.set_character_field (i, l_obj, l_deser.read_character_8)
	
				when {INTERNAL}.natural_8_type then
					l_int.set_natural_8_field (i, l_obj, l_deser.read_natural_8)
				when {INTERNAL}.natural_16_type then
					l_int.set_natural_16_field (i, l_obj, l_deser.read_natural_16)
				when {INTERNAL}.natural_32_type then
					l_int.set_natural_32_field (i, l_obj, l_deser.read_natural_32)
				when {INTERNAL}.natural_64_type then
					l_int.set_natural_64_field (i, l_obj, l_deser.read_natural_64)
	
				when {INTERNAL}.integer_8_type then
					l_int.set_integer_8_field (i, l_obj, l_deser.read_integer_8)
				when {INTERNAL}.integer_16_type then
					l_int.set_integer_16_field (i, l_obj, l_deser.read_integer_16)
				when {INTERNAL}.integer_32_type then
					l_int.set_integer_32_field (i, l_obj, l_deser.read_integer_32)
				when {INTERNAL}.integer_64_type then
					l_int.set_integer_64_field (i, l_obj, l_deser.read_integer_64)
	
				when {INTERNAL}.real_32_type then
					l_int.set_real_32_field (i, l_obj, l_deser.read_real_32)
				when {INTERNAL}.real_64_type then
					l_int.set_real_64_field (i, l_obj, l_deser.read_real_64)
	
				when {INTERNAL}.pointer_type then
					l_int.set_pointer_field (i, l_obj, l_deser.read_pointer)
	
				when {INTERNAL}.reference_type then
					decode_reference (l_obj, i)
	
				else
					check
						False
					end
				end
				i := i + 1
			end
		end

	decode_tuple (a_dtype, an_index: INTEGER) is
			-- Decode TUPLE object of type `a_dtype' and index `an_index'.
		require
			a_dtype_non_negative: a_dtype >= 0
			an_index_non_negative: an_index >= 0
		local
			l_deser: like deserializer
			l_tuple: TUPLE
			i, nb: INTEGER
		do
			l_deser := deserializer
			l_tuple ?= internal.new_instance_of (a_dtype)
			check
				l_tuple_not_void: l_tuple /= Void
			end
			object_references.put (l_tuple, an_index)
			last_decoded_object := l_tuple

			from
				i := 1
				nb := l_tuple.count + 1
			until
				i = nb
			loop
				inspect l_deser.read_natural_8
				when {TUPLE}.boolean_code then l_tuple.put_boolean (l_deser.read_boolean, i)
				when {TUPLE}.character_code then l_tuple.put_character (l_deser.read_character_8, i)

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

				when {TUPLE}.reference_code then decode_reference (l_tuple, i)
				else
					check
						False
					end
				end
				i := i + 1
			end
		end

	decode_special (a_dtype, an_index: INTEGER) is
			-- Decode SPECIAL object of type `a_dtype' and index `an_index'.
			-- `a_dtype' is only used for SPECIAL of references.
		require
			a_dtype_non_negative: a_dtype >= 0
			an_index_non_negative: an_index >= 0
		local
			l_item_type: INTEGER
		do
			l_item_type := deserializer.read_integer_32
			inspect l_item_type
			when {INTERNAL}.boolean_type then decode_special_boolean (an_index)
			when {INTERNAL}.character_type then decode_special_character (an_index)

			when {INTERNAL}.natural_8_type then decode_special_natural_8 (an_index)
			when {INTERNAL}.natural_16_type then decode_special_natural_16 (an_index)
			when {INTERNAL}.natural_32_type then decode_special_natural_32 (an_index)
			when {INTERNAL}.natural_64_type then decode_special_natural_64 (an_index)

			when {INTERNAL}.integer_8_type then decode_special_integer_8 (an_index)
			when {INTERNAL}.integer_16_type then decode_special_integer_16 (an_index)
			when {INTERNAL}.integer_32_type then decode_special_integer_32 (an_index)
			when {INTERNAL}.integer_64_type then decode_special_integer_64 (an_index)

			when {INTERNAL}.real_32_type then decode_special_real_32 (an_index)
			when {INTERNAL}.real_64_type then decode_special_real_64 (an_index)

			when {INTERNAL}.pointer_type then decode_special_pointer (an_index)

			when {INTERNAL}.reference_type then decode_special_reference (a_dtype, an_index)

			else
				check
					False
				end
			end
		end

	decode_special_boolean (an_index: INTEGER) is
			-- Decode SPECIAL [BOOLEAN] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [BOOLEAN]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_boolean, i)
				i := i + 1
			end
		end

	decode_special_character (an_index: INTEGER) is
			-- Decode SPECIAL [CHARACTER] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [CHARACTER]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_character_8, i)
				i := i + 1
			end
		end

	decode_special_natural_8 (an_index: INTEGER) is
			-- Decode SPECIAL [NATURAL_8] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [NATURAL_8]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_natural_8, i)
				i := i + 1
			end
		end

	decode_special_natural_16 (an_index: INTEGER) is
			-- Decode SPECIAL [NATURAL_16] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [NATURAL_16]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_natural_16, i)
				i := i + 1
			end
		end

	decode_special_natural_32 (an_index: INTEGER) is
			-- Decode SPECIAL [NATURAL_32] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [NATURAL_32]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_natural_32, i)
				i := i + 1
			end
		end

	decode_special_natural_64 (an_index: INTEGER) is
			-- Decode SPECIAL [NATURAL_64] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [NATURAL_64]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_natural_64, i)
				i := i + 1
			end
		end

	decode_special_integer_8 (an_index: INTEGER) is
			-- Decode SPECIAL [INTEGER_8] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [INTEGER_8]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_integer_8, i)
				i := i + 1
			end
		end

	decode_special_integer_16 (an_index: INTEGER) is
			-- Decode SPECIAL [INTEGER_16] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [INTEGER_16]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_integer_16, i)
				i := i + 1
			end
		end

	decode_special_integer_32 (an_index: INTEGER) is
			-- Decode SPECIAL [INTEGER] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [INTEGER]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_integer_32, i)
				i := i + 1
			end
		end

	decode_special_integer_64 (an_index: INTEGER) is
			-- Decode SPECIAL [INTEGER_64] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [INTEGER_64]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_integer_64, i)
				i := i + 1
			end
		end

	decode_special_real_32 (an_index: INTEGER) is
			-- Decode SPECIAL [REAL] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [REAL]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_real_32, i)
				i := i + 1
			end
		end

	decode_special_real_64 (an_index: INTEGER) is
			-- Decode SPECIAL [DOUBLE] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [DOUBLE]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_real_64, i)
				i := i + 1
			end
		end

	decode_special_pointer (an_index: INTEGER) is
			-- Decode SPECIAL [POINTER] whose index is `an_index'.
		require
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [POINTER]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_spec.make (nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				l_spec.put (l_deser.read_pointer, i)
				i := i + 1
			end
		end

	decode_special_reference (a_dtype, an_index: INTEGER) is
			-- Decode SPECIAL [ANY] of dynamic type `a_dtype' whose index is `an_index'.
		require
			a_dtype_not_negative: a_dtype >= 0
			an_index_non_negative: an_index >= 0
		local
			l_spec: SPECIAL [ANY]	
			i, nb: INTEGER
			l_deser: like deserializer
		do
			l_deser := deserializer
			from
				i := 0
				nb := l_deser.read_compressed_natural_32.to_integer_32
				l_spec := internal.new_special_any_instance (a_dtype, nb)
				object_references.put (l_spec, an_index)
				last_decoded_object := l_spec
			until
				i = nb
			loop
				decode_reference (l_spec, i)
				i := i + 1
			end
		end

	decode_reference (an_obj: ANY; an_index: INTEGER) is
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
					if missing_references = Void then
						create missing_references.make (200)
					end
					missing_references.extend ([an_obj, an_index, l_index])
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
			l_spec: SPECIAL [ANY]
			l_tuple: TUPLE
		do
			l_int := internal

			if l_int.is_special (an_obj) then
				l_spec ?= an_obj
				l_spec.put (a_sub_obj, an_index)
			elseif l_int.is_tuple (an_obj) then
				l_tuple ?= an_obj
				l_tuple.put_reference (a_sub_obj, an_index)
			else
				l_int.set_reference_field (an_index, an_obj, a_sub_obj)
			end
		end

	reconnect_objects is
			-- Reconnect missing references
		local
			l_missing_references: like missing_references
			l_object_references: like object_references
			l_tuple: TUPLE [ANY, INTEGER, INTEGER]
			l_obj: ANY
			l_field_pos: INTEGER
			l_ref_id: INTEGER
			l_internal: INTERNAL
		do
			l_missing_references := missing_references
			if l_missing_references /= Void then
				from
					l_object_references := object_references
					create l_internal
					l_missing_references.start
				until
					l_missing_references.after
				loop
					l_tuple := l_missing_references.item
					l_obj := l_tuple.item (1)
					l_field_pos := l_tuple.integer_32_item (2)
					l_ref_id := l_tuple.integer_32_item (3)
					update_reference (l_obj, l_object_references.item (l_ref_id), l_field_pos)
					l_missing_references.forth
				end
			end
		end

invariant
	internal_not_void: internal /= Void
	deserializer_not_void: deserializer /= Void
	object_references_not_void: object_references /= Void

end
