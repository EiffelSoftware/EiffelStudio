note
	description: "Encoding of arbitrary objects graphs within a session of a same program."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_SESSION_SERIALIZER

inherit
	SED_UTILITIES

create
	make

feature {NONE} -- Initialization

	make (a_serializer: SED_READER_WRITER)
			-- Initialize current instance
		require
			a_serializer_not_void: a_serializer /= Void
			a_serializer_ready: a_serializer.is_ready_for_writing
		do
			create internal
			create object_indexes.make (1)
			traversable := breadth_first_traversable
			serializer := a_serializer
			is_for_fast_retrieval := is_void_safe
		ensure
			serializer_set: serializer = a_serializer
		end

feature -- Access

	root_object: detachable ANY
			-- Root object of object graph
		do
			Result := traversable.root_object
		end

	serializer: SED_READER_WRITER
			-- Serializer used to encode data

feature -- Status report

	is_traversing_mode_set: BOOLEAN
			-- Is traversing mode set?
		do
			Result := (traversable /= Void)
		end

	is_root_object_set: BOOLEAN
			-- Is root object of object graph set?

	is_for_fast_retrieval: BOOLEAN
			-- Is data stored for fast retrieval?
			-- It is always True for a void-safe system.

feature {NONE} -- Status report

	is_transient_storage_required: BOOLEAN
			-- Do we need to store transient attribute with their default value?
			-- This is necessary for Session/Basic storing where we expect the same
			-- object layout.
		do
			Result := True
		end

feature -- Element change

	set_breadth_first_traversing_mode
			-- Change graph traversing to breadth first.
		do
			traversable := breadth_first_traversable
		ensure
			traversing_mode_set: is_traversing_mode_set
			breadth_first_mode: internal.class_name (traversable) ~ "OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE"
		end

	set_depth_first_traversing_mode
			-- Change graph traversing to depth first.
		do
			traversable := depth_first_traversable
		ensure
			traversing_mode_set: is_traversing_mode_set
			depth_first_mode: internal.class_name (traversable) ~ "OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE"
		end

	set_root_object (an_object: like root_object)
			-- Make 'an_object' the root_object.
		require
			an_object_not_void: an_object /= Void
			traversing_mode_set: is_traversing_mode_set
		do
			traversable.set_root_object (an_object)
			is_root_object_set := True
		ensure
			root_object_set: root_object = an_object and is_root_object_set
			root_object_identity: root_object = traversable.root_object
		end

	set_is_for_fast_retrieval (v: like is_for_fast_retrieval)
			-- Set `is_for_fast_retrieval' with `v'.
		do
			if not is_void_safe then
				is_for_fast_retrieval := v
			end
		ensure
			is_for_fast_retrieval_set: not is_void_safe implies is_for_fast_retrieval = v
			is_for_fast_retrieval_unchanged: is_void_safe implies is_for_fast_retrieval
		end

	set_serializer (a_serializer: like serializer)
			-- Set `serializer' with `a_serializer'.
		require
			a_serializer_not_void: a_serializer /= Void
			a_serializer_ready: a_serializer.is_ready_for_writing
		do
			serializer := a_serializer
		ensure
			serializer_set: serializer = a_serializer
		end

feature -- Basic operations

	encode
			-- Encode object graph starting with the root object.
		require
			traversing_mode_set: is_traversing_mode_set
			root_object_set: is_root_object_set
		local
			l_mem: detachable MEMORY
			l_is_collecting: BOOLEAN
			l_list: detachable ARRAYED_LIST [ANY]
			l_list_count: NATURAL_32
		do
			if not {PLATFORM}.is_dotnet then
				create l_mem
				l_is_collecting := l_mem.collecting
				l_mem.collection_off
			end

				-- We ignore transient attributes for storing.
			traversable.set_is_skip_transient (True)
			traversable.traverse
			l_list := traversable.visited_objects
			if l_list /= Void then
				l_list_count := l_list.count.to_natural_32

				if l_list.count > object_indexes.capacity then
					create object_indexes.make (l_list_count)
				end

					-- Write number of objects we are storing
				serializer.write_compressed_natural_32 (l_list_count)

					-- Write header of encoding
				write_header (l_list)

					-- Write objects
				encode_objects (l_list)
			end

			traversable.wipe_out
			object_indexes.wipe_out

			if l_mem /= Void and then l_is_collecting then
				l_mem.collection_on
			end
		end

feature {NONE} -- Implementation: Access

	internal: INTERNAL
			-- Facilities to inspect.

	traversable: OBJECT_GRAPH_TRAVERSABLE
			-- Object used for traversing object graph

	object_indexes: SED_OBJECTS_TABLE
			-- Mapping between object and their associated index.

	breadth_first_traversable: OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
			-- Return an instance of OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE.
		once
			Result := create {OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE}
		end

	depth_first_traversable: OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE
			-- Return an instance of OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE.
		once
			Result := create {OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE}
		end

feature {NONE} -- Implementation

	write_header (a_list: ARRAYED_LIST [ANY])
			-- Operation performed before `encoding_objects'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		do
			write_object_table (a_list)
		end

	write_object_table (a_list: ARRAYED_LIST [ANY])
			-- Write mapping between object's reference ID in `a_list' with
			-- all the necessary information necessary to recreate it at a
			-- later time.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		local
			l_int: like internal
			l_ser: like serializer
			l_object_indexes: like object_indexes
			l_spec_mapping: like special_type_mapping
			i, nb: INTEGER
			l_dtype, l_spec_item_type: INTEGER
			l_obj: ANY
			l_area: SPECIAL [ANY]
		do
			if is_for_fast_retrieval then
					-- Mark data with information that shows we have a mapping
					-- between reference IDs and objects.
				serializer.write_boolean (True)
				l_int := internal
				l_ser := serializer
				l_object_indexes := object_indexes
				l_spec_mapping := special_type_mapping

				from
					l_area := a_list.area
					i := 0
					nb := a_list.count
				until
					i = nb
				loop
					l_obj := l_area.item (i)
					i := i + 1

						-- Get object data.
					l_dtype := l_int.dynamic_type (l_obj)

						-- Write object dtype.
					l_ser.write_compressed_natural_32 (l_dtype.to_natural_32)

						-- Write object reference ID.
					l_ser.write_compressed_natural_32 (l_object_indexes.index (l_obj))

						-- Write object flags, then data.
					if l_int.is_special (l_obj) then
							-- Write special flag.
						l_ser.write_natural_8 (is_special_flag)

							-- Get the abstract element type of the SPECIAL and write it.
						l_spec_mapping.search (l_int.generic_dynamic_type_of_type (l_dtype, 1))
						if l_spec_mapping.found then
							l_spec_item_type := l_spec_mapping.found_item
						else
							l_spec_item_type := {INTERNAL}.reference_type
						end
						l_ser.write_compressed_integer_32 (l_spec_item_type)

							-- Write number of elements in SPECIAL
						if attached {ABSTRACT_SPECIAL} l_obj as l_abstract_spec then
							l_ser.write_compressed_integer_32 (l_abstract_spec.count)
						else
							check
								l_abstract_spec_attached: False
							end
						end

					elseif l_int.is_tuple (l_obj) then
						l_ser.write_natural_8 (is_tuple_flag)
					else
						l_ser.write_natural_8 (0)
					end
				end
			else
					-- No mapping here.
				serializer.write_boolean (False)
			end
		end

	write_default_value (a_abstract_type: INTEGER)
			-- Write to the stream the default value that corresponds to `a_abstract_type'.
		local
			l_ser: like serializer
		do
			l_ser := serializer
			inspect a_abstract_type
			when {INTERNAL}.boolean_type then l_ser.write_boolean (False)
			when {INTERNAL}.character_8_type then l_ser.write_character_8 ('%/000/')
			when {INTERNAL}.character_32_type then l_ser.write_character_32 ('%/000/')
			when {INTERNAL}.natural_8_type then l_ser.write_natural_8 (0)
			when {INTERNAL}.natural_16_type then l_ser.write_natural_16 (0)
			when {INTERNAL}.natural_32_type then l_ser.write_natural_32 (0)
			when {INTERNAL}.natural_64_type then l_ser.write_natural_64 (0)
			when {INTERNAL}.integer_8_type then l_ser.write_integer_8 (0)
			when {INTERNAL}.integer_16_type then l_ser.write_integer_16 (0)
			when {INTERNAL}.integer_32_type then l_ser.write_integer_32 (0)
			when {INTERNAL}.integer_64_type then l_ser.write_integer_64 (0)
			when {INTERNAL}.real_32_type then l_ser.write_real_32 (0)
			when {INTERNAL}.real_64_type then l_ser.write_real_64 (0)
			when {INTERNAL}.pointer_type then l_ser.write_pointer (default_pointer)
			when {INTERNAL}.reference_type then encode_reference (Void)
			else
				check False end
			end
		end

	encode_objects (a_list: ARRAYED_LIST [ANY])
			-- Encode all objects referenced in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		local
			l_int: like internal
			l_ser: like serializer
			l_spec_mapping: like special_type_mapping
			l_object_indexes: like object_indexes
			l_is_for_slow_retrieval: BOOLEAN
			l_dtype, l_spec_item_type: INTEGER
			l_obj: ANY
			i, nb: INTEGER
			l_area: SPECIAL [ANY]
		do
			l_int := internal
			l_ser := serializer
			l_object_indexes := object_indexes
			l_spec_mapping := special_type_mapping
			l_is_for_slow_retrieval := not is_for_fast_retrieval

			from
				l_area := a_list.area
				i := 0
				nb := a_list.count
			until
				i = nb
			loop
				l_obj := l_area.item (i)
				i := i + 1

					-- Get object data.
				l_dtype := l_int.dynamic_type (l_obj)

				if l_is_for_slow_retrieval then
						-- Write object dtype
					l_ser.write_compressed_natural_32 (l_dtype.to_natural_32)
				end

					-- Write object reference ID.
				l_ser.write_compressed_natural_32 (l_object_indexes.index (l_obj))

					-- Write object flags if in slow retrieval mode, then data.
				if l_int.is_special (l_obj) then
						-- Get the abstract element type of the SPECIAL.
					l_spec_mapping.search (l_int.generic_dynamic_type_of_type (l_dtype, 1))
					if l_spec_mapping.found then
						l_spec_item_type := l_spec_mapping.found_item
					else
						l_spec_item_type := {INTERNAL}.reference_type
					end

					if l_is_for_slow_retrieval then
							-- Store the fact it is a SPECIAL
						l_ser.write_natural_8 (is_special_flag)

							-- Store the type of special
						l_ser.write_compressed_integer_32 (l_spec_item_type)

							-- Store count of special
						if attached {ABSTRACT_SPECIAL} l_obj as l_abstract_spec then
							l_ser.write_compressed_integer_32 (l_abstract_spec.count)
						else
							check l_abstract_spec_attached: False end
						end
					end
					encode_special (l_obj, l_dtype, l_spec_item_type)
				elseif l_int.is_tuple (l_obj) then
					if l_is_for_slow_retrieval then
						l_ser.write_natural_8 (is_tuple_flag)
					end
					if attached {TUPLE} l_obj as l_tuple then
						encode_tuple_object (l_tuple)
					else
						check
							l_tuple_attached: False
						end
					end
				else
					if l_is_for_slow_retrieval then
						l_ser.write_natural_8 (0)
					end
					encode_normal_object (l_obj, l_dtype)
				end
			end
		end

	encode_reference (an_object: detachable ANY)
			-- Encode reference to `an_object'.
		do
			if an_object /= Void then
				serializer.write_compressed_natural_32 (object_indexes.index (an_object))
			else
				serializer.write_compressed_natural_32 (0)
			end
		end

	encode_normal_object (an_object: ANY; a_dtype: INTEGER)
			-- Encode normal object.
		require
			an_object_not_void: an_object /= Void
			a_dtype_non_negative: a_dtype >= 0
		local
			i, nb: INTEGER
			l_int: like internal
			l_ser: like serializer
		do
			from
				l_int := internal
				l_ser := serializer
				i := 1
				nb := l_int.field_count_of_type (a_dtype) + 1
			until
				i = nb
			loop
				if not l_int.is_field_transient (i, an_object) then
					inspect l_int.field_type_of_type (i, a_dtype)
					when {INTERNAL}.boolean_type then
						l_ser.write_boolean (l_int.boolean_field (i, an_object))

					when {INTERNAL}.character_8_type then
						l_ser.write_character_8 (l_int.character_8_field (i, an_object))
					when {INTERNAL}.character_32_type then
						l_ser.write_character_32 (l_int.character_32_field (i, an_object))

					when {INTERNAL}.natural_8_type then
						l_ser.write_natural_8 (l_int.natural_8_field (i, an_object))
					when {INTERNAL}.natural_16_type then
						l_ser.write_natural_16 (l_int.natural_16_field (i, an_object))
					when {INTERNAL}.natural_32_type then
						l_ser.write_natural_32 (l_int.natural_32_field (i, an_object))
					when {INTERNAL}.natural_64_type then
						l_ser.write_natural_64 (l_int.natural_64_field (i, an_object))

					when {INTERNAL}.integer_8_type then
						l_ser.write_integer_8 (l_int.integer_8_field (i, an_object))
					when {INTERNAL}.integer_16_type then
						l_ser.write_integer_16 (l_int.integer_16_field (i, an_object))
					when {INTERNAL}.integer_32_type then
						l_ser.write_integer_32 (l_int.integer_32_field (i, an_object))
					when {INTERNAL}.integer_64_type then
						l_ser.write_integer_64 (l_int.integer_64_field (i, an_object))

					when {INTERNAL}.real_32_type then
						l_ser.write_real_32 (l_int.real_32_field (i, an_object))
					when {INTERNAL}.real_64_type then
						l_ser.write_real_64 (l_int.real_64_field (i, an_object))

					when {INTERNAL}.pointer_type then
						l_ser.write_pointer (l_int.pointer_field (i, an_object))

					when {INTERNAL}.reference_type then
						encode_reference (l_int.field (i, an_object))
					else
						check
							False
						end
					end
				elseif is_transient_storage_required then
					write_default_value (l_int.field_type_of_type (i, a_dtype))
				end
				i := i + 1
			end
		end

	encode_tuple_object (a_tuple: TUPLE)
			-- Encode a TUPLE object.
		require
			a_tuple_not_void: a_tuple /= Void
		local
			i, nb: INTEGER
			l_code: NATURAL_8
			l_ser: like serializer
		do
			from
				l_ser := serializer
				i := 1
				nb := a_tuple.count + 1
			until
				i = nb
			loop
				l_code := a_tuple.item_code (i)
				l_ser.write_natural_8 (l_code)
				inspect l_code
				when {TUPLE}.boolean_code then l_ser.write_boolean (a_tuple.boolean_item (i))

				when {TUPLE}.character_8_code then l_ser.write_character_8 (a_tuple.character_8_item (i))
				when {TUPLE}.character_32_code then l_ser.write_character_32 (a_tuple.character_32_item (i))

				when {TUPLE}.natural_8_code then l_ser.write_natural_8 (a_tuple.natural_8_item (i))
				when {TUPLE}.natural_16_code then l_ser.write_natural_16 (a_tuple.natural_16_item (i))
				when {TUPLE}.natural_32_code then l_ser.write_natural_32 (a_tuple.natural_32_item (i))
				when {TUPLE}.natural_64_code then l_ser.write_natural_64 (a_tuple.natural_64_item (i))

				when {TUPLE}.integer_8_code then l_ser.write_integer_8 (a_tuple.integer_8_item (i))
				when {TUPLE}.integer_16_code then l_ser.write_integer_16 (a_tuple.integer_16_item (i))
				when {TUPLE}.integer_32_code then l_ser.write_integer_32 (a_tuple.integer_32_item (i))
				when {TUPLE}.integer_64_code then l_ser.write_integer_64 (a_tuple.integer_64_item (i))

				when {TUPLE}.real_32_code then l_ser.write_real_32 (a_tuple.real_32_item (i))
				when {TUPLE}.real_64_code then l_ser.write_real_64 (a_tuple.real_64_item (i))

				when {TUPLE}.pointer_code then l_ser.write_pointer (a_tuple.pointer_item (i))

				when {TUPLE}.reference_code then encode_reference (a_tuple.reference_item (i))

				else
					check
						False
					end
				end
				i := i + 1
			end
		end

	encode_special (an_object: ANY; a_dtype, a_item_type: INTEGER)
			-- Encode an object which is a special object.
		require
			an_object_not_void: an_object /= Void
			an_object_is_special: internal.is_special (an_object)
			a_dtype_non_negative: a_dtype >= 0
			a_item_type_non_negative: a_item_type >= 0
		do
			inspect a_item_type
			when {INTERNAL}.boolean_type then
				if attached {SPECIAL [BOOLEAN]} an_object as l_spec_boolean then
					encode_special_boolean (l_spec_boolean)
				else
					check l_spec_boolean_not_void: False end
				end

			when {INTERNAL}.character_8_type then
				if attached {SPECIAL [CHARACTER_8]} an_object as l_spec_character_8 then
					encode_special_character_8 (l_spec_character_8)
				else
					check l_spec_character_8_not_void: False end
				end

			when {INTERNAL}.character_32_type then
				if attached {SPECIAL [CHARACTER_32]} an_object as l_spec_character_32 then
					encode_special_character_32 (l_spec_character_32)
				else
					check l_spec_character_32_not_void: False end
				end

			when {INTERNAL}.natural_8_type then
				if attached {SPECIAL [NATURAL_8]} an_object as l_spec_natural_8 then
					encode_special_natural_8 (l_spec_natural_8)
				else
					check l_spec_natural_8_not_void: False end
				end

			when {INTERNAL}.natural_16_type then
				if attached {SPECIAL [NATURAL_16]} an_object as l_spec_natural_16 then
					encode_special_natural_16 (l_spec_natural_16)
				else
					check l_spec_natural_16_not_void: False end
				end

			when {INTERNAL}.natural_32_type then
				if attached {SPECIAL [NATURAL_32]} an_object as l_spec_natural_32 then
					encode_special_natural_32 (l_spec_natural_32)
				else
					check l_spec_natural_32_not_void: False end
				end

			when {INTERNAL}.natural_64_type then
				if attached {SPECIAL [NATURAL_64]} an_object as l_spec_natural_64 then
					encode_special_natural_64 (l_spec_natural_64)
				else
					check l_spec_natural_64_not_void: False end
				end

			when {INTERNAL}.integer_8_type then
				if attached {SPECIAL [INTEGER_8]} an_object as l_spec_integer_8 then
					encode_special_integer_8 (l_spec_integer_8)
				else
					check l_spec_integer_8_not_void: False end
				end

			when {INTERNAL}.integer_16_type then
				if attached {SPECIAL [INTEGER_16]} an_object as l_spec_integer_16 then
					encode_special_integer_16 (l_spec_integer_16)
				else
					check l_spec_integer_16_not_void: False end
				end

			when {INTERNAL}.integer_32_type then
				if attached {SPECIAL [INTEGER]} an_object as l_spec_integer_32 then
					encode_special_integer_32 (l_spec_integer_32)
				else
					check l_spec_integer_32_not_void: False end
				end

			when {INTERNAL}.integer_64_type then
				if attached {SPECIAL [INTEGER_64]} an_object as l_spec_integer_64 then
					encode_special_integer_64 (l_spec_integer_64)
				else
					check l_spec_integer_64_not_void: False end
				end

			when {INTERNAL}.real_32_type then
				if attached {SPECIAL [REAL]} an_object as l_spec_real_32 then
					encode_special_real_32 (l_spec_real_32)
				else
					check l_spec_real_32_not_void: False end
				end

			when {INTERNAL}.real_64_type then
				if attached {SPECIAL [DOUBLE]} an_object as l_spec_real_64 then
					encode_special_real_64 (l_spec_real_64)
				else
					check l_spec_real_64_not_void: False end
				end

			when {INTERNAL}.pointer_type then
				if attached {SPECIAL [POINTER]} an_object as l_spec_pointer then
					encode_special_pointer (l_spec_pointer)
				else
					check l_spec_pointer_not_void: False end
				end

			else
				check
					a_item_type_valid: a_item_type = {INTERNAL}.reference_type
				end
				if attached {SPECIAL [detachable ANY]} an_object as l_spec_any then
					encode_special_reference (l_spec_any)
				else
					check l_spec_any_not_void: False end
				end
			end
		end

	encode_special_boolean (a_spec: SPECIAL [BOOLEAN])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_boolean (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_character_8 (a_spec: SPECIAL [CHARACTER_8])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_character_8 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_character_32 (a_spec: SPECIAL [CHARACTER_32])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_character_32 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_natural_8 (a_spec: SPECIAL [NATURAL_8])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_natural_8 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_natural_16 (a_spec: SPECIAL [NATURAL_16])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_natural_16 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_natural_32 (a_spec: SPECIAL [NATURAL_32])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_natural_32 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_natural_64 (a_spec: SPECIAL [NATURAL_64])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_natural_64 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_integer_8 (a_spec: SPECIAL [INTEGER_8])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_integer_8 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_integer_16 (a_spec: SPECIAL [INTEGER_16])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_integer_16 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_integer_32 (a_spec: SPECIAL [INTEGER])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_integer_32 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_integer_64 (a_spec: SPECIAL [INTEGER_64])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_integer_64 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_real_32 (a_spec: SPECIAL [REAL])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_real_32 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_real_64 (a_spec: SPECIAL [DOUBLE])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_real_64 (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_pointer (a_spec: SPECIAL [POINTER])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			from
				nb := a_spec.count
				l_ser := serializer
			until
				i = nb
			loop
				l_ser.write_pointer (a_spec.item (i))
				i := i + 1
			end
		end

	encode_special_reference (a_spec: SPECIAL [detachable ANY])
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
		do
			from
				nb := a_spec.count
			until
				i = nb
			loop
				encode_reference (a_spec.item (i))
				i := i + 1
			end
		end

invariant
	internal_not_void: internal /= Void
	traversable_not_void: traversable /= Void
	serializer_not_void: serializer /= Void
	object_indexes_not_void: object_indexes /= Void
	fast_retrieval_active: is_void_safe implies is_for_fast_retrieval

note
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

end -- class SED_SESSION_SERIALIZER
