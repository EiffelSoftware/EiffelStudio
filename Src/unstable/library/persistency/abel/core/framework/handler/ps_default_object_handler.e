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
			Result := not attached {TYPE[detachable SPECIAL[detachable ANY]]} type.type and not attached {TYPE[detachable TUPLE]} type.type
		end

feature {PS_ABEL_EXPORT} -- Read functions

	initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			new_instance: detachable ANY
			reflector: REFLECTED_OBJECT

			retrieved: PS_BACKEND_OBJECT
			field_type: INTEGER
			field_name: STRING
			i: INTEGER

			field: TUPLE[value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER
		do
			new_instance := object.reflector.object
			reflector := object.reflector

			retrieved := object.backend_object

			from
				i := 1
			until
				i > reflector.field_count
			loop
				field_type := reflector.field_type (i)
				field_name := reflector.field_name (i)
				if retrieved.has_attribute (field_name) then
					field := retrieved.attribute_value (reflector.field_name (i))

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

					else -- NONE, POINTER, References and expanded userdefined attributes

						-- Try to assign as much as possible
						check expanded_not_implemented: field_type = reference_type end

						if not field.type.is_equal ("NONE") then
							dynamic_field_type := type_from_string (field.type)

							if read_manager.is_processable (field.value, dynamic_field_type) then
								if attached read_manager.processed_object (field.value, dynamic_field_type, object) as val then
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
			field: TUPLE[value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA

			trash: INTEGER
		do
			index := object.index
			across
				object.uninitialized_attributes as field_idx
			from
				reflector := object.reflector
			loop
				field := object.backend_object.attribute_value (reflector.field_name (field_idx.item))
				dynamic_field_type := type_from_string (field.type)

				reflector.set_reference_field (field_idx.item, read_manager.processed_object (field.value, dynamic_field_type, object))
			end


			-- HASH_TABLE fix:
			-- The internal_hash_code of STRING doesn't get stored , but we can recreate it easily
			if attached {HASH_TABLE[detachable ANY, READABLE_STRING_GENERAL]} reflector.object as table then
				across
					table as cursor
				loop
					trash := cursor.key.hash_code
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
			tuple: TUPLE[value: STRING; type: IMMUTABLE_STRING_8]

			new_command: PS_BACKEND_OBJECT
		do
			obj := object--write_manager.objects[index]
			check attached {PS_BACKEND_OBJECT} obj.backend_representation as cmd then
				new_command := cmd
			end

			check attached obj.type as t then
				type := t
			end

			from
				i := 1
				k := 1
			until
				i > obj.reflector.field_count
			loop
				if obj.reflector.field_type (i) = obj.reflector.reference_type and not obj.reflector.is_copy_semantics_field (i) then
					-- Reference type
					from
						k := 1
					until
						k > obj.references.count or write_manager.item(obj.references[k]).reflector.object =  obj.reflector.field (i)
					loop
						k := k + 1
					end
					if k > obj.references.count then
						tuple := ["", create {IMMUTABLE_STRING_8}.make_from_string ("NONE")]
					else
						check attached write_manager.item(obj.references[k]).handler as handler then
							tuple := handler.as_string_pair (write_manager.item (obj.references[k]))
						end
					end
					new_command.add_attribute (obj.reflector.field_name (i), tuple.value, tuple.type)
				else
					-- Value type
					if attached obj.reflector.field (i) as field then
						new_command.add_attribute (obj.reflector.field_name (i), basic_attribute_value(field), write_manager.metadata_factory.create_metadata_from_object (field).base_class.name)
					end
				end
				i := i + 1
			end

		end

end
