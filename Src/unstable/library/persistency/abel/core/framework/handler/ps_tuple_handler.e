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

	initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			retrieved: PS_BACKEND_COLLECTION
			count: INTEGER
			i: INTEGER

			field: STRING --TUPLE [value: STRING; type:IMMUTABLE_STRING_8]
			l_type: PS_TYPE_METADATA
		do
			retrieved := object.backend_collection
			count := retrieved.count

			check attached {TUPLE} object.reflector.object as tuple then
				from
					i := 1
				until
					i > count
				loop
					field := retrieved [i]
					l_type := read_manager.metadata_factory.create_metadata_from_string (retrieved.item_type (i))
					if
						not l_type.is_none and then
						attached read_manager.try_build_attribute (field, l_type, object) as obj
					then
						tuple [i] := obj
					end
					i := i + 1
				variant
					count + 1 - i
				end
			end
		end

	finish_initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		local
			retrieved: PS_BACKEND_COLLECTION
			count: INTEGER
			i: INTEGER

			field: STRING --TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			l_type: PS_TYPE_METADATA
		do
			retrieved := object.backend_collection
			count := retrieved.count

			check attached {TUPLE} object.reflector.object as tuple then
				from
					i := 1
				until
					i > count
				loop
					if not attached tuple [i] then
						field := retrieved [i]
						l_type := read_manager.metadata_factory.create_metadata_from_string (retrieved.item_type (i))
						if not l_type.is_none then
							tuple [i] := read_manager.build_attribute (field.to_integer, l_type, object)
						end
					end
					i := i + 1
				variant
					count + 1 - i
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	initialize_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		local
			obj: PS_OBJECT_WRITE_DATA
			i, k: INTEGER
			type: PS_TYPE_METADATA
			tuple: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]

			tuple_to_build: TUPLE

			new_command: PS_BACKEND_COLLECTION
		do
			obj := object
			new_command := obj.backend_collection
			type := obj.type

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
					new_command.extend (tuple.value, tuple.type)
				else
					-- Value type
					if attached tuple_to_build.item (i) as field then
						new_command.extend (basic_attribute_value (field), write_manager.metadata_factory.create_metadata_from_object (field).name)
					end
				end
				i := i + 1
			end
		end

end
