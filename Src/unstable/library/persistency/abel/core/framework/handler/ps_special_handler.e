note
	description: "Summary description for {PS_SPECIAL_HANDLER_NEW}."
	author: ""
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
			Result := attached {TYPE[detachable SPECIAL[detachable ANY]]} type.type
		end

feature {PS_ABEL_EXPORT} -- Read functions

	create_object (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Create a new, uninitialized Eiffel object instance for `object'.
		local
			index: INTEGER
			type: PS_TYPE_METADATA
			new_instance: SPECIAL[detachable ANY]
			reflector: REFLECTED_REFERENCE_OBJECT

			retrieved: PS_BACKEND_COLLECTION
			field_type: INTEGER
			i: INTEGER
			capacity: INTEGER

			field: TUPLE[value: STRING; type:STRING]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER

			item_type: INTEGER
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
					check not_implemented: False end
					create {SPECIAL [detachable ANY]} new_instance.make_empty (0)
				end

--				fixme ("TODO: all other basic types")
--				if type.actual_generic_parameter (1).type.out.is_equal ("BOOLEAN") then
--					create {SPECIAL [BOOLEAN]} new_instance.make_empty (capacity)
--				elseif type.actual_generic_parameter (1).type.out.is_equal ("CHARACTER_8") then
--					create {SPECIAL [CHARACTER_8]} new_instance.make_empty (capacity)
--				elseif type.actual_generic_parameter (1).type.out.is_equal ("CHARACTER_32") then
--					create {SPECIAL [CHARACTER_32]} new_instance.make_empty (capacity)
--				elseif type.actual_generic_parameter (1).type.out.is_equal ("INTEGER_32")  then
--					create {SPECIAL [INTEGER]} new_instance.make_empty (capacity)
--				else
--					check not_implemented: False end
--					create {SPECIAL [detachable ANY]} new_instance.make_empty (0)
--				end
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
			new_instance: SPECIAL[detachable ANY]
			reflector: REFLECTED_REFERENCE_OBJECT

			retrieved: PS_BACKEND_COLLECTION
			field_type: INTEGER
			i: INTEGER
			capacity: INTEGER

			field: TUPLE[value: STRING; type:STRING]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER
		do
			index := object.index
			type := object.type
			retrieved := object.backend_collection

			check attached {SPECIAL[detachable ANY]} object.reflector.object as inst then
				new_instance := inst
			end

			from
				i := 1
			until
				i > retrieved.collection_items.count
			loop
				field := retrieved.collection_items[i]

				if not field.type.is_equal ("NONE") then

					dynamic_field_type := read_manager.metadata_factory.create_metadata_from_type_id (internal_lib.dynamic_type_from_string (field.type))

					if read_manager.is_processable (field.value, dynamic_field_type) then
						new_instance.extend (read_manager.processed_object (field.value, dynamic_field_type, object))
					else
						read_manager.process_next (field.value.to_integer, dynamic_field_type, object)
						object.uninitialized_attributes.extend (i)
						new_instance.extend (Void)
					end
				else
					new_instance.extend (Void)
				end
				i := i + 1
			end
		end

	finish_initialize (object: PS_OBJECT_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		local
			index: INTEGER
			reflector: REFLECTED_OBJECT
			field: TUPLE[value: STRING; type:STRING]
			dynamic_field_type: PS_TYPE_METADATA
		do
			index := object.index
			across
				object.uninitialized_attributes as field_idx
			loop
				field := object.backend_collection.collection_items[field_idx.item]
				dynamic_field_type := type_from_string (field.type)

				check attached {SPECIAL[detachable ANY]} object.reflector.object as special then
					special.put (read_manager.processed_object (field.value, dynamic_field_type, object), field_idx.item-1)
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
			tuple: TUPLE[value: STRING; type: STRING]

			special: SPECIAL[detachable ANY]

			new_command: PS_BACKEND_COLLECTION
		do
			obj := object -- write_manager.objects[index]
			check attached {PS_BACKEND_COLLECTION} obj.backend_representation as cmd then
				new_command := cmd
			end

			check attached obj.type as t then
				type := t
			end

			check attached {SPECIAL[detachable ANY]} obj.reflector.object as sp then
				special := sp
			end

			from
				i := 1
				k := 1
			until
				i > special.count
			loop
				if obj.reflector.is_special_of_reference and not obj.reflector.is_special_copy_semantics_item (i-1) then
					-- Reference type
					from
						k := 1
					until
						k > obj.references.count or write_manager.item(obj.references[k]).reflector.object =  special.item (i-1)
					loop
						k := k + 1
					end

					if k > obj.references.count then
						tuple := ["", "NONE"]
					else
						check attached write_manager.item(obj.references[k]).handler as handler then
							tuple := handler.as_string_pair (write_manager.item (obj.references[k]))
						end
					end
					new_command.collection_items.extend ([tuple.value, tuple.type])
				else
					-- Value type
					if attached special.item (i-1) as field then
						new_command.collection_items.extend ([ basic_attribute_value(field), write_manager.metadata_factory.create_metadata_from_object (field).base_class.name])
					end
				end
				i := i + 1
			end

			new_command.add_information ("capacity", special.capacity.out)
		end

end
