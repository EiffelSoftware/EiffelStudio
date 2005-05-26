indexing
	description: "Encoding of arbitrary objects graphs within a session of a same program."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_SESSION_SERIALIZER

inherit
	SED_UTILITIES

create
	make

feature {NONE} -- Initialization

	make (a_serializer: SED_READER_WRITER) is
			-- Initialize current instance
		require
			a_serializer_not_void: a_serializer /= Void
		do
			create internal
			create object_indexes.make (1)
			traversable := breadth_first_traversable
			serializer := a_serializer
		ensure
			serializer_set: serializer = a_serializer
		end

feature -- Access

	root_object: ANY is
			-- Root object of object graph
		do
			Result := traversable.root_object
		end

	serializer: SED_READER_WRITER
			-- Serializer used to encode data

feature -- Status report

	is_traversing_mode_set: BOOLEAN is
			-- Is traversing mode set?
		do
			Result := (traversable /= Void)
		end

	is_root_object_set: BOOLEAN
			-- Is root object of object graph set?

feature -- Element change

	set_breadth_first_traversing_mode is
			-- Change graph traversing to breadth first.
		do
			traversable := breadth_first_traversable
		ensure
			traversing_mode_set: is_traversing_mode_set
			breadth_first_mode: internal.class_name (traversable).is_equal ("OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE")
		end
		
	set_depth_first_traversing_mode is
			-- Change graph traversing to depth first.
		do
			traversable := depth_first_traversable
		ensure
			traversing_mode_set: is_traversing_mode_set
			depth_first_mode: internal.class_name (traversable).is_equal ("OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE")
		end

	set_root_object (an_object: like root_object) is
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

feature -- Basic operations

	encode is
			-- Encode object graph starting with the root object.
		require
			traversing_mode_set: is_traversing_mode_set
			root_object_set: is_root_object_set
		local
			l_mem: MEMORY
			l_is_collecting: BOOLEAN
			l_list: ARRAYED_LIST [ANY]
			l_list_count: NATURAL_32
		do
			if not {PLATFORM}.is_dotnet then
				create l_mem
				l_is_collecting := l_mem.collecting
				l_mem.collection_off
			end

			traversable.traverse
			l_list := traversable.visited_objects
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

			traversable.wipe_out
			object_indexes.wipe_out

			if l_is_collecting then
				l_mem.collection_on
			end
		end

feature {NONE} -- Implementation: Access

	internal: INTERNAL
			-- Facilities to inspect.

	traversable: SED_OBJECT_GRAPH_TRAVERSABLE
			-- Object used for traversing object graph

	object_indexes: SED_OBJECTS_TABLE
			-- Mapping between object and their associated index.
	
	breadth_first_traversable: SED_OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE is
			-- Return an instance of OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE.
		once
			Result := create {SED_OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE}
		end
		
	depth_first_traversable: SED_OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE is
			-- Return an instance of OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE.
		once
			Result := create {SED_OBJECT_GRAPH_DEPTH_FIRST_TRAVERSABLE}
		end

feature {NONE} -- Implementation

	write_header (a_list: ARRAYED_LIST [ANY]) is
			-- Operation performed before `encoding_objects'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		do
			-- Nothing for this implementation
		end

	encode_objects (a_list: ARRAYED_LIST [ANY]) is
			-- Encode all objects referenced in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		local
			l_dtype: INTEGER
			l_int: like internal
			l_ser: like serializer
			l_is_special, l_is_tuple: BOOLEAN
			l_obj: ANY
			l_tuple: TUPLE
		do
			l_int := internal
			l_ser := serializer

			from
				a_list.start
			until
				a_list.after
			loop
				l_obj := a_list.item

					-- Get object data.
				l_dtype := l_int.dynamic_type (l_obj)
				l_is_special := l_int.is_special (l_obj)
				l_is_tuple := l_int.is_tuple (l_obj)

					-- Write object dtype.
				l_ser.write_compressed_natural_32 (l_dtype.to_natural_32)

					-- Write object reference ID.
				encode_reference (l_obj)

					-- Write object flags, then data.
				if l_is_special then
					l_ser.write_natural_8 (is_special_flag)
					encode_special (l_obj, l_dtype)
				elseif l_is_tuple then
					l_ser.write_natural_8 (is_tuple_flag)
					l_tuple ?= l_obj
					check
						l_tuple_not_void: l_tuple /= Void
					end
					encode_tuple_object (l_tuple)
				else
					l_ser.write_natural_8 (0)
					encode_normal_object (l_obj, l_dtype)
				end

				a_list.forth
			end
		end

	encode_reference (an_object: ANY) is
			-- Encode reference to `an_object'.
		local
			l_indexes: like object_indexes
		do
			if an_object /= Void then
				l_indexes := object_indexes
				l_indexes.search (an_object)
				if not l_indexes.found then
					l_indexes.put (an_object)
				end
				serializer.write_compressed_natural_32 (l_indexes.found_item)
			else
				serializer.write_compressed_natural_32 (0)
			end
		end
		
	encode_normal_object (an_object: ANY; a_dtype: INTEGER) is
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
				inspect l_int.field_type_of_type (i, a_dtype)
				when {INTERNAL}.boolean_type then
					l_ser.write_boolean (l_int.boolean_field (i, an_object))

				when {INTERNAL}.character_type then
					l_ser.write_character_8 (l_int.character_field (i, an_object))

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
				i := i + 1
			end
		end

	encode_tuple_object (a_tuple: TUPLE) is
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
				when {TUPLE}.character_code then l_ser.write_character_8 (a_tuple.character_item (i))

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

	encode_special (an_object: ANY; a_dtype: INTEGER) is
			-- Encode an object which is a special object.
		require
			an_object_not_void: an_object /= Void
			an_object_is_special: internal.is_special (an_object)
			a_dtype_non_negative: a_dtype >= 0		
		local
			l_spec_boolean: SPECIAL [BOOLEAN]
			l_spec_character: SPECIAL [CHARACTER]
			l_spec_natural_8: SPECIAL [NATURAL_8]
			l_spec_natural_16: SPECIAL [NATURAL_16]
			l_spec_natural_32: SPECIAL [NATURAL_32]
			l_spec_natural_64: SPECIAL [NATURAL_64]
			l_spec_integer_8: SPECIAL [INTEGER_8]
			l_spec_integer_16: SPECIAL [INTEGER_16]
			l_spec_integer_32: SPECIAL [INTEGER]
			l_spec_integer_64: SPECIAL [INTEGER_64]
			l_spec_real_32: SPECIAL [REAL]
			l_spec_real_64: SPECIAL [DOUBLE]
			l_spec_pointer: SPECIAL [POINTER]
			l_spec_any: SPECIAL [ANY]
			l_item_type: INTEGER
		do
			special_type_mapping.search (internal.generic_dynamic_type_of_type (a_dtype, 1))
			if special_type_mapping.found then
					-- Encode special type to facilitate retrieval
				l_item_type := special_type_mapping.found_item
				serializer.write_integer_32 (l_item_type)

					-- Encode specials
				inspect l_item_type				
				when {INTERNAL}.boolean_type then
					l_spec_boolean ?= an_object
					check l_spec_boolean_not_void: l_spec_boolean /= Void end
					encode_special_boolean (l_spec_boolean)

				when {INTERNAL}.character_type then
					l_spec_character ?= an_object
					check l_spec_character_not_void: l_spec_character /= Void end
					encode_special_character (l_spec_character)

				when {INTERNAL}.natural_8_type then
					l_spec_natural_8 ?= an_object
					check l_spec_natural_8_not_void: l_spec_natural_8 /= Void end
					encode_special_natural_8 (l_spec_natural_8)

				when {INTERNAL}.natural_16_type then
					l_spec_natural_16 ?= an_object
					check l_spec_natural_16_not_void: l_spec_natural_16 /= Void end
					encode_special_natural_16 (l_spec_natural_16)

				when {INTERNAL}.natural_32_type then
					l_spec_natural_32 ?= an_object
					check l_spec_natural_32_not_void: l_spec_natural_32 /= Void end
					encode_special_natural_32 (l_spec_natural_32)

				when {INTERNAL}.natural_64_type then
					l_spec_natural_64 ?= an_object
					check l_spec_natural_64_not_void: l_spec_natural_64 /= Void end
					encode_special_natural_64 (l_spec_natural_64)

				when {INTERNAL}.integer_8_type then
					l_spec_integer_8 ?= an_object
					check l_spec_integer_8_not_void: l_spec_integer_8 /= Void end
					encode_special_integer_8 (l_spec_integer_8)

				when {INTERNAL}.integer_16_type then
					l_spec_integer_16 ?= an_object
					check l_spec_integer_16_not_void: l_spec_integer_16 /= Void end
					encode_special_integer_16 (l_spec_integer_16)

				when {INTERNAL}.integer_32_type then
					l_spec_integer_32 ?= an_object
					check l_spec_integer_32_not_void: l_spec_integer_32 /= Void end
					encode_special_integer_32 (l_spec_integer_32)

				when {INTERNAL}.integer_64_type then
					l_spec_integer_64 ?= an_object
					check l_spec_integer_64_not_void: l_spec_integer_64 /= Void end
					encode_special_integer_64 (l_spec_integer_64)

				when {INTERNAL}.real_32_type then
					l_spec_real_32 ?= an_object
					check l_spec_real_32_not_void: l_spec_real_32 /= Void end
					encode_special_real_32 (l_spec_real_32)

				when {INTERNAL}.real_64_type then
					l_spec_real_64 ?= an_object
					check l_spec_real_64_not_void: l_spec_real_64 /= Void end
					encode_special_real_64 (l_spec_real_64)


				when {INTERNAL}.pointer_type then
					l_spec_pointer ?= an_object
					check l_spec_pointer_not_void: l_spec_pointer /= Void end
					encode_special_pointer (l_spec_pointer)

				else
					check
						False
					end
				end
			else
				serializer.write_integer_32 ({INTERNAL}.reference_type)
				l_spec_any ?= an_object
				check l_spec_any_not_void: l_spec_any /= Void end
				encode_special_reference (l_spec_any)
			end
		end

	encode_special_boolean (a_spec: SPECIAL [BOOLEAN]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_boolean (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_character (a_spec: SPECIAL [CHARACTER]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_character_8 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_natural_8 (a_spec: SPECIAL [NATURAL_8]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_natural_8 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_natural_16 (a_spec: SPECIAL [NATURAL_16]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_natural_16 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_natural_32 (a_spec: SPECIAL [NATURAL_32]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_natural_32 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_natural_64 (a_spec: SPECIAL [NATURAL_64]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_natural_64 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_integer_8 (a_spec: SPECIAL [INTEGER_8]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_integer_8 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_integer_16 (a_spec: SPECIAL [INTEGER_16]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_integer_16 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_integer_32 (a_spec: SPECIAL [INTEGER]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_integer_32 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_integer_64 (a_spec: SPECIAL [INTEGER_64]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_integer_64 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_real_32 (a_spec: SPECIAL [REAL]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_real_32 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_real_64 (a_spec: SPECIAL [DOUBLE]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_real_64 (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_pointer (a_spec: SPECIAL [POINTER]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
			l_ser: like serializer
		do
			nb := a_spec.count
			l_ser := serializer
			l_ser.write_compressed_natural_32 (nb.to_natural_32)
			from
				i := 0
			until
				i = nb
			loop
				l_ser.write_pointer (a_spec.item (i))
				i := i + 1
			end
		end
		
	encode_special_reference (a_spec: SPECIAL [ANY]) is
			-- Encode `a_spec'.
		require
			a_spec_not_void: a_spec /= Void
		local
			i, nb: INTEGER
		do
			from
				nb := a_spec.count
				serializer.write_integer_32 (nb)
				i := 0
			until
				i = nb
			loop
				encode_reference (a_spec.item (i))
				i := i + 1
			end
		end
		
	special_type_mapping: HASH_TABLE [INTEGER, INTEGER] is
			-- Mapping bettwen dynamic type of SPECIAL instances to abstract element
			-- types.
		local
			l_int: INTERNAL
		once
			l_int := internal
			create Result.make (10)
			Result.put ({INTERNAL}.boolean_type, l_int.dynamic_type_from_string ("BOOLEAN"))
			Result.put ({INTERNAL}.character_type, l_int.dynamic_type_from_string ("CHARACTER"))

			Result.put ({INTERNAL}.natural_8_type, l_int.dynamic_type_from_string ("NATURAL_8"))
			Result.put ({INTERNAL}.natural_16_type, l_int.dynamic_type_from_string ("NATURAL_16"))
			Result.put ({INTERNAL}.natural_32_type, l_int.dynamic_type_from_string ("NATURAL_32"))
			Result.put ({INTERNAL}.natural_64_type, l_int.dynamic_type_from_string ("NATURAL_64"))

			Result.put ({INTERNAL}.integer_8_type, l_int.dynamic_type_from_string ("INTEGER_8"))
			Result.put ({INTERNAL}.integer_16_type, l_int.dynamic_type_from_string ("INTEGER_16"))
			Result.put ({INTERNAL}.integer_32_type, l_int.dynamic_type_from_string ("INTEGER"))
			Result.put ({INTERNAL}.integer_64_type, l_int.dynamic_type_from_string ("INTEGER_64"))

			Result.put ({INTERNAL}.real_32_type, l_int.dynamic_type_from_string ("REAL"))
			Result.put ({INTERNAL}.real_64_type, l_int.dynamic_type_from_string ("DOUBLE"))

			Result.put ({INTERNAL}.pointer_type, l_int.dynamic_type_from_string ("POINTER"))
		ensure
			special_type_mapping_not_void: Result /= Void
		end
		

invariant
	internal_not_void: internal /= Void
	traversable_not_void: traversable /= Void
	serializer_not_void: serializer /= Void
	object_indexes_not_void: object_indexes /= Void

end -- class SED_SESSION_SERIALIZER
