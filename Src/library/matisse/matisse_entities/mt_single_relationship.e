indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"
	
class
	MT_SINGLE_RELATIONSHIP

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
		end

creation
	make, make_from_names, make_from_id

feature

	is_single: BOOLEAN is 
		once
			Result := True
		end

feature {MT_CLASS} -- Schema initialization
		
	setup_field (a_field_index: INTEGER; sample_obj: MT_STORABLE; a_db: MATISSE) is
			-- Initialize current as a relationship for a speicif class, 
			-- which is the class of sample_obj
		do
			set_field_index (a_field_index)
			database := a_db
		end

feature  -- Successors

	successors_of (an_object: MT_OBJECT): MT_ARRAY [MT_STORABLE] is
			-- Return the successor of an_object through the current relationship.
			-- (If no object found, return Void)
		do
			c_get_successors (an_object.oid, oid)
			if c_keys_count = 0 then
				!! Result.make (1, 0)
			else
				!MT_ARRAY [MT_STORABLE]! Result.make (1, 1)
				Result.put(database.new_eif_object_from_oid (c_ith_key(1)), 1)
			end
			c_free_keys
		end

feature {MATISSE} -- Persistence

	current_successors_of (an_object: MT_OBJECT): ARRAY [MT_STORABLE] is
			-- Get the successor(s) of an_object through the current relationship.
			-- (If the successor collection isn't filled in with successor objects,
			-- just return an empty collection).
		local
			temp: MT_STORABLE
		do
			!! Result.make (1, 1)
			temp ?= field (eif_field_index, an_object)
			Result.put (temp, 1)
		end

	set_successors_of (a_predecessor: MT_STORABLE) is
			-- Remove the old successor of an_object through the current 
			-- relationship, then add the current successor of an_object
			-- which is held by an_object.
		local
			a_succ: MT_OBJECT
			sid: INTEGER
		do
			a_succ ?= field (eif_field_index, a_predecessor)
			if a_succ = Void then
				c_remove_all_succs_ignore_nosuccessors (oid, a_predecessor.oid)
			else
				sid := c_get_single_successor (a_predecessor.oid, oid)
				if sid = 0 then
					c_add_successor_first (a_predecessor.oid, oid, a_succ.oid)
				elseif sid /= a_succ.oid then
					c_remove_all_successors (a_predecessor.oid, oid)
					c_add_successor_first (a_predecessor.oid, oid, a_succ.oid)
				end
			end
		end

	persist_successors_of (a_pred: MT_STORABLE) is
		local
			a: MT_STORABLE
		do
			a ?= field (eif_field_index, a_pred)
			if a /= Void then
				persist_if_not (a)
				c_add_successor_first (a_pred.oid, oid, a.oid)
			end
		end

	revert_to_unloaded (an_obj: MT_STORABLE) is
		do
			set_reference_field (eif_field_index, an_obj, Void)
		end
	
end -- class MT_SINGLE_RELATIONSHIP
