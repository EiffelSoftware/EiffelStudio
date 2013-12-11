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
			create_object
		end

create
	make, default_create

feature {NONE} -- Impementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		do
			Result := attached {TYPE [detachable SPECIAL [detachable ANY]]} type.type
		end

feature {PS_ABEL_EXPORT} -- Read functions

	create_object (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Create a new, uninitialized Eiffel object instance for `object'.
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
			capacity := retrieved.get_information ("capacity").to_integer

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

--					check not_implemented: False end
--					create {SPECIAL [detachable ANY]} new_instance.make_empty (0)
				end
			end

			create reflector.make (new_instance)
			object.set_object (reflector)
		end

	initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			index: INTEGER
			type: PS_TYPE_METADATA
			new_instance: SPECIAL [detachable ANY]
			reflector: REFLECTED_REFERENCE_OBJECT

			retrieved: PS_BACKEND_COLLECTION
			field_type: INTEGER
			i: INTEGER
			capacity: INTEGER

			field: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER
		do
			index := object.index
			type := object.type
			retrieved := object.backend_collection

			check attached {SPECIAL [detachable ANY]} object.reflector.object as inst then
				new_instance := inst
			end

			from
				i := 1
			until
				i > retrieved.collection_items.count
			loop
				field := retrieved.collection_items [i]

				if not field.type.is_equal ("NONE") then

					dynamic_field_type := read_manager.metadata_factory.create_metadata_from_type_id (internal_lib.dynamic_type_from_string (field.type))

					if read_manager.is_processable (field.value, dynamic_field_type) then
						new_instance.extend (read_manager.processed_object (field.value, dynamic_field_type, object))
					else
						read_manager.process_next (field.value.to_integer, dynamic_field_type, object)
						object.uninitialized_attributes.extend (i)
						if not new_instance.generating_type.generic_parameter_type (1).is_expanded then
							new_instance.extend (Void)
						end
					end
				else
					new_instance.extend (Void)
				end
				i := i + 1
			end

				--HASH_TABLE fix
				-- The internal_hash_code of STRING doesn't get stored , but we can recreate it easily
			if attached {SPECIAL [READABLE_STRING_GENERAL]} new_instance as inst then
				across
					inst as cursor
				loop
					i := cursor.item.hash_code
				end
			end
		end

	finish_initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		local
			index: INTEGER
			reflector: REFLECTED_OBJECT
			field: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA

			ref: INTEGER

			processed: detachable ANY
		do
			index := object.index
			across
				object.uninitialized_attributes as field_idx
			loop
				field := object.backend_collection.collection_items [field_idx.item]
				dynamic_field_type := type_from_string (field.type)

				check attached {SPECIAL [detachable ANY]} object.reflector.object as special then
					processed := read_manager.processed_object (field.value, dynamic_field_type, object)

						-- Update reflector for user-defined expanded objects or copy-semantics
					if special.generating_type.generic_parameter_type (1).is_expanded then

						special.extend (processed)

						ref := read_manager.cache_lookup (field.value.to_integer, dynamic_field_type)
						read_manager.item (ref).set_object (create {PS_REFLECTED_SPECIAL_EXPANDED}.make_special_expanded (special, field_idx.item - 1))

					else

						special.put (processed, field_idx.item-1)

						if object.reflector.is_special_copy_semantics_item (field_idx.item - 1) then
							ref := read_manager.cache_lookup (field.value.to_integer, dynamic_field_type)
							read_manager.item (ref).set_object (object.reflector.special_copy_semantics_item (field_idx.item - 1))
						end
					end
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	initialize_backend_representation (object: PS_OBJECT_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		local
			obj: PS_OBJECT_DATA
			i, k: INTEGER
			type: PS_TYPE_METADATA

			new_command: PS_BACKEND_OBJECT

			collection: PS_BACKEND_COLLECTION
			item_type: TYPE [detachable ANY]

			field_type: PS_TYPE_METADATA

			det_field: detachable ANY

			special: SPECIAL [detachable ANY]

			tuple: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]

			used_refs: LINKED_LIST [INTEGER]

		do
			collection := object.backend_collection
			create used_refs.make

			check attached {SPECIAL [detachable ANY]} object.reflector.object as spec then
				special := spec
			end

			across
				0 |..| (special.count - 1) as idx
			loop
				if attached special [idx.item] as item then
					item_type := item.generating_type

						-- Basic types
					if basic_types.has (item_type.type_id) then
						collection.collection_items.extend ([ basic_attribute_value (item), item_type.name])
						-- Reference and expanded
					else
						from
							k := 1
						until
							k > object.references.count or (
--							write_manager.item (object.references [k]).referers.has (object.index) and
							not used_refs.has (k) and
							write_manager.item (object.references [k]).reflector.object = special.item (idx.item))
						loop
							k := k + 1
						end

						if k > object.references.count then
							tuple := ["", create {IMMUTABLE_STRING_8}.make_from_string ("NONE")]
						else
							check attached write_manager.item (object.references [k]).handler as handler then
								tuple := handler.as_string_pair (write_manager.item (object.references [k]))
								used_refs.extend (k)
							end
						end
						collection.collection_items.extend ([tuple.value, tuple.type])
					end
				else
					collection.collection_items.extend (["", create {IMMUTABLE_STRING_8}.make_from_string ("NONE")])
				end
			end

			collection.add_information ("capacity", special.capacity.out)
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
