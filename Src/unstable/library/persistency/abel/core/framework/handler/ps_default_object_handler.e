note
	description: "A default handler for any kind of object except SPECIAL and TUPLE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_OBJECT_HANDLER

inherit

	PS_OBJECT_HANDLER

	REFLECTOR_CONSTANTS
		undefine
			default_create
		end

create
	make, default_create

feature {NONE} -- Implementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		do
			Result := not attached {TYPE [detachable SPECIAL [detachable ANY]]} type.type and not attached {TYPE [detachable TUPLE]} type.type
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_value_type: BOOLEAN = False
			-- Does `Current' map objects to a value type (i.e. STRING)?


feature {PS_ABEL_EXPORT} -- Read functions

	initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			reflector: REFLECTED_OBJECT

			retrieved: PS_BACKEND_OBJECT
			field_type: INTEGER
			field_name: STRING
			i: INTEGER
			field_count: INTEGER

			pos: INTEGER

			field: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER

			dynamic_type: INTEGER
		do
			reflector := object.reflector

			retrieved := object.backend_object

			from
				i := 1
				field_count := retrieved.metadata.attribute_count
			until
				i > field_count
			loop
--				field_type := reflector.field_type (i)
--				field_name := reflector.field_name (i)
				field_type := retrieved.metadata.builtin_type [i]
				field_name := retrieved.metadata.attributes [i]

--				if retrieved.has_attribute (field_name) then
--					field := retrieved.attribute_value (field_name)
				if attached retrieved.value_lookup (field_name) as f then
					field := f

					-- Assign basic expanded attributes
					if
						field_type /= reference_type
						and field_type /= none_type
--						field_type > 1 -- excludes NONE, POINTER and Reference types
						and field_type /= expanded_type -- excludes user-defined expanded types
					then

						inspect
							field_type

							-- Integers
						when integer_8_type then
							reflector.set_integer_8_field (i, field.value.to_integer_8)
						when integer_16_type then
							reflector.set_integer_16_field (i, field.value.to_integer_16)
						when integer_32_type then
							reflector.set_integer_32_field (i, field.value.to_integer_32)
						when integer_64_type then
							reflector.set_integer_64_field (i, field.value.to_integer_64)

							-- Naturals
						when natural_8_type then
							reflector.set_natural_8_field (i, field.value.to_natural_8)
						when natural_16_type then
							reflector.set_natural_16_field (i, field.value.to_natural_16)
						when natural_32_type then
							reflector.set_natural_32_field (i, field.value.to_natural_32)
						when natural_64_type then
							reflector.set_natural_64_field (i, field.value.to_natural_64)

							-- Reals
						when real_32_type then
							create managed.make ({PLATFORM}.real_32_bytes)
							managed.put_integer_32_be (field.value.to_integer_32, 0)
							reflector.set_real_32_field (i, managed.read_real_32_be (0))
						when real_64_type then
							create managed.make ({PLATFORM}.real_64_bytes)
							managed.put_integer_64_be (field.value.to_integer_64, 0)
							reflector.set_real_64_field (i, managed.read_real_64_be (0))

							-- Characters
						when character_8_type then
							reflector.set_character_8_field (i, field.value.to_natural_8.to_character_8)
						when character_32_type then
							reflector.set_character_32_field (i, field.value.to_natural_32.to_character_32)

							-- Booleans
						when boolean_type then
							reflector.set_boolean_field (i, field.value.to_boolean)
						when pointer_type then
							fixme ("Should we give the user some warning?")
							reflector.set_pointer_field (i, default_pointer)
						else
							check unknown_basic_type: False end
						end

					else -- NONE, References and expanded userdefined attributes

						-- Try to assign as much as possible
						--check expanded_not_implemented: field_type = reference_type end

						dynamic_type := internal_lib.dynamic_type_from_string (field.type)
						if dynamic_type /= ({detachable NONE}).type_id then


--						if field.type /~ "NONE" then
							dynamic_field_type := read_manager.metadata_factory.create_metadata_from_type_id (dynamic_type)
			--				dynamic_field_type := type_from_string (field.type)

							if read_manager.is_processable (field.value, dynamic_field_type) then
								if field_type = reference_type and then attached read_manager.processed_object (field.value, dynamic_field_type, object) as val then
									reflector.set_reference_field (i, val)
								end
							else
								-- Order all other reference attributes at read_manager for retrieval
								read_manager.process_next (field.value.to_integer, dynamic_field_type, object)
								object.uninitialized_attributes.extend (i)
							end
						end
					end

				end
				i := i + 1
			variant
				reflector.field_count + 1 - i
			end
		end

	finish_initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		local
			index: INTEGER
			reflector: REFLECTED_OBJECT
			field: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA

			ref_item: INTEGER
		do
			index := object.index
			across
				object.uninitialized_attributes as field_idx
			from
				reflector := object.reflector
			loop
				field := object.backend_object.attribute_value (reflector.field_name (field_idx.item))
				dynamic_field_type := type_from_string (field.type)

				inspect
					reflector.field_type (field_idx.item)
				when expanded_type then

					ref_item := read_manager.cache_lookup (field.value.to_integer, dynamic_field_type)
					read_manager.item (ref_item).set_object (reflector.expanded_field (field_idx.item))
				when reference_type then

					reflector.set_reference_field (field_idx.item, read_manager.processed_object (field.value, dynamic_field_type, object))

					if reflector.is_copy_semantics_field (field_idx.item) then
							-- Update the reflector of the referenced item!
						ref_item := read_manager.cache_lookup (field.value.to_integer, dynamic_field_type)
						read_manager.item (ref_item).set_object (reflector.copy_semantics_field (field_idx.item))
					end
				else
					check implementation_error: False end
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	initialize_backend_representation (object: PS_OBJECT_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		local
			i, k: INTEGER
			tuple: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]

			backend_object: PS_BACKEND_OBJECT
			field_type: PS_TYPE_METADATA

			det_field: detachable ANY

			found: BOOLEAN
			is_expanded: BOOLEAN
			ref_item: PS_OBJECT_DATA
		do
			backend_object := object.backend_object

			from
				i := 1
			until
				i > object.reflector.field_count
			loop
				fixme ("Try to avoid unnecessary copies")
				if object.reflector.field_type (i) = object.reflector.expanded_type then
					det_field := object.reflector.expanded_field (i).object
					is_expanded := True
				else
					det_field := object.reflector.field (i)
					is_expanded := False
				end

				if attached det_field as field then
					field_type := write_manager.metadata_factory.create_metadata_from_object (field)

					if not basic_expanded_types.has (field_type.type.type_id) then
							-- Reference type
						from
							k := 0
							found := False
						until
							k >= object.references.count or found
						loop
							k := k + 1

							fixme ("[
								In theory the equality (=) operation should call `is_equal' on expanded objects.
								In practice this doesn't work on expanded types created by {REFLECTED_OBJECT}.object.
								Therefore we call the tilde (~) operator manually to ensure that `is_equal' is being
								called on copy-semantics objects
								]")


							if is_expanded then
								found :=  write_manager.item (object.references [k]).reflector.object ~ field
							else
								found :=  write_manager.item (object.references [k]).reflector.object = field
							end
						end

						check reference_found: k <= object.references.count end

						ref_item := write_manager.item (object.references [k])
						tuple := ref_item.handler.as_string_pair (ref_item)
						backend_object.add_attribute (object.reflector.field_name (i), tuple.value, tuple.type)
					else
							-- Value type
						backend_object.add_attribute (object.reflector.field_name (i), basic_attribute_value (field), field_type.name)
					end
				else
						-- Void reference
					backend_object.add_attribute (object.reflector.field_name (i), "", create {IMMUTABLE_STRING_8}.make_from_string ("NONE"))
				end
				i := i + 1
			end

		end

end
