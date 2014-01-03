note
	description: "Handler for SPECIAL."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SPECIAL_HANDLER

inherit
	PS_COLLECTION_HANDLER
		redefine
			create_object, initialize_backend_representation
		end

create
	make, default_create

feature {NONE} -- Impementation

	capacity_string: STRING = "capacity"

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- <Precursor>
		do
			Result := attached {TYPE [detachable SPECIAL [detachable ANY]]} type.type
		end

feature {PS_ABEL_EXPORT} -- Read functions

	create_object (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		local
			index: INTEGER
			type: PS_TYPE_METADATA
			new_instance: SPECIAL [detachable ANY]
			reflector: REFLECTED_REFERENCE_OBJECT

			retrieved: PS_BACKEND_COLLECTION
			field_type: INTEGER
			i: INTEGER
			capacity: INTEGER

			field: TUPLE [value: STRING; type:STRING]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER

			item_type: INTEGER

			new_expanded_special: ANY
		do
			index := object.index
			-- Create object
			type := object.type
			retrieved := object.backend_collection
			check attached retrieved.meta_information [capacity_string] as cap then
				capacity := cap.to_integer
			end

			if internal_lib.is_special_any_type (type.type.type_id) then
				new_instance := internal_lib.new_special_any_instance (type.type.type_id, capacity)
			else
				item_type := type.actual_generic_parameter (1).type.type_id

					-- Integers
				if item_type = ({INTEGER_8}).type_id then
					create {SPECIAL [INTEGER_8]} new_instance.make_empty (capacity)

				elseif item_type = ({INTEGER_16}).type_id then
					create {SPECIAL [INTEGER_16]} new_instance.make_empty (capacity)

				elseif item_type = ({INTEGER_32}).type_id then
					create {SPECIAL [INTEGER_32]} new_instance.make_empty (capacity)

				elseif item_type = ({INTEGER_64}).type_id then
					create {SPECIAL [INTEGER_64]} new_instance.make_empty (capacity)

					-- Naturals
				elseif item_type = ({NATURAL_8}).type_id then
					create {SPECIAL [NATURAL_8]} new_instance.make_empty (capacity)

				elseif item_type = ({NATURAL_16}).type_id then
					create {SPECIAL [NATURAL_16]} new_instance.make_empty (capacity)

				elseif item_type = ({NATURAL_32}).type_id then
					create {SPECIAL [NATURAL_32]} new_instance.make_empty (capacity)

				elseif item_type = ({NATURAL_64}).type_id then
					create {SPECIAL [NATURAL_64]} new_instance.make_empty (capacity)

					-- Reals
				elseif item_type = ({REAL_32}).type_id then
					create {SPECIAL [REAL_32]} new_instance.make_empty (capacity)

				elseif item_type = ({REAL_64}).type_id then
					create {SPECIAL [REAL_64]} new_instance.make_empty (capacity)

					-- Characters
				elseif item_type = ({CHARACTER_8}).type_id then
					create {SPECIAL [CHARACTER_8]} new_instance.make_empty (capacity)

				elseif item_type = ({CHARACTER_32}).type_id then
					create {SPECIAL [CHARACTER_32]} new_instance.make_empty (capacity)

					-- Boolean
				elseif item_type = ({BOOLEAN}).type_id then
					create {SPECIAL [BOOLEAN]} new_instance.make_empty (capacity)

					-- Pointer
				elseif item_type = ({POINTER}).type_id then
					create {SPECIAL [POINTER]} new_instance.make_empty (capacity)

					-- User-defined expanded type
				else
					fixme ("The fix_header is not enough... Some unrelated tests randomly crash (probably during GC) when this code is enabled.")
					check disable: False end

					new_expanded_special := internal_lib.new_instance_of (type.type.type_id)
					fix_header (new_expanded_special)
					print (header (new_expanded_special))
					check attached {SPECIAL [detachable ANY]} new_expanded_special as spec then
						new_instance := spec.resized_area (capacity)
						print (header (new_instance))
					end
				end
			end

			create reflector.make (new_instance)
			object.set_reflector (reflector)
		end

	initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		local
			retrieved: PS_BACKEND_COLLECTION
			count: INTEGER
			i: INTEGER

			field: STRING
			field_type: PS_TYPE_METADATA

			key: INTEGER
		do
			retrieved := object.backend_collection
			count := retrieved.count

			from
				i := 1
			until
				i > count
			loop
				field := retrieved [i]
				field_type := read_manager.type_factory.create_metadata_from_string (retrieved.item_type (i))

				if not field_type.is_none and then not read_manager.is_attribute_ready (field, field_type) then
					key := field.to_integer
					if read_manager.cache_lookup (key, field_type) = 0 then
						read_manager.process_next (key, field_type, object)
					end
				end
				i := i + 1
			end
		end

	finish_initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		local
			field: STRING
			field_type: PS_TYPE_METADATA

			ref: INTEGER
			i: INTEGER
			count: INTEGER
			ref_special: BOOLEAN
			exp_special: BOOLEAN

			retrieved: PS_BACKEND_COLLECTION
			special: SPECIAL [detachable ANY]
		do
			retrieved := object.backend_collection
			check attached {SPECIAL [detachable ANY]} object.reflector.object as sp then
				special := sp
			end

			ref_special := object.reflector.is_special_of_reference
			exp_special := object.reflector.is_special_of_expanded


			from
				i := 1
				count := retrieved.count
			until
				i > count
			loop
				field := retrieved [i]
				field_type := read_manager.type_factory.create_metadata_from_string (retrieved.item_type (i))

				if ref_special then
					if field_type.is_none then
						special.extend (Void)
					else
						special.extend (read_manager.try_build_attribute (field, field_type, object))
						if object.reflector.is_special_copy_semantics_item (i - 1) and not basic_expanded_types.has (field_type.type.type_id) then
							ref := read_manager.cache_lookup (field.to_integer, field_type)
							read_manager.item (ref).set_reflector (object.reflector.special_copy_semantics_item (i - 1))
						end
					end
				elseif exp_special then
					special.extend (read_manager.try_build_attribute (field, field_type, object))
					ref := read_manager.cache_lookup (field.to_integer, field_type)
					read_manager.item (ref).set_reflector (create {PS_REFLECTED_SPECIAL_EXPANDED}.make_special_expanded (special, i - 1))

				else
					special.extend (read_manager.try_build_attribute (field, field_type, object))
				end
				i := i + 1
			end

				--HASH_TABLE fix
				-- The internal_hash_code of STRING doesn't get stored , but we can recreate it easily
			if attached {SPECIAL [READABLE_STRING_GENERAL]} special as inst then
				across
					inst as cursor
				loop
					i := cursor.item.hash_code
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	initialize_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		do
			Precursor (object)

				-- Add the capacity as meta information.
			check attached {ABSTRACT_SPECIAL} object.reflector.object as sp then
				object.backend_collection.meta_information [capacity_string] := sp.capacity.out
			end
		end


feature {NONE} -- Special: Object header fix


	frozen fix_header (object: ANY)
			-- Add the flags EO_SPEC (indicating a SPECIAL object)
			-- and EO_COMP (indicating expanded types) to `object'.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"HEADER (eif_access ($object)) -> ov_flags |= (EO_SPEC | EO_COMP);"
		end

	frozen header (object: ANY): NATURAL_16
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return HEADER (eif_access ($object)) -> ov_flags;"
		end
end
