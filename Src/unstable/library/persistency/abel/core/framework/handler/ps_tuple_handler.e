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
			-- <Precursor>
		do
			Result := attached {TYPE [detachable TUPLE]} type.type
		end

feature {PS_ABEL_EXPORT} -- Read functions

	initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		local
			retrieved: PS_BACKEND_COLLECTION
			count: INTEGER
			i: INTEGER

			field: STRING
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
					l_type := read_manager.type_factory.create_metadata_from_string (retrieved.item_type (i))
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
			-- <Precursor>
		local
			retrieved: PS_BACKEND_COLLECTION
			count: INTEGER
			i: INTEGER

			field: STRING
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
						l_type := read_manager.type_factory.create_metadata_from_string (retrieved.item_type (i))
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

end
