note
	description: "Calls the appropriate features on the backend to insert objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_WRITE_EXECUTOR

inherit

	PS_ABEL_EXPORT

create
	make

feature {NONE} -- Initialization

	make (a_backend: PS_BACKEND_COMPATIBILITY; an_id_manager: PS_OBJECT_IDENTIFICATION_MANAGER)
			-- Initialize `Current'.
		do
			backend := a_backend
			id_manager := an_id_manager
		end

feature {PS_ABEL_EXPORT} -- Status report

	can_backend_handle_operations (operation_plan: LIST [PS_OBJECT_GRAPH_PART]): BOOLEAN
			-- Can the backend handle all operations in `operation_plan'?
		do
			across
				operation_plan as op_cursor
			from
				Result := True
			loop
				if attached {PS_SINGLE_OBJECT_PART} op_cursor.item as obj then
					Result := Result and backend.is_object_type_supported (obj.metadata)
				elseif attached {PS_OBJECT_COLLECTION_PART} op_cursor.item as coll then
					Result := Result and backend.can_handle_object_oriented_collection (coll.metadata)
				elseif attached {PS_RELATIONAL_COLLECTION_PART} op_cursor.item as coll then
					Result := Result and backend.can_handle_relational_collection (coll.reference_owner.metadata, coll.metadata.actual_generic_parameter (1))
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Basic operations

	perform_operations (operation_plan: LIST [PS_OBJECT_GRAPH_PART]; transaction: PS_INTERNAL_TRANSACTION)
			-- Performs all operations in `operation_plan'.
		do
			across
				operation_plan as op_cursor
			loop
				if attached {PS_SINGLE_OBJECT_PART} op_cursor.item as obj then
					handle_object (obj, transaction)
				elseif attached {PS_OBJECT_COLLECTION_PART} op_cursor.item as coll then
					handle_object_collection (coll, transaction)
				elseif attached {PS_RELATIONAL_COLLECTION_PART} op_cursor.item as coll then
					handle_relational_collection (coll, transaction)
				end
			end
		end

feature {NONE} -- Implementation

	handle_object (object: PS_SINGLE_OBJECT_PART; transaction: PS_INTERNAL_TRANSACTION)
			-- Perform a write operation on `object'.
		local
			attribute_values: LINKED_LIST [PS_OBJECT_GRAPH_PART]
		do
			across
				object.attributes as attr
			from
				create attribute_values.make
			loop
				attribute_values.extend (object.attribute_value (attr.item))
			end
			identify_all (object, attribute_values.new_cursor, transaction)
			if object.write_operation = object.write_operation.insert then
				backend.insert (object, transaction)
			elseif object.write_operation = object.write_operation.update then
				backend.update (object, transaction)
			elseif object.write_operation = object.write_operation.delete then
				backend.delete (object, transaction)
			end
		end

	handle_object_collection (object_collection: PS_OBJECT_COLLECTION_PART; transaction: PS_INTERNAL_TRANSACTION)
			-- Perform a write operation on `object_collection'.
		do
			identify_all (object_collection, object_collection.values.new_cursor, transaction)
			if object_collection.write_operation = object_collection.write_operation.insert then
				backend.insert_object_oriented_collection (object_collection, transaction)
			elseif object_collection.write_operation = object_collection.write_operation.update then
				backend.update_object_oriented_collection (object_collection, transaction)
			elseif object_collection.write_operation = object_collection.write_operation.delete then
				backend.delete_object_oriented_collection (object_collection, transaction)
			else
				check
					wrong_operation: False
				end
			end
		end

	handle_relational_collection (relational_collection: PS_RELATIONAL_COLLECTION_PART; transaction: PS_INTERNAL_TRANSACTION)
			-- Perform a write operation on `relational_collection'.
		do
			identify_all (relational_collection, relational_collection.values.new_cursor, transaction)
			if relational_collection.write_operation = relational_collection.write_operation.insert then
				backend.insert_relational_collection (relational_collection, transaction)
			elseif relational_collection.write_operation = relational_collection.write_operation.delete then
				backend.delete_relational_collection (relational_collection, transaction)
			else
				check
					wrong_operation: False
				end
			end
		end

	identify_all (object: PS_COMPLEX_PART; referenced_objects: ITERATION_CURSOR [PS_OBJECT_GRAPH_PART]; transaction: PS_INTERNAL_TRANSACTION)
			-- Identify `object' and all `referenced_objects' and set a wrapper for all of them.
		local
			value: PS_OBJECT_GRAPH_PART
		do
			from
			until
				referenced_objects.after
			loop
				value := referenced_objects.item
				if attached {PS_COMPLEX_PART} value as complex then
					if not id_manager.is_identified (complex.represented_object, transaction) then
						id_manager.identify (complex.represented_object, transaction)
					end
					complex.set_object_wrapper (id_manager.identifier_wrapper (complex.represented_object, transaction))
				end
				referenced_objects.forth
			end
			if not id_manager.is_identified (object.represented_object, transaction) then
				id_manager.identify (object.represented_object, transaction)
			end
			object.set_object_wrapper (id_manager.identifier_wrapper (object.represented_object, transaction))
		end

feature {NONE} -- Implementation

	backend: PS_BACKEND_COMPATIBILITY
			-- The backend to execute the operations on.

	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER
			-- The identification manager used to generate unique object identifiers for the objects in an operation plan.

end
