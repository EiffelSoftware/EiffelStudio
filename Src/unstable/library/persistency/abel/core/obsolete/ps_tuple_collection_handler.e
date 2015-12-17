note
	description: "Summary description for {PS_TUPLE_COLLECTION_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TUPLE_COLLECTION_HANDLER

inherit
	PS_COLLECTION_HANDLER_OLD [TUPLE]
		redefine
			create_collection_part
		end

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

	create_collection_part (collection: ANY; metadata: PS_TYPE_METADATA; persistent: BOOLEAN; owner: PS_OBJECT_GRAPH_PART): PS_OBJECT_GRAPH_PART
			-- Create a new OBJECT_GRAPH_PART for `collection'.
		do
				-- Create relational or object collection based on `is_relationally_mapped'
			check attached {TUPLE} collection as tuple then
				create {PS_OBJECT_COLLECTION_PART} Result.make (tuple, metadata, persistent, Current, owner.root)
			end
		end

	create_items (collection: PS_COLLECTION_PART; object_graph_factory: FUNCTION[detachable ANY, PS_OBJECT_GRAPH_PART]): LINKED_LIST[PS_OBJECT_GRAPH_PART]
			-- Iterate over the collection and call `object_graph_factory' on each item
		local
			i:INTEGER
		do
			check attached {TUPLE} collection.represented_object as tuple then
				from
					i:= 1
					create Result.make
				until
					i > tuple.count
				loop
					Result.extend (object_graph_factory.item ([ tuple[i] ]) )
					i := i+1
				end
			end
		end

	add_information (object_collection: PS_OBJECT_COLLECTION_PART)
			-- Add some additional information to `object_collection'.
		do
		end

feature {PS_ABEL_EXPORT} -- Object retrieval

	build_collection (collection_type: PS_TYPE_METADATA; objects: LIST [detachable ANY]; additional_information: PS_BACKEND_COLLECTION): TUPLE
			-- Build a collection object of type `collection_type' with items `objects', using `additional_information' that contains information generated during the last insert.
		local
			reflection: INTERNAL
			index: INTEGER
		do
			create reflection

			check attached {TUPLE} reflection.new_instance_of (collection_type.type.type_id) as tup then
				across
					objects as cursor
				from
					Result :=tup
					index := 1
				loop
					tup.put (cursor.item, index)
					index := index + 1
				end
			end

		end

	build_relational_collection (collection_type: PS_TYPE_METADATA; objects: LIST [detachable ANY]): TUPLE
			-- Build a collection object of type `collection_type' with items `objects'.
		do
			check
				implementation_error: False
			end
			create Result
		end




end
