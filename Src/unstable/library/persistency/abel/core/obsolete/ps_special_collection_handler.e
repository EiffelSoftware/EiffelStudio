note
	description: "A colletion handler for SPECIAL that creates PS_OBJECT_COLLECTION_PARTs only."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SPECIAL_COLLECTION_HANDLER

inherit

	PS_COLLECTION_HANDLER_OLD [SPECIAL [detachable ANY]]

	REFACTORING_HELPER

create
	make

feature {PS_ABEL_EXPORT} -- Status report

	is_relationally_mapped (collection: PS_TYPE_METADATA; owner_type: PS_TYPE_METADATA): BOOLEAN
			-- Is `collection' mapped as a 1:N or M:N Relation between two objects?
		do
			Result := False
		end

	is_mapped_as_1_to_N (collection: PS_TYPE_METADATA; owner_type: PS_TYPE_METADATA): BOOLEAN
			-- Is `collection' mapped as a 1:N - Relation in the database?
		do
			Result := False
		end

feature {PS_ABEL_EXPORT} -- Object graph creation

	create_items (collection: PS_COLLECTION_PART; object_graph_factory: FUNCTION[detachable ANY, PS_OBJECT_GRAPH_PART]): LINKED_LIST[PS_OBJECT_GRAPH_PART]
			-- Iterate over the collection and call `object_graph_factory' on each item
		do
			create Result.make
			check attached {ITERABLE[detachable ANY]} collection.represented_object as real_collection then

				across
					real_collection as cursor
				loop
					Result.extend (object_graph_factory.item ([cursor.item]))
				end

			end
		end

	add_information (object_collection: PS_OBJECT_COLLECTION_PART)
			-- Add some additional information to `object_collection'
		do
			check attached {SPECIAL [detachable ANY]} object_collection.represented_object as actual_collection then
				object_collection.add_information ("capacity", actual_collection.capacity.out)
			end
		end

feature {PS_ABEL_EXPORT} -- Object retrieval

	build_collection (type_id: PS_TYPE_METADATA; objects: LIST [detachable ANY]; additional_information: PS_BACKEND_COLLECTION): SPECIAL [detachable ANY]
			-- Build a collection object of type `type' with items `objects', using `additional_information' that contains information generated during the last insert.
		local
			reflection: INTERNAL
			count: INTEGER
		do
			create reflection
			count := additional_information.get_information ("capacity").to_integer
			if reflection.is_special_any_type (type_id.type.type_id) then
				Result := reflection.new_special_any_instance (type_id.type.type_id, count)
			else
				fixme ("TODO: all other basic types")
				if type_id.actual_generic_parameter (1).type.out.is_equal ("BOOLEAN") then
					create {SPECIAL [BOOLEAN]} Result.make_empty (count)
				elseif type_id.actual_generic_parameter (1).type.out.is_equal ("CHARACTER_8") then
					create {SPECIAL [CHARACTER_8]} Result.make_empty (count)
				elseif type_id.actual_generic_parameter (1).type.out.is_equal ("INTEGER_32")  then
					create {SPECIAL [INTEGER]} Result.make_empty (count)
				else
					check not_implemented: False end
					create Result.make_empty (0)
				end
			end
			across
				objects as obj_cursor
			loop
				Result.extend (obj_cursor.item)
			end
		end

	build_relational_collection (type_id: PS_TYPE_METADATA; objects: LIST [detachable ANY]): SPECIAL [detachable ANY]
			-- Build a collection object of type `type' with items `objects'.
		do
			check
				implementation_error: False
			end
			create Result.make_empty (0)
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
		end

end
