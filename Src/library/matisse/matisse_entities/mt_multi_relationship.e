indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_MULTI_RELATIONSHIP

inherit
	MT_RELATIONSHIP
		redefine
			is_single, 
			current_successors_of,
			set_successors_of,
			setup_field,
			successors_of,
			persist_successors_of,
			revert_to_unloaded
		select
			is_equal
		end
	
	MT_CONTAINER_TYPES
		rename
			is_equal as another_is_equal
		end
	
	MT_OBJECT_CREATION_EXTERNAL
		rename
			is_equal as another_is_equal
		end
	
creation
	make, make_from_names, make_from_id
	
feature

	is_single: BOOLEAN is 
		once
			Result := False
		end

	container_type: STRING
	
feature {MT_CLASS} -- Schema initialization
		
	setup_field (a_field_index: INTEGER; sample_obj: MT_STORABLE; a_db: MATISSE) is
			-- Initialize current as a relationship for a speicif class, 
			-- which is the class of sample_obj.
		local
			key_name: STRING
			c_string: ANY
			a_message: STRING
			an_exception: MT_EXCEPTIONS
		do
			set_field_index (a_field_index)
			database := a_db
			container_type := get_container_type
		end

	get_container_type: STRING is
		do
			Result := container_class_for_relationship (name)
		end

feature {MT_CLASS, MATISSE, MT_RS_CONTAINABLE} -- Successors loading

	successors_of (an_object: MT_STORABLE): MT_RS_CONTAINABLE is
			-- Return the successors of an_object through the current relationship.
			-- (If no object found, return empty collection).
		local
			keys_count: INTEGER
			a: ANY
		do
			c_get_successors (an_object.oid, oid)
			keys_count := c_keys_count
			a := container_type.to_c
			Result := c_create_empty_rs_container ($a, an_object.oid, oid)
			Result.set_predecessor (an_object)
			Result.set_relationship (Current)
			c_free_keys
		end

	load_successors (a_container: MT_RS_CONTAINABLE; an_obj: MT_STORABLE) is
			-- Fill in a_container with all the successors of an_obj through
			-- the current relationship.
		local
			a_count, i: INTEGER
			succ_oids: ARRAY [INTEGER]
			a_mt_collection: MT_LINEAR_COLLECTION [MT_STORABLE]
		do
			a_mt_collection ?= a_container
			if a_mt_collection /= Void then
				c_get_successors (an_obj.oid, oid)
				a_count := c_keys_count
				!! succ_oids.make (1, a_count)
				if a_count > 0 then
					from 
						i := 1
					until 
						i > a_count
					loop
						succ_oids.put (c_ith_key (i), i)
						i := i + 1
					end
				end
				if a_count > 0 then
					a_mt_collection.mt_resize_at_loading (a_count)
					from
						i := 1
					until
						i > a_count
					loop
						a_mt_collection.mt_put_at_loading (database.new_eif_object_from_oid(succ_oids.item(i)), i)
						i := i + 1
					end
				end
				c_free_keys
			end
		end

feature {MATISSE} -- Persistence

	persist_successors_of (a_pred: MT_STORABLE) is
		local
			a: MT_LINEAR_COLLECTION [MT_STORABLE]
			linear_rep: LINEAR [MT_STORABLE]
		do
			a ?= field (eif_field_index, a_pred)
			if a /= Void then
				linear_rep := a.linear_representation
				from
					linear_rep.start
				until
					linear_rep.off
				loop
					persist_if_not (linear_rep.item)
					c_add_successor_append (a_pred.oid, oid, linear_rep.item.oid)
					linear_rep.forth
				end
			end
		end
	
	current_successors_of (an_object: MT_OBJECT): ARRAY [MT_STORABLE] is
			-- Get the successor(s) of `an_object' through the current relationship.
			-- If the successor collection isn't filled in with successor objects,
			-- just return an empty collection.
		local
			collection: MT_LINEAR_COLLECTION [MT_STORABLE]
			linear_rep: LINEAR [MT_STORABLE]
			i: INTEGER
		do
			collection ?= field (eif_field_index, an_object)
			if collection = Void then
				!! Result.make (1, 0)
					-- Return an empty array
			else
				!! Result.make (1, collection.count)
				linear_rep := collection.linear_representation
				from
					linear_rep.start
					i := 1
				until
					linear_rep.exhausted
				loop
					Result.put (linear_rep.item, i)
					linear_rep.forth
					i := i + 1
				end
			end
		end

	set_successors_of (an_object: MT_STORABLE) is
			-- Remove the old successors of an_object through the current 
			-- relationship, then add the current successors of an_object
			-- which is held by an_object.
		local
			succs: MT_LINEAR_COLLECTION [MT_STORABLE]
			linear_rep: LINEAR [MT_OBJECT]
		do
			succs ?= field (eif_field_index, an_object)
			if succs /= Void and then succs.successors_loaded then
				linear_rep := succs.linear_representation
				c_remove_all_succs_ignore_nosuccessors (oid, an_object.oid)
				from
					linear_rep.start
				until
					linear_rep.exhausted
				loop
					c_add_successor_append (an_object.oid, oid, linear_rep.item.oid)
					linear_rep.forth
				end
			end
		end

	revert_to_unloaded (an_obj: MT_STORABLE) is
		local
			a_container: MT_RS_CONTAINABLE
		do
			a_container ?= field (eif_field_index, an_obj)
			if a_container /= Void then
				a_container.revert_to_unloaded
			end
		end
	
feature {MT_STORABLE} -- Container

	empty_container_for (a_predecessor: MT_STORABLE): MT_RS_CONTAINABLE is
			-- Return an empty container object.
			-- The container is initialized so that it can load successors later.
			-- ('predecessor' and 'relationship' are set to `a_predecesor' and `Current'.)
		local
			a: ANY
		do
			a := container_type.to_c
			Result := c_create_empty_rs_container ($a, a_predecessor.oid, oid)
			Result.set_predecessor (a_predecessor)
			Result.set_relationship (Current)
		end
		
end -- class MT_MULTI_RELATIONSHIP
