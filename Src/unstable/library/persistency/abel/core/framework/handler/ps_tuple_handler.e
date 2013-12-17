note
	description: "Handler for TUPLE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TUPLE_HANDLER

inherit
	PS_COLLECTION_HANDLER

create
	make, default_create

feature {NONE} -- Impementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		do
			Result := attached {TYPE [detachable TUPLE]} type.type
		end

feature {PS_ABEL_EXPORT} -- Read functions

	initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			index: INTEGER
			type: PS_TYPE_METADATA
			new_instance: detachable ANY
			reflector: REFLECTED_REFERENCE_OBJECT

			retrieved: PS_BACKEND_COLLECTION
			field_type: INTEGER
			i: INTEGER
			count: INTEGER
			capacity: INTEGER

			field: TUPLE [value: STRING; type:IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER
		do
			index := object.index
			type := object.type
			retrieved := object.backend_collection
			new_instance := object.reflector.object

			check attached {TUPLE} new_instance as tuple then
				from
					i := 1
					count := retrieved.collection_items.count
					object.to_initialize.make_filled (count)
				until
					i > retrieved.collection_items.count
				loop
					field := retrieved.collection_items [i]

					if not field.type.is_equal ("NONE") then

						dynamic_field_type := read_manager.metadata_factory.create_metadata_from_type_id (internal_lib.dynamic_type_from_string (field.type))

						if read_manager.is_processable (field.value, dynamic_field_type) then
							tuple.put (read_manager.processed_object (field.value, dynamic_field_type, object), i)
						else
							read_manager.process_next (field.value.to_integer, dynamic_field_type, object)

							object.to_initialize.put_i_th (dynamic_field_type, i)
						end
					end
					i := i + 1
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

			i: INTEGER
			count: INTEGER
			retrieved: PS_BACKEND_COLLECTION
		do
			retrieved := object.backend_collection

			from
				i := 1
				count := retrieved.collection_items.count
			until
				i > retrieved.collection_items.count
			loop
				if attached object.to_initialize [i] as l_type  then
					dynamic_field_type := l_type
					field := object.backend_collection.collection_items [i]

					check attached {TUPLE} object.reflector.object as tuple then
						tuple.put (read_manager.processed_object (field.value, dynamic_field_type, object), i)
					end
				end
				i := i + 1
			end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	initialize_backend_representation (object: PS_OBJECT_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		local
			obj: PS_OBJECT_DATA
			i, k: INTEGER
			type: PS_TYPE_METADATA
			tuple: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]

			tuple_to_build: TUPLE

			new_command: PS_BACKEND_COLLECTION
		do
			obj := object
			check attached {PS_BACKEND_COLLECTION} obj.backend_representation as cmd then
				new_command := cmd
			end

			check attached obj.type as t then
				type := t
			end

			check attached {TUPLE} obj.reflector.object as t then
				tuple_to_build := t
			end

			from
				i := 1
				k := 1
			until
				i > tuple_to_build.count
			loop
				if attached tuple_to_build.item (i) as field and then not field.generating_type.is_expanded then
					-- Reference type
					from
						k := 1
					until
						k > obj.references.count or write_manager.item (obj.references [k]).reflector.object =  field
					loop
						k := k + 1
					end

					if k > obj.references.count then
						tuple := ["", create {IMMUTABLE_STRING_8}.make_from_string ("NONE")]
					else
						check attached write_manager.item (obj.references [k]).handler as handler then
							tuple := handler.as_string_pair (write_manager.item (obj.references [k]))
						end
					end
					new_command.collection_items.extend ([tuple.value, tuple.type])
				else
					-- Value type
					if attached tuple_to_build.item (i) as field then
						new_command.collection_items.extend ([ basic_attribute_value (field), write_manager.metadata_factory.create_metadata_from_object (field).name])
					end
				end
				i := i + 1
			end
		end

end
