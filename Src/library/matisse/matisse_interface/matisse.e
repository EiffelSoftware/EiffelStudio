indexing
	description: "Representing a database session"
	date: "$Date$"
	revision: "$Revision$"

class 
	MATISSE

inherit
    MT_EXCEPTIONS
		rename
			trigger as trigger_exception,
			class_name as exceptin_class_name
     	export
    		{NONE} all
    	end
    
	MT_OBJECT_CREATION_EXTERNAL

	MT_KEYS_EXTERNAL

	MT_CLASS_EXTERNAL

	MT_OBJECT_EXTERNAL

	MT_ATTRIBUTE_EXTERNAL
	
	MT_DB_CONTROL_EXTERNAL
	
creation
	make

feature -- Initialization
	
	make is
		do
		end
	
	check_cache is
		do 
			eif_object_table.check_content 
		end

	version_access_started is
			-- A version access has just started
		do
			if need_cache_update then
				update_object_table
			end
			load_mt_classes
		end

	version_access_ended is
			-- A version access has just ended
		do
		end
	
	transaction_started is
			-- A transaction has just started
		do
			if need_cache_update then
				update_object_table
			end
			!! attr_modified_set.make
			!! rl_modified_set.make
			!! container_modified_set.make
			load_mt_classes
		end

	transaction_committed is
			-- A transaction has just been committed.
		do
			attr_modified_set := Void
			rl_modified_set := Void
			container_modified_set := Void
		end
	
	transaction_aborted is
			-- A transaction has just been aborted.
		do
			attr_modified_set := Void
			rl_modified_set := Void
			container_modified_set := Void
		end
	
	connected is
			-- The connection has just been disconnected.
		do
			!! eif_object_table.make (100)
		end
	
	disconnected is
			-- The connection has just been disconnected.
		do
			eif_object_table := Void
			attr_modified_set := Void
			rl_modified_set := Void
			container_modified_set := Void
		end


feature {NONE} -- Status

	transaction_open: BOOLEAN is
		do
			Result := rl_modified_set /= Void
		end
	
	need_cache_update: BOOLEAN is
			-- Is it necessary to do cache-update job?
		do
			Result := True
			-- to be done.
		end
	
	current_logical_time: INTEGER
	
	previous_logical_time: INTEGER
	
	mt_connection: INTEGER
	
feature {MT_DB_CONTROL}

	set_mt_connection (an_id: INTEGER) is
		do
			mt_connection := an_id
		end


feature {NONE} -- Schema implementation
	
	mt_schema: HASH_TABLE [MT_CLASS, INTEGER]
			-- Key:   Eiffel type id
			-- Value: Instance of MT_CLASS
	
	eif_object_table: MT_OBJECT_TABLE [MT_STORABLE, INTEGER]
			-- Cache table of replicated eiffel object
			--   Key:   MATISSE oid
			--   Value: Eiffel object

	attr_modified_set: BINARY_SEARCH_TREE_SET [INTEGER]
			-- Set of oid of objects whose attributes are modified

	rl_modified_set: BINARY_SEARCH_TREE_SET [INTEGER]
			-- Set of oid of objects whose relationships are modified
	
	container_modified_set: BINARY_SEARCH_TREE_SET [INTEGER]
			-- Set of container objects which are modified.

	update_object_table is
		do
			from
				eif_object_table.start
			until
				eif_object_table.off
			loop
				eif_object_table.item_for_iteration.become_obsolete
				eif_object_table.forth
			end
		end
		
feature -- Schema

	load_mt_classes is
			-- Load all instances of "Mt Class" without using
			-- this binding mechanism
		local
			cids: ARRAY [INTEGER]
			i: INTEGER
			a_class: MT_CLASS
		do
			cids := oids_of_all_classes
			!! mt_schema.make (cids.count)
			from
				i := cids.lower
			until
				i > cids.upper
			loop
				!! a_class.make_from_oid (cids.item (i))
				a_class.set_database (Current)
				mt_schema.put (a_class, a_class.eiffel_type_id)
				i := i + 1
			end
		end
	
	load_mt_schema is
		local
			a_class, each_class: MT_CLASS
			all_classes: ARRAY [MT_OBJECT]
			i: INTEGER
		do
			!! a_class.make_from_name ("Mt Class")
			all_classes := a_class.all_instances
			!! mt_schema.make (all_classes.count)
			
			from
				i := all_classes.lower
			until
				i > all_classes.upper
			loop
				each_class ?= all_classes.item (i)
				each_class.set_database (Current)
				mt_schema.put (each_class, each_class.eiffel_type_id)
				i := i + 1
			end
		end

	mt_class_from_object (an_object: ANY): MT_CLASS is
		require
			not_void: an_object /= Void
		do
			mt_schema.search (dynamic_type (an_object))
			if mt_schema.found then
				Result := mt_schema.found_item
			end
		end
	
	get_mt_class_from_name (a_class_name: STRING): MT_CLASS is
		require
			not_void: a_class_name /= Void
		local
			c_class_name: ANY
			type_id: INTEGER
		do
			c_class_name := a_class_name.to_c
			type_id := c_get_eiffel_type_id_from_name ($c_class_name)
			Result := mt_schema.item (type_id)
		end

	get_attribute_from_name (attr_name, a_class_name: STRING): MT_ATTRIBUTE is
		require
			attr_name_not_void: attr_name /= Void
		local
			aid, type_id, i: INTEGER
			c_class_name, c_attr_name: ANY
			a_class: MT_CLASS
			attributes: ARRAY [MT_ATTRIBUTE]
			an_attr: MT_ATTRIBUTE
		do
			if a_class_name /= Void then
				c_class_name := a_class_name.to_c
				type_id := c_get_eiffel_type_id_from_name ($c_class_name)
				a_class := mt_schema.item (type_id)
				if a_class.properties_initialized then
					attributes := a_class.attributes
				else
					attributes := a_class.get_attributes
				end
				from
					i := attributes.lower
				until
					i > attributes.upper or Result /= Void
				loop
					an_attr := attributes.item (i)
					if an_attr /= Void then
						if an_attr.eiffel_name.is_equal (attr_name) then
							Result := an_attr
						end
					end
					i := i + 1
				end
			end
			
			if Result = Void then
				c_attr_name := attr_name.to_c
				aid := c_get_attribute ($c_attr_name)
					-- If no attribute is found, an exception will be raised
					-- from C environment.
				!! Result.make_from_id (aid)
			end
		ensure
			Result_not_void: Result /= Void
				-- If no attribute is found, an exception will be raised
				-- from C environment.
		end
		
			
feature {MT_STORABLE} -- Modification marking

	mark_attrs_modified (an_oid: INTEGER) is
			-- All attributes of the object are set a mark of modification.
		do
			if not transaction_open then
				trigger_dev_exception (Matisse_Notran, "Transaction not opened")
			else
				attr_modified_set.put (an_oid)
			end
		end

	mark_rls_modified (an_oid: INTEGER) is
			-- All relationships of the object are set a mark of modification.
		do
			if not transaction_open then
				trigger_dev_exception (Matisse_Notran, "Transaction not opened")
			else
				rl_modified_set.put (an_oid)
			end
		end
	
	mark_container_modified (an_oid: INTEGER) is
			-- This is used for container object such as HASH_TABLE.
		do
			if not transaction_open then
				trigger_dev_exception (Matisse_Notran, "Transaction not opened")
			else
				container_modified_set.put (an_oid)
			end
		end

feature -- Object cache

	has (an_object: MT_STORABLE): BOOLEAN is
			-- Is an_object included in the cache table?
		do
			eif_object_table.search (an_object.oid)
			if eif_object_table.found then
				Result := eif_object_table.found_item = an_object
			else
				Result := False
			end
		end
	
	persist (an_object: MT_STORABLE) is
			-- Adopt an_object as MATISSE persistent object.
			-- Create new MATISSE object (using MtCreateObject),
			-- add an_object into cache eif_object_table, add oid of
			-- an_object into attr_modified_set and rl_modified_set
			-- so that all values of an_object are stored in a database.
		require 
			 not has (an_object)
		local
			a_class: MT_CLASS
			index, new_oid: INTEGER
			relationships: ARRAY [MT_RELATIONSHIP]
			attributes: ARRAY [MT_ATTRIBUTE]
			succs: ARRAY [MT_STORABLE]
			a_rs: MT_RELATIONSHIP
			an_att: MT_ATTRIBUTE
		do
			a_class := mt_schema.item (dynamic_type (an_object))
			new_oid := c_create_object_from_cid (a_class.oid)
			an_object.set_oid (new_oid)
			an_object.set_db (Current)
			a_class.init_properties (an_object)
				-- Initialize attributes and relationships before calling mt_make ()
			an_object.mt_make (a_class)
				-- Initialize an_object as a persistent object.
			eif_object_table.extend (an_object, new_oid)
			attributes := a_class.attributes
			from 
				index := attributes.lower
			until 
				index > attributes.upper
			loop
				an_att := attributes.item (index)
				if an_att /= Void then
					an_att.set_value_not_default (an_object)
				end
					-- In the explicit promotion to persistent object, if attribute
					-- value is void then do nothing (its attribute value in the 
					-- database object remains unspecified)
				index := index + 1
			end
			
			--mark_rls_modified (new_oid)
			relationships := a_class.relationships
			from
				index := relationships.lower
			until
				index > relationships.upper
			loop
				a_rs := relationships.item (index)
				if a_rs /= Void then
					a_rs.persist_successors_of (an_object)
				end
				index := index + 1
			end
			
			-- added by SM, 01/07/99
			-- As the `an_object' is just created, its attributes
			-- and relationships can be considered as loaded.
			an_object.loading_attrs_done
			an_object.loading_relationships_done
		end
	
	safe_wean (an_obj: MT_STORABLE) is
			-- Discard an_obj from eif_obj_table
		do
			if not (attr_modified_set.has (an_obj.oid) or rl_modified_set.has (an_obj.oid)) then
				eif_object_table.remove (an_obj.oid)
				an_obj.dispose
			end
		end

	delete_object (an_obj: MT_STORABLE) is
			-- Delete an_obj from the database and also from the 'eif_obj_table'
		do
			delete_composite_part (an_obj)
			c_remove_object (an_obj.oid)
			eif_object_table.remove (an_obj.oid)
			an_obj.set_oid (0) -- become transient
		end
	
	delete_composite_part (an_obj: MT_STORABLE) is
		-- Delete part objects of an_obj 
		-- (supporting CompositeRelationship concept.
		local
			a_class: MT_CLASS
			relationships: ARRAY [MT_RELATIONSHIP]
			co_rel: MT_COMPOSITE_RELATIONSHIP
			s_co_rel: MT_SINGLE_COMPOSITE_RELATIONSHIP
			m_co_rel: MT_MULTI_COMPOSITE_RELATIONSHIP
			i: INTEGER
			a_storable: MT_STORABLE
			linear_collection: MT_LINEAR_COLLECTION [MT_STORABLE]
			linear_rep: LINEAR [MT_STORABLE]
			rs_containable: MT_RS_CONTAINABLE
		do
			a_class := mt_class_from_object (an_obj)
			a_class.init_properties (an_obj)
			relationships := a_class.relationships
			from 
				i := relationships.lower
			until 
				i > relationships.upper
			loop
				co_rel ?= relationships.item (i)
				if co_rel /= Void then
					s_co_rel ?= co_rel
					if s_co_rel /= Void then
						a_storable ?= field (s_co_rel.eif_field_index, an_obj)
						if a_storable /= Void then
							delete_object (a_storable)
						else
							a_storable := s_co_rel.first_successor (an_obj)
							if a_storable /= Void then
								delete_object (a_storable)
							end
						end
					else
						m_co_rel ?= co_rel
						linear_collection ?= field (m_co_rel.eif_field_index, an_obj)
						if linear_collection /= Void then
							rs_containable ?= linear_collection
							rs_containable.load_successors
							linear_rep := linear_collection.linear_representation
							from 
								linear_rep.start
							until 
								linear_rep.off
							loop
								delete_object (linear_rep.item)
								linear_rep.forth
							end
						end
					end
				end
				i := i + 1
			end
		end

	check_persistence (an_object: MT_STORABLE) is
		do
			if an_object /= Void and then not has (an_object) then
				persist (an_object)
			end
		end
	
feature -- New eiffel object

	new_eif_object_from_oid, eif_object_from_oid (a_mt_oid: INTEGER): MT_STORABLE is
		local
			a_class: MT_CLASS
		do
			eif_object_table.search (a_mt_oid)
			if eif_object_table.found then
				Result := eif_object_table.found_item
			else
				Result := c_dynamic_create_eif_object (a_mt_oid)
				Result.set_db (Current)
				Result.set_oid (a_mt_oid)
				Result.set_db (Current)
				a_class := mt_class_from_object (Result)
				a_class.init_properties (Result)
				Result.mt_make (a_class)
				eif_object_table.extend (Result, a_mt_oid)
			end
		end

feature {MT_CONTAINER_OBJECT} -- New eiffel container object

	create_new_container (a_class_name: STRING): INTEGER is
		local
			to_c: ANY
		do
			to_c := a_class_name.to_c
			Result := c_create_object ($to_c)
		end
	
	register_container (a_container: MT_STORABLE) is
		do
			eif_object_table.force (a_container, a_container.oid)
		end
		
feature -- Retrieving, storing and removing attribute value
	
	get_attr_value_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : ANY is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_value (an_obj)
		end

	get_attr_value_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): ANY is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_value (an_obj)
		end

	-- MT_BOOLEAN --
	get_boolean_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): BOOLEAN is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_boolean (an_obj)
		end

	get_boolean_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): BOOLEAN is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_boolean (an_obj)
		end

	-- MT_DATE --
	get_date_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): DATE is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_date (an_obj)
		end

	get_date_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): DATE is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_date (an_obj)
		end
	
	-- MT_TIMESTAMP --
	get_timestamp_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): DATE_TIME is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_timestamp (an_obj)
		end

	get_timestamp_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): DATE_TIME is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_timestamp (an_obj)
		end


	-- MT_TIME_INTERVAL --
	get_time_interval_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): DATE_TIME_DURATION is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_time_interval (an_obj)
		end

	get_time_interval_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): DATE_TIME_DURATION is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_time_interval (an_obj)
		end

	-- MT_S32 --	
	get_integer_value_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_integer (an_obj)
		end

	get_integer_value_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_integer (an_obj)
		end

	get_integer_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_integer_array (an_obj)
		end

	get_integer_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_integer_array (an_obj)
		end

	get_integer_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_integer_list (an_obj)
		end

	get_integer_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_integer_list (an_obj)
		end

	-- MT_U32 --	
	get_unsigned_int_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_unsigned_int (an_obj)
		end

	get_unsigned_int_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_unsigned_int (an_obj)
		end

	get_unsigned_int_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_unsigned_int_array (an_obj)
		end

	get_unsigned_int_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_unsigned_int_array (an_obj)
		end

	get_unsigned_int_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_unsigned_int_list (an_obj)
		end

	get_unsigned_int_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_unsigned_int_list (an_obj)
		end
	
	-- MT_S16 --	
	get_short_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_short (an_obj)
		end

	get_short_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_short (an_obj)
		end

	get_short_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_short_array (an_obj)
		end

	get_short_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_short_array (an_obj)
		end

	get_short_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_short_list (an_obj)
		end

	get_short_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_short_list (an_obj)
		end
	
	-- MT_U16 --	
	get_unsigned_short_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_unsigned_short (an_obj)
		end

	get_unsigned_short_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_unsigned_short (an_obj)
		end

	get_unsigned_short_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING): ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_unsigned_short_array (an_obj)
		end

	get_unsigned_short_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER): ARRAY [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_unsigned_short_array (an_obj)
		end

	get_unsigned_short_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_unsigned_short_list (an_obj)
		end

	get_unsigned_short_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : LINKED_LIST [INTEGER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_unsigned_short_list (an_obj)
		end
	
	-- MT_U8 --	
	get_byte_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_byte (an_obj)
		end

	get_byte_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_byte (an_obj)
		end

	get_byte_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : ARRAY [CHARACTER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_byte_array (an_obj)
		end

	get_byte_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : ARRAY [CHARACTER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_byte_array (an_obj)
		end

	get_byte_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : LINKED_LIST [CHARACTER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_byte_list (an_obj)
		end

	get_byte_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : LINKED_LIST [CHARACTER] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_byte_list (an_obj)
		end
	
	get_byte_list_elements_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER; 
			buffer: ARRAY [CHARACTER]; count, offset: INTEGER) : INTEGER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_byte_list_elements (an_obj, buffer, count, offset)
		end
	
	-- MT_FLOAT --
	get_real_value_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : REAL is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_real (an_obj)
		end

	get_real_value_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : REAL is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_real (an_obj)
		end

	get_real_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : ARRAY [REAL] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_real_array (an_obj)
		end

	get_real_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : ARRAY [REAL] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_real_array (an_obj)
		end
	
	get_real_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : LINKED_LIST [REAL] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_real_list (an_obj)
		end

	get_real_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : LINKED_LIST [REAL] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_real_list (an_obj)
		end
	
	-- MT_DOUBLE --
	get_double_value_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : DOUBLE is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_double (an_obj)
		end

	get_double_value_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : DOUBLE is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_double (an_obj)
		end

	get_double_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : ARRAY [DOUBLE] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_double_array (an_obj)
		end

	get_double_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : ARRAY [DOUBLE] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_double_array (an_obj)
		end
	
	get_double_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : LINKED_LIST [DOUBLE] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_double_list (an_obj)
		end

	get_double_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : LINKED_LIST [DOUBLE] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_double_list (an_obj)
		end
	
	-- MT_CHAR --
	get_char_value_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : CHARACTER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_character (an_obj)
		end

	get_char_value_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : CHARACTER is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_character (an_obj)
		end

	-- MT_STRING --
	get_string_value_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : STRING is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_string (an_obj)
		end
	
	get_string_value_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : STRING is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			
			clear_all_properties_when_obsolete (an_obj, c)
			
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_string (an_obj)
		end
	
	get_string_array_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : ARRAY [STRING] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_string_array (an_obj)
		end
	
	get_string_array_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : ARRAY [STRING] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_string_array (an_obj)
		end
	
	get_string_list_of_object_by_name (an_obj: MT_STORABLE; attr_name: STRING) : LINKED_LIST [STRING] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_name (attr_name, an_obj)
			Result := attr.get_string_list (an_obj)
		end
	
	get_string_list_of_object_by_position (an_obj: MT_STORABLE; index: INTEGER) : LINKED_LIST [STRING] is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			attr := c.get_attribute_by_position (index, an_obj)
			Result := attr.get_string_list (an_obj)
		end
		
feature	
	set_attribute_value (an_obj: MT_STORABLE; field_index: INTEGER) is
		-- Store the value of 'field_index'-th field of 'an_obj'
		local
			a_class: MT_CLASS
		do
			a_class := mt_class_from_object (an_obj)
			a_class.init_properties (an_obj)
			a_class.attributes.item (field_index).set_value (an_obj)
		end

	set_char_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_character (an_obj)
		end
	
	set_ascii_char_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_ascii_character (an_obj)
		end
	
	set_boolean_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_boolean (an_obj)
		end
	
	set_date_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_date (an_obj)
		end
	
	set_timestamp_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_timestamp (an_obj)
		end
	
	set_time_interval_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_time_interval (an_obj)
		end
	
	set_byte_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_byte (an_obj)
		end
	
	set_short_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_short (an_obj)
		end
	
	set_byte_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_byte_array (an_obj)
		end
	
	set_byte_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_byte_list (an_obj)
		end
	
	set_byte_list_elements_by_position (an_obj: MT_STORABLE; field_index: INTEGER; 
			buffer: ARRAY [CHARACTER]; buffer_size: INTEGER; offset: INTEGER; discard_after: BOOLEAN) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_byte_list_elements (an_obj, buffer, buffer_size, offset, discard_after)
		end
	
	set_short_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_short_array (an_obj)
		end
	
	set_short_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_short_list (an_obj)
		end
	
	set_unsigned_short_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_unsigned_short (an_obj)
		end
	
	set_unsigned_short_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_unsigned_short_array (an_obj)
		end
		
	set_unsigned_short_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_unsigned_short_list (an_obj)
		end
	
	set_integer_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_integer (an_obj)
		end
	
	set_integer_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_integer_array (an_obj)
		end
		
	set_integer_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_integer_list (an_obj)
		end
	
	set_unsigned_integer_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_unsigned_integer (an_obj)
		end
	
	set_unsigned_integer_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_unsigned_integer_array (an_obj)
		end
		
	set_unsigned_integer_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_unsigned_integer_list (an_obj)
		end
	
	set_ascii_string_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_string (an_obj, Mt_asciistring)
		end
		
	set_string_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_string (an_obj, Mt_string)
		end

	set_string_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_string_array (an_obj, Mt_string_array)
		end

	set_string_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_string_list (an_obj, Mt_string_list)
		end
		
	set_ascii_string_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_string_array (an_obj, Mt_asciistring_array)
		end
	
	set_ascii_string_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_string_list (an_obj, Mt_asciistring_list)
		end
	
	set_double_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_double (an_obj)
		end
	
	set_double_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_double_array (an_obj)
		end
	
	set_double_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_double_list (an_obj)
		end
	
	set_real_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_real (an_obj)
		end
	
	set_real_array_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_real_array (an_obj)
		end
	
	set_real_list_by_position (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			c: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			c := mt_class_from_object (an_obj)
			attr := c.get_attribute_by_position (field_index, an_obj)
			attr.set_real_list (an_obj)
		end
		
feature
	remove_value_by_name (an_obj: MT_STORABLE; attr_name: STRING) is
			-- Remove a value of field named `attr_name'.
		local
			a_class: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			a_class := mt_class_from_object (an_obj)
			attr := a_class.get_attribute_by_name (attr_name, an_obj)
			attr.remove_value (an_obj)
		end

	remove_value_by_position (an_obj: MT_STORABLE; index: INTEGER) is
			-- Remove a value of field positioned at `index'.
		local
			a_class: MT_CLASS
			attr: MT_ATTRIBUTE
		do
			a_class := mt_class_from_object (an_obj)
			a_class.init_properties (an_obj)
			attr := a_class.get_attribute_by_position (index, an_obj)
			attr.remove_value (an_obj)
		end
	
feature -- Successors
	
	get_rs_successors_by_name (an_obj: MT_STORABLE; rs_name: STRING) : MT_RS_CONTAINABLE is
		local
			c: MT_CLASS
			rs: MT_RELATIONSHIP
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			rs := c.get_relationship_by_name (rs_name, an_obj)
			Result := rs.successors_of (an_obj)
		end

	get_rs_successors_by_position (an_obj: MT_STORABLE; index: INTEGER) : MT_RS_CONTAINABLE is
		local
			c: MT_CLASS
			rs: MT_RELATIONSHIP
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			rs := c.relationships.item (index)
			Result := rs.successors_of (an_obj)
		end
	
	get_rs_successor_by_name (an_obj: MT_STORABLE; rs_name: STRING) : MT_STORABLE is
		local
			c: MT_CLASS
			rs: MT_RELATIONSHIP
		do
			c := mt_class_from_object (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			rs := c.get_relationship_by_name (rs_name, an_obj)
			Result := rs.first_successor (an_obj)
		end

	get_rs_successor_by_position (an_obj: MT_STORABLE; index: INTEGER) : MT_STORABLE is
		local
			c: MT_CLASS
			rs: MT_RELATIONSHIP
		do
			c := mt_class_from_object (an_obj)
			c.init_properties (an_obj)
			clear_all_properties_when_obsolete (an_obj, c)
			rs := c.relationships.item (index)
			Result := rs.first_successor (an_obj)
		end
		
	set_single_successor (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			a_class: MT_CLASS
		do
			a_class := mt_class_from_object (an_obj)
			a_class.init_properties (an_obj)
			a_class.relationships.item (field_index).set_successors_of (an_obj)
		end

	append_successor (a_predecessor: MT_STORABLE; field_index: INTEGER; new_successor: MT_STORABLE) is
		local
			a_class: MT_CLASS
		do
			a_class := mt_class_from_object (a_predecessor)
			a_class.init_properties (a_predecessor)
			a_class.relationships.item (field_index).append_successor (a_predecessor, new_successor)
		end
	
	relationship_modified (an_obj: MT_STORABLE; field_index: INTEGER) is
		local
			a_class: MT_CLASS
		do
			a_class := mt_class_from_object (an_obj)
			a_class.init_properties (an_obj)
			a_class.relationships.item (field_index).set_successors_of (an_obj)
		end

	
feature -- Status

	set_state (a_state: INTEGER) is
			-- Set the latest state on db session controller
		do
		end

	set_current_connection is
		do
			c_set_current_connection (mt_connection)
		end
		
feature -- Transaction
	
	flush_updated_objects is
		do
			store_dirty_object_attributes
			store_dirty_object_relationships
			store_dirty_container
		end
	
	store_dirty_container is
		local
			count, total: INTEGER
			a_container: MT_CONTAINER_OBJECT
		do
			total := container_modified_set.count
			from 
				container_modified_set.start
			until 
				count = total
			loop
				if container_modified_set.item /= Void then
					count  := count + 1
					a_container ?= eif_object_table.item (container_modified_set.item)
					if a_container /= Void then
						a_container.store_updates
					end
				end
				container_modified_set.forth
			end
		end
		
	store_dirty_object_attributes is
		local
			an_oid, count, total_count: INTEGER
		do
			total_count := attr_modified_set.count
			count := 0
			from
				attr_modified_set.start
			until
				count = total_count
			loop
				an_oid := attr_modified_set.item
				if an_oid /= Void then
					store_values_of_attributes (eif_object_table.item (an_oid))
					count := count + 1
					io.new_line
					io.putint (an_oid)
				end
				attr_modified_set.forth
			end
		end
	
	store_values_of_attributes (an_object: MT_STORABLE) is
		-- Store values of all attributes
		require
			not_void: an_object /= Void
		local
			a_mt_class: MT_CLASS
			attributes: ARRAY [MT_ATTRIBUTE]
			index: INTEGER
		do
			a_mt_class := mt_schema.item (dynamic_type (an_object))
			a_mt_class.init_properties (an_object)
			attributes := a_mt_class.attributes
			from
				index := attributes.lower
			until
				index > attributes.upper
			loop
				if attributes.item (index) /= Void then
					attributes.item (index).set_value (an_object)
				end
				index := index + 1
			end
		end

	store_dirty_object_relationships is
		local
			an_oid, count, total_count: INTEGER
		do
			total_count := rl_modified_set.count
			count := 0
			from
				rl_modified_set.start
			until
				count = total_count
			loop
				an_oid := rl_modified_set.item
				if an_oid /= Void then
					store_successors_of_relationships (eif_object_table.item (an_oid))
					count := count + 1
				end
				rl_modified_set.forth
			end
		end

	store_successors_of_relationships (an_object: MT_STORABLE) is
		-- Store successors of all relationships
		require
			not_void: an_object /= Void
		local
			a_mt_class: MT_CLASS
			relationships: ARRAY [MT_RELATIONSHIP]
			i: INTEGER
		do
			a_mt_class := mt_schema.item (dynamic_type (an_object))
			a_mt_class.init_properties (an_object)
			relationships := a_mt_class.relationships
			from
				i := relationships.lower
			until
				i > relationships.upper
			loop
				if relationships.item (i) /= Void then
					relationships.item (i).set_successors_of (an_object)
				end
				i := i + 1
			end
		end

feature -- Locking

	lock_composite (an_object: MT_STORABLE; a_lock: INTEGER) is
		local
			a_class: MT_CLASS
			relationships: ARRAY [MT_RELATIONSHIP]
			co_rel: MT_COMPOSITE_RELATIONSHIP
			s_co_rel: MT_SINGLE_COMPOSITE_RELATIONSHIP
			m_co_rel: MT_MULTI_COMPOSITE_RELATIONSHIP
			i: INTEGER
			a_storable: MT_STORABLE
			linear_collection: MT_LINEAR_COLLECTION [MT_STORABLE]
			linear_rep: LINEAR [MT_STORABLE]
			rs_containable: MT_RS_CONTAINABLE
		do
			an_object.lock (a_lock)
			a_class := mt_class_from_object (an_object)
			a_class.init_properties (an_object)
			relationships := a_class.relationships
			from 
				i := relationships.lower
			until 
				i > relationships.upper
			loop
				co_rel ?= relationships.item (i)
				if co_rel /= Void then
					s_co_rel ?= co_rel
					if s_co_rel /= Void then
						a_storable ?= field (s_co_rel.eif_field_index, an_object)
						if a_storable /= Void then
							lock_composite (a_storable, a_lock)
						else
							a_storable := s_co_rel.first_successor (an_object)
							if a_storable /= Void then
								lock_composite (a_storable, a_lock)
							end
						end
					else
						m_co_rel ?= co_rel
						linear_collection ?= field (m_co_rel.eif_field_index, an_object)
						if linear_collection /= Void then
							rs_containable ?= linear_collection
							rs_containable.load_successors
							linear_rep := linear_collection.linear_representation
							from 
								linear_rep.start
							until 
								linear_rep.off
							loop
								lock_composite (linear_rep.item, a_lock)
								linear_rep.forth
							end
						end
					end
				end
				i := i + 1
			end
		end

feature -- Clone

	copy_object (object: MT_STORABLE): MT_STORABLE is
			-- Create a new transient object copying `object'
		do
			Result := deep_clone (object)
			clear_oids (Result)
		end

feature {NONE} -- Implementation

	clear_oids (object: MT_STORABLE) is
			-- Make `object' transient,
		local
			relationships: ARRAY [MT_RELATIONSHIP]
			s_rel: MT_SINGLE_RELATIONSHIP
			m_rel: MT_MULTI_RELATIONSHIP
			i: INTEGER
			its_class: MT_CLASS
			a_storable: MT_STORABLE
			linear_collection: MT_LINEAR_COLLECTION [MT_STORABLE]
			linear_rep: LINEAR [MT_STORABLE]
			rs_containable: MT_RS_CONTAINABLE
		do
			if object.oid /= 0 then
				its_class := mt_class_from_object (object)
				its_class.init_properties (object)
				relationships := its_class.relationships
				from 
					i :=  relationships.lower
				until 
					i > relationships.upper
				loop
					s_rel ?= relationships.item (i)
					m_rel ?= relationships.item (i)
					if s_rel /= Void then
						a_storable ?= field (s_rel.eif_field_index, object)
						if a_storable /= Void then
							clear_oids (a_storable)
						else
							a_storable := s_rel.first_successor (object)
							if a_storable /= Void then
								clear_oids (a_storable)
							end
						end
					elseif m_rel /= Void then
						linear_collection ?= field (m_rel.eif_field_index, object)
						if linear_collection /= Void then
							rs_containable ?= linear_collection
							rs_containable.load_successors
							linear_rep := linear_collection.linear_representation
							from 
								linear_rep.start
							until 
								linear_rep.off
							loop
								clear_oids (linear_rep.item)
								linear_rep.forth
							end
						end
					end
					i := i + 1
				end
			end
		end

	
	oids_of_all_classes: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			c_get_oids_of_classes
			!! Result.make (1, c_keys_count)
			from
				i := 1
			until
				i > Result.upper
			loop
				Result.put (c_ith_key (i), i)
				i := i + 1
			end
			c_free_keys
		end
	
	c_get_oids_of_classes is
		external
			"C"
		end
	
	clear_all_properties_when_obsolete (an_obj: MT_STORABLE; its_class: MT_CLASS) is
			-- If an_obj is obsolete, set all attributes' values to default value and
			-- wipe out all successors.
			-- Note an object retrieved from the database in a transaction will become
			-- obsolete if the object still exists in the application when a next transaction
			-- or version access starts and it has different logical time.
		do
			if an_obj.is_obsolete then
				clear_all_properties (an_obj, its_class)
				an_obj.become_up_to_date
				an_obj.relationships_unloaded
				an_obj.attributes_unloaded
			end
		end
		
	clear_all_properties (an_obj: MT_STORABLE; its_class: MT_CLASS) is
		require
			properties_initialized: its_class.properties_initialized
		local
			attributes: ARRAY [MT_ATTRIBUTE]
			relationships: ARRAY [MT_RELATIONSHIP]
			att: MT_ATTRIBUTE
			rel: MT_RELATIONSHIP
			i, upper: INTEGER
		do
			attributes := its_class.attributes
			upper := attributes.upper
			from 
				i := attributes.lower
			until
				i > upper
			loop
				att := attributes.item (i)
				if att /= Void then
					att.revert_to_unloaded (an_obj)
				end
				i := i + 1
			end
			
			relationships := its_class.relationships
			upper := relationships.upper
			from 
				i :=  relationships.lower
			until 
				i > upper
			loop
				rel := relationships.item (i)
				if rel /= Void then
					rel.revert_to_unloaded (an_obj)
				end
				i := i + 1
			end
		end

feature {MT_RS_CONTAINABLE} -- Object life cycle

	clear_all_properties_when_obsolete_wo_class (an_obj: MT_STORABLE) is
			-- Same as clear_all_properties_when_obsolete except that this
			-- does not take second argument of type MT_CLASS.
		local
			its_class: MT_CLASS
		do
			if an_obj.is_obsolete then
				its_class := mt_class_from_object (an_obj)
				its_class.init_properties (an_obj)
				clear_all_properties (an_obj, its_class)
				an_obj.become_up_to_date
			end
		end

end -- class MATISSE

