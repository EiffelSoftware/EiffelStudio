note
	description: "A handler which maps its objects to PS_BACKEND_OBJECT."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_OBJECT_HANDLER

inherit
	PS_HANDLER

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_object: BOOLEAN = True
			-- Does `Current' map objects to a {PS_BACKEND_OBJECT}?

	is_mapping_to_collection: BOOLEAN = False
			-- Does `Current' map objects to a {PS_RETRIEVED_OBJECT_COLLECTION}?

feature {PS_ABEL_EXPORT} -- Read functions

	retrieve (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Retrieve `object' from the database.
		do
			read_manager.add_to_object_batch_retrieve (object)
		end

feature {PS_ABEL_EXPORT} -- Write functions

	generate_primary_key (object: PS_OBJECT_WRITE_DATA)
			-- Generate a primary key for `object'.
			-- If the object is not yet persistent, create a new primary key in the backend.
		do
			if not object.is_persistent then
				write_manager.object_primary_key_order [object.type] := write_manager.object_primary_key_order [object.type] + 1
			end
		end

	generate_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Create a new, uninitialized `backend_representation' for `object'.
		local
			new_command: PS_BACKEND_OBJECT
		do
			if object.is_persistent then
				create new_command.make (write_manager.primary_key_mapper.quick_translate (object.identifier, write_manager.transaction), object.type)
			else
				check attached write_manager.generated_object_primary_keys [object.type] as generated_list then
					new_command := generated_list.item
					generated_list.forth
					write_manager.primary_key_mapper.add_entry (create {PS_OBJECT_IDENTIFIER_WRAPPER}.make (object.identifier, object.reflector.object, object.type), new_command.primary_key, write_manager.transaction)
				end
			end
			object.set_backend_representation (new_command)
		end

	write_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Write `object.backend_representation' to the database.
		do
			write_manager.objects_to_write.extend (object.backend_object)
		end

end
