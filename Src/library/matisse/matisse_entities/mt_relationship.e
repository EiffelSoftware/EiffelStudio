indexing
	description: "MATISSE-Eiffel Binding: representing Mt Relationship";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_RELATIONSHIP

inherit
	MT_PROPERTY
		rename 
			id as rid, 
			successors as mt_successors, 
			check_persistence as mt_storable_check_p
		redefine 
			predefined_eif_field
		end

	MT_RELATIONSHIP_EXTERNAL
		undefine 
			is_equal 
		end
		
creation
	make, make_from_names, make_from_id

feature {NONE} -- Initialization

	make (relationship_name: STRING) is
			-- Get relationship from database.
			-- An error raised if `relationship_name' is not unique in the schema.
		require
			string_not_void: relationship_name /= Void
			string_not_empty: not relationship_name.is_empty
		local
			relationship_name_to_c: ANY
		do
			relationship_name_to_c := relationship_name.to_c
			oid := c_get_relationship_from_name ($relationship_name_to_c)
		end

	make_from_names (relationship_name, cl_name: STRING) is
			-- Get relationship from database.
		require
			rel_not_void: relationship_name /= Void
			rel_not_empty: not relationship_name.is_empty
			cl_not_void: cl_name /= Void
			cl_not_empty: not cl_name.is_empty
		local
			relationship_name_to_c: ANY
			cl_name_to_c: ANY
		do
			relationship_name_to_c := relationship_name.to_c
			cl_name_to_c := cl_name.to_c
			oid := c_get_relationship_from_names ($relationship_name_to_c, $cl_name_to_c)
		end
				
feature {MT_OBJECT_REL_STREAM, MT_OBJECT_IREL_STREAM, MT_CLASS} -- Initialization

	make_from_id (rel_id: INTEGER) is
			-- Use id retrieved in Matisse to create Eiffel object
		do
			oid := rel_id
		end

feature -- Status Report

	check_relationship (one_object: MT_OBJECT): BOOLEAN is
			-- Check if relationship is OK
		do
			c_check_relationship (oid, one_object.oid)
		end

feature -- Accessing 
	successor_classes: ARRAY [MT_CLASS] is
			-- Types of objets available via relationship
		local
			a_stream: MT_RELATIONSHIP_STREAM
			a_class: MT_CLASS
			i: INTEGER
		do
			!! a_stream.make_from_name (Current, "Mt Successors")
			!! Result.make (0, 1)
			from
				a_stream.start
			until
				a_stream.exhausted
			loop
				a_class ?= a_stream.item
				if a_class /= Void then
					Result.put (a_class, i)
					i := i + 1
				end
				a_stream.forth
			end
			a_stream.close
		end

	
feature {MT_CLASS} -- Schema

	setup_field (field_index: INTEGER; sample_obj: MT_STORABLE; a_db: MATISSE) is
			-- Initialize current as a relationship for a speicif class, 
			-- which is the class of sample_obj
		do
			-- Descendants should redefine this.
			-- If this class can be a deferred class, this procedure
			-- can be deferred.
		end
	
	predefined_eif_field (a_field_name: STRING): BOOLEAN is
			-- Is a_field_name an attribute defined in this class?
		do
			Result := a_field_name.is_equal ("oid") or
					a_field_name.is_equal ("db") or
					a_field_name.is_equal ("attributes_loaded") or
					a_field_name.is_equal ("relationships_loaded") or
					a_field_name.is_equal ("eif_field_index") or
					a_field_name.is_equal ("is_single") or
					a_field_name.is_equal ("stream") 
		end

	setup_single is
		do
		end

	is_single: BOOLEAN is
			-- Is the current relationship's maximum cardinality 1?
		do
			Result := c_get_max_cardinality (oid) = 1
		end

feature -- Successors

	first_successor (an_object: MT_OBJECT): MT_STORABLE is
			-- Return the first successor of an_object through the current relationship
			-- (If no object found, return Void)
		do
			c_get_successors (an_object.oid, oid)
			if c_keys_count = 0 then
				Result := Void
			else
				Result := database.new_eif_object_from_oid (c_ith_key(1))
			end
			c_free_keys
		end

	successors_of (an_object: MT_OBJECT): MT_RS_CONTAINABLE is
			-- Return all the successors of an_object through the current relationship.
			-- (If no object found, return empty array)
		local
			count: INTEGER
		do
		end

feature {MATISSE} -- Persistence

	current_successors_of (an_object: MT_OBJECT): ARRAY [MT_STORABLE] is
			-- Get the successor(s) of an_object through the current relationship.
			-- If the successor collection isn't filled in with successor objects, 
			-- just return an empty collection.
		local
			collection: MT_ARRAY [MT_STORABLE]
			temp: MT_STORABLE
			i: INTEGER
		do
			if is_single then
				!! Result.make (1, 1)
				temp ?= field (eif_field_index, an_object)
				Result.put (temp, 1)
			else
				collection ?= field (eif_field_index, an_object)
				if collection = Void then
					!! Result.make (1, 0)
				else
					!! Result.make (collection.lower, collection.upper)
					from
						i := collection.lower
					until
						i > collection.upper
					loop
						Result.put (collection.item (i), i)
						i := i + 1
					end
				end
			end
		end

	set_successors_of (an_object: MT_STORABLE) is
			-- Remove the old successors of an_object through the current 
			-- relationship, then add the current successors of an_object
			-- which is held by an_object.
		do
		end

	append_successor (a_predecessor, new_successor: MT_STORABLE) is
		do
			if new_successor /= Void then
				c_add_successor_append (a_predecessor.oid, oid, new_successor.oid)
			end
		end
	
	persist_successors_of (a_pred: MT_STORABLE) is
		do
			--deferred
		end
		
	persist_if_not (an_obj: MT_STORABLE) is
		require
			not_void: an_obj /= Void
		do
			if not database.has (an_obj) then
				database.persist (an_obj)
			end
		end

	revert_to_unloaded (an_obj: MT_STORABLE) is
		do
			-- do nothing
			-- Descendants should redefine this.
		end
	
feature -- Storing

	set_successors (a_predecessor: MT_OBJECT; a_linear: LINEAR [MT_OBJECT]) is
		do
			c_remove_all_succs_ignore_nosuccessors (oid, a_predecessor.oid)
			from
				a_linear.start
			until
				a_linear.exhausted
			loop
				c_add_successor_append (a_predecessor.oid, oid, a_linear.item.oid)
				a_linear.forth
			end
		end


end -- class MT_RELATIONSHIP
