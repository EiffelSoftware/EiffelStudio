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
			-- <Precursor>

	is_mapping_to_collection: BOOLEAN = False
			-- <Precursor>

feature {PS_ABEL_EXPORT} -- Read functions

	retrieve (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		do
			read_manager.add_to_object_batch_retrieve (object)
		end

feature {PS_ABEL_EXPORT} -- Write functions

	generate_primary_key (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		do
			if not object.is_persistent then
				write_manager.object_primary_key_order [object.type] := write_manager.object_primary_key_order [object.type] + 1
			end
		end

	generate_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		local
			new_command: PS_BACKEND_OBJECT
		do
			if object.is_persistent then
				create new_command.make (write_manager.transaction.primary_key_table [object.identifier], object.type)
			else
				check attached write_manager.generated_object_primary_keys [object.type] as generated_list then
					new_command := generated_list.item
					generated_list.forth
					write_manager.transaction.primary_key_table.extend (new_command.primary_key, object.identifier)
				end
			end
			object.set_backend_representation (new_command)
		end

	write_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		do
			write_manager.objects_to_write.extend (object.backend_object)
		end

end
