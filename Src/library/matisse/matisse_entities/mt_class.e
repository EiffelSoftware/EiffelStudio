indexing
	description: "MATISSE-Eiffel Binding: This class represents a meta-class Mt Class in the database schema.";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_CLASS

inherit
	MT_METASCHEMA
		rename
			is_ok as check_instance
		redefine
			predefined_eif_field
		select 
			is_equal
		end

	MT_CLASS_EXTERNAL
		rename 
			is_equal as general_is_equal
		end

	MT_RELATIONSHIP_EXTERNAL
		rename 
			is_equal as general_is_equal
		end

	MT_ATTRIBUTE_EXTERNAL
		rename 
			is_equal as general_is_equal
		end

	OPERATING_ENVIRONMENT
		rename 
			is_equal as general_is_equal
		export 
			{NONE} all
		end

	MT_EXCEPTIONS
		rename
			is_equal as general_is_equal
		export 
			{NONE} all
		end
		
creation 
	make_from_object, make_from_name, make_from_oid

feature {NONE} -- Initialization

	make_from_name (a_class_name: STRING) is 
			-- Get class id from database and fills its name.
		require
			string_not_void: a_class_name /= Void
			string_not_empty: not a_class_name.is_empty
		local
			class_name_to_c: ANY
		do
			class_name_to_c := a_class_name.to_c
			oid := c_get_class_from_name ($class_name_to_c)
		end

	make_from_object (one_object: MT_OBJECT) is
			-- Get class from object id
		do
			oid := c_get_object_class (one_object.oid)
		end

feature  -- Access

	instances_count: INTEGER is
			-- Count instances of current class in database
		do
			Result := c_get_instances_number (oid)
		end

	eiffel_type_id: INTEGER is
			-- Return dynamic type id of Eiffel class corresponding to Current
		local
			c_class_name: ANY
		do
			c_class_name := name.to_c
			Result := c_get_eiffel_type_id_from_name ($c_class_name)
		end
		
	attributes: ARRAY [MT_ATTRIBUTE] is
			-- Before call this function, call init_properties to
			-- initialize attributes and relationships
		require
			properties_initialized: properties_initialized
		do
			Result := saved_attributes
		end
		
	
	get_attributes: ARRAY [MT_ATTRIBUTE] is
			-- Attributes of current class according to database schema
		local
			keys_count, i: INTEGER
			one_attribute: MT_ATTRIBUTE
		do
			c_get_all_attributes (oid)
			keys_count := c_keys_count
			!! Result.make (1, keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!! one_attribute.make_from_id (c_ith_key (i))
				Result.force (one_attribute, i)
				i := i + 1
			end -- loop
			c_free_keys
		end -- attributes

	get_attribute_by_position (index: INTEGER; an_obj: MT_STORABLE): MT_ATTRIBUTE is
		do
			init_properties (an_obj)
			Result := attributes.item (index)
			if Result = Void then
				trigger_dev_exception (100004, "Invalid attribute position")
			end
		end
	
	get_attribute_by_name (attr_name: STRING; an_obj: MT_STORABLE): MT_ATTRIBUTE is
			-- Find an attribute using name. Name follows either Eiffel field name ("name")
			-- or MATISSE name ("PERSON::name", or "name"). Name mangling does not matter.
			-- Eiffel field name is recommended.
			-- (If nothing is found, Void is returned).
		local
			i, att_oid: INTEGER
			attr: MT_ATTRIBUTE
			name_to_c: ANY
		do
			init_properties (an_obj)
			from
				i := attributes.lower
			until
				i > attributes.upper or Result /= Void
			loop
				attr := attributes.item (i)
				if attr /= Void then
					if attr.eiffel_name.is_equal (attr_name) then
						Result := attr
					end
				end
				i := i + 1
			end
			
			if Result = Void then
				-- 'attr_name' may be the form of "CLASS__attribute"
				name_to_c := attr_name.to_c
				att_oid := c_get_attribute ($name_to_c)
				from
					i := attributes.lower
				until
					i > attributes.upper or Result /= Void
				loop
					attr := attributes.item (i)
					if attr /= Void then
						if attr.oid = att_oid then
							Result := attr
						end
					end
					i := i + 1
				end
			end
			if Result = Void then
				trigger_dev_exception (100003, "Invalid attribute name")
			end
		end

	relationships: ARRAY [MT_RELATIONSHIP] is
			-- Before call this function, call init_properties to
			-- initialize attributes and relationships
		require
			properties_initialized: properties_initialized
		do
			Result := saved_relationships
		end

	get_relationships : ARRAY [MT_RELATIONSHIP] is
			-- Relationships of current class according to database schema
		local
			keys_count, i: INTEGER
			one_relationship: MT_RELATIONSHIP
		do
			c_get_all_relationships (oid)
			keys_count := c_keys_count
			!! Result.make (1, keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!! one_relationship.make_from_id (c_ith_key (i))
				Result.force (one_relationship, i)
				i := i + 1
			 end -- loop
			c_free_keys	
		end

	get_relationship_by_position (index: INTEGER; an_obj: MT_STORABLE): MT_RELATIONSHIP is
		do
			init_properties (an_obj)
			Result := relationships.item (index)
			if Result = Void then
				trigger_dev_exception (100004, "Invalid relationship position")
			end
		end

	get_relationship_by_name (rs_name: STRING; an_obj: MT_STORABLE): MT_RELATIONSHIP is
			-- Find an relationship using name. Name follows
			-- MATISSE convention. 
			-- (If nothing is found, Void is returned).
		local
			i, rs_oid: INTEGER
			rs: MT_RELATIONSHIP
			name_to_c: ANY
		do
			init_properties (an_obj)
			from
				i := relationships.lower
			until
				i > relationships.upper or Result /= void
			loop
				rs := relationships.item (i)
				if rs /= void then
					if rs.eiffel_name.is_equal (rs_name) then
						Result := rs
					end
				end
				i := i + 1
			end
			if Result = Void then
				name_to_c := rs_name.to_c
				rs_oid := c_get_relationship_from_name ($name_to_c)
				from
					i := relationships.lower
				until
					i > relationships.upper or Result /= Void
				loop
					rs := relationships.item (i)
					if rs /= Void then
						if rs.oid = rs_oid then
							Result := rs
						end
					end
					i := i + 1
				end
			end
			if Result = Void then
				trigger_dev_exception (100005, "Invalid relationship name")
			end
		end

	inverse_relationships: ARRAY [MT_RELATIONSHIP] is
			-- Inverse relationships of current class according to database schema.
		local
			keys_count, i: INTEGER
			one_object: MT_RELATIONSHIP
		do
			c_get_all_inverse_relationships (oid)
			keys_count := c_keys_count
			!! Result.make (1, keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!! one_object.make_from_id (c_ith_key (i))
				Result.force (one_object, i)
				i := i + 1
			end
			c_free_keys    
		end

	subclasses: ARRAY [MT_CLASS] is
			-- Subclasses of current class
		local
			keys_count, i: INTEGER
			one_object: MT_CLASS
		do
			c_get_all_subclasses (oid)
			keys_count := c_keys_count
			!! Result.make (1, keys_count)
			from
				i := 1
			until 
 				i = keys_count + 1
			loop
				!! one_object.make_from_oid (c_ith_key (i))
 				Result.force (one_object, i)
				i := i + 1
			end
			c_free_keys    
		end

	superclasses: ARRAY [MT_CLASS] is
			-- Superclasses of current class
		local
			keys_count, i: INTEGER
			one_object: MT_CLASS
		do
			c_get_all_superclasses (oid)
			keys_count := c_keys_count
			!! Result.make (1, keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!! one_object.make_from_oid (c_ith_key (i))
				Result.force (one_object, i)
				i := i + 1
			end
			c_free_keys
		end

	parents: ARRAY [MT_CLASS] is
		-- Direct parents
		local
			a_stream: MT_RELATIONSHIP_STREAM
			a_class: MT_CLASS
			i: INTEGER
		do
			!! a_stream.make_from_name (Current, "Mt Superclasses")
			!! Result.make (0, 1)
			from
				a_stream.start
				i := 0
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

	all_instances: ARRAY [MT_STORABLE] is
		local
			a_stream: MT_CLASS_STREAM
			i: INTEGER
		do
			!! Result.make (0, instances_count - 1)
			!! a_stream.make (oid)
			from
				a_stream.start
				i := 0
			until
				a_stream.exhausted
			loop
				Result.put (a_stream.item, i)
				a_stream.forth
				i := i + 1
			end
			a_stream.close
		end

	n_first_instances (n: INTEGER): ARRAY [MT_STORABLE] is
			-- array of `n' first instances of Current class
			-- or all if `n' > `instance_count'
		local
			a_stream: MT_CLASS_STREAM
			i: INTEGER
			number: INTEGER
		do
			if n >= instances_count then
				Result := all_instances
			else
				!! Result.make (0, n - 1)
				!! a_stream.make (oid)
				from
					a_stream.start
					i := 0
				until
					a_stream.exhausted or i > n - 1
				loop
					Result.put (a_stream.item, i)
					a_stream.forth
					i := i + 1
				end
				a_stream.close
			end
		end


	all_index_names: ARRAYED_LIST [STRING] is
			-- List of all index names for this class and its all ancesters.
		local
			classes: ARRAY [MT_CLASS]
			i, j: INTEGER
			rel: MT_RELATIONSHIP
			an_obj: MT_OBJECT
			an_att: MT_ATTRIBUTE
			objs: ARRAY [MT_OBJECT]
			str: STRING
			supers: ARRAY [MT_CLASS]
		do
			!! Result.make (0)
			!! rel.make ("Mt Indexes")
			!! an_att.make ("Mt Name")
			
			supers := superclasses
			supers.force (Current, supers.upper + 1)
			from 
				i := supers.lower 
			until 
				i > supers.upper 
			loop
				!! an_obj.make (supers.item (i).oid)
				objs := an_obj.successors (rel)
				from 
					j := objs.lower 
				until 
					j > objs.upper 
				loop
					str := an_att.get_string (objs.item (j))
					if str /= Void then
						Result.extend (str)
					end
					j := j + 1
				end
				i := i + 1
			end
		end

feature -- Action

	remove_all_instances is
			-- Remove all instances of current class in database
		local
			ai: ARRAY [MT_STORABLE]
			i: INTEGER
		do
			ai := all_instances
			if ai /= Void then
				from
					i := ai.lower
				until
					i > ai.upper
				loop
					ai.item (i).mt_remove
					i := i + 1
				end
			end
		end


feature -- Attribute values loading and setting
	
	load_attr_values_of_object (an_object: MT_STORABLE) is
		local
			i: INTEGER
			value: ANY
			each_attr: MT_ATTRIBUTE
			a_char: CHARACTER
			a_bool: BOOLEAN
			an_integer: INTEGER
			a_real: REAL
			a_double: DOUBLE
		do
			init_properties (an_object)
			
			from 
				i := 1
			until 
				i > attributes.count
			loop
				each_attr := attributes.item (i)
				if  each_attr /= Void then
					inspect each_attr.eif_field_type
					when Reference_type then
						value := each_attr.get_value (an_object)
						set_reference_field (each_attr.eif_field_index, an_object, value)
					when Character_type then
						a_char := each_attr.get_character (an_object)
						set_character_field (each_attr.eif_field_index, an_object, a_char)
					when Boolean_type then
						a_bool := each_attr.get_boolean (an_object)
						set_boolean_field (each_attr.eif_field_index, an_object, a_bool)
					when Integer_type then
						an_integer := each_attr.get_integer_type_value (an_object)
						set_integer_field (each_attr.eif_field_index, an_object, an_integer)
					when Real_type then
						a_real := each_attr.get_real (an_object)
						set_real_field (each_attr.eif_field_index, an_object, a_real)
					when Double_type then
						a_double := each_attr.get_double (an_object)
						set_double_field (each_attr.eif_field_index, an_object, a_double)
					else
					end
				end
				i := i + 1
			end
		end

	set_all_attribute_values (an_object: MT_STORABLE) is
		local
			each_attr: MT_ATTRIBUTE
			i: INTEGER
		do
			init_properties (an_object)
			from
				i := 1
			until 
				i > attributes.count
			loop
				each_attr := attributes.item (i)
				if  each_attr /= Void then
					each_attr.set_value (an_object)
				end
				i := i + 1
			end
		end

feature -- Relationship successors loading

	load_rs_successors_of_object (an_object: MT_STORABLE) is
		local
			i: INTEGER
			each_rel: MT_RELATIONSHIP
			a_container: MT_RS_CONTAINABLE
		do
			init_properties (an_object)

			from 
				i := 1
			until 
				i > relationships.count
			loop
				each_rel := relationships.item (i)
				if  each_rel /= Void then
					if each_rel.is_single then
						set_reference_field (each_rel.eif_field_index, 
										an_object,
										each_rel.first_successor (an_object))
					else
						a_container := each_rel.successors_of (an_object)
						a_container.load_successors
						set_reference_field (each_rel.eif_field_index, an_object, a_container)
					end
				end
				i := i + 1
			end
		end

feature {MATISSE} -- Meta-schema

	init_properties (sample_obj: MT_STORABLE) is
			-- Set up each field of `sample_obj' if not already done.
		local
			attribute_table: HASH_TABLE [MT_ATTRIBUTE, STRING]
			i, keys_count, an_oid: INTEGER
			an_attribute: MT_ATTRIBUTE
			a_name : STRING
			rel_table: HASH_TABLE [MT_RELATIONSHIP, STRING]
			s_relationship: MT_SINGLE_RELATIONSHIP
			m_relationship: MT_MULTI_RELATIONSHIP
			ht_relationship: MT_HASH_TABLE_RELATIONSHIP
			a_relationship: MT_RELATIONSHIP
			a_count: INTEGER
			rs_class_name: STRING 
				-- Relationship class name
		do
			if not properties_initialized then
				c_get_all_attributes (oid)
				keys_count := c_keys_count
				!! attribute_table.make (keys_count)
				from
					i := 1
				until 
					i = keys_count + 1
				loop
					!! an_attribute.make_from_id (c_ith_key (i))
					attribute_table.put (an_attribute, an_attribute.eiffel_name)
					i := i + 1
				end 
				c_free_keys

				c_get_all_relationships (oid)
				keys_count := c_keys_count
				!! rel_table.make (keys_count)
				from
					i := 1
				until 
					i = keys_count + 1
				loop
					an_oid := c_ith_key (i)
					a_relationship := make_relationship (an_oid)
					rel_table.put (a_relationship, a_relationship.eiffel_name)
					i := i + 1
				end
				c_free_keys

				a_count := field_count (sample_obj)
				!! saved_attributes.make (1, a_count)
				!! saved_relationships.make (1, a_count)
				from 
					i := 1
				until 
					i > a_count
				loop
					a_name := field_name (i, sample_obj)
					a_name.to_lower
					attribute_table.search (a_name)
					if attribute_table.found then
						an_attribute := attribute_table.found_item
						an_attribute.setup_field (i, sample_obj, database)
						saved_attributes.put (an_attribute, i)
					else 
						rel_table.search (a_name)
						if rel_table.found then
							a_relationship := rel_table.found_item
							a_relationship.setup_field (i, sample_obj, database)
							saved_relationships.put (a_relationship, i)
						else
							if not sample_obj.predefined_eif_field (a_name) then
								sample_obj.property_undefined (i, a_name)
							end
						end
					end
					i := i + 1
				end
				properties_initialized := True
			end
		end

feature {NONE} -- Meta-schema

	predefined_eif_field (a_field_name: STRING): BOOLEAN is
			-- Is `a_field_name' an attribute defined in classes MT_STORABLE,
			-- MT_OBJECT, or their ancestors?
		do
			Result := a_field_name.is_equal ("oid") or
					a_field_name.is_equal ("db") or
					a_field_name.is_equal ("attributes_loaded") or
					a_field_name.is_equal ("relationships_loaded") or
					a_field_name.is_equal ("properites_initialized") or
					a_field_name.is_equal ("saved_attributes") or
					a_field_name.is_equal ("saved_relationships") or
					a_field_name.is_equal ("stream") 
		end

	setup_attribute (an_attr: MT_ATTRIBUTE; field_index: INTEGER; sample_obj: ANY) is
		do
			an_attr.set_field_index (field_index)
			an_attr.set_field_type (field_type(field_index, sample_obj))
			an_attr.set_mt_type (an_attr.type)
				-- This should be changed so that it consider Eiffel class field type
		end

	make_relationship (rid: INTEGER): MT_RELATIONSHIP is
			-- rid: oid of relationship object
		local
			single_rs: MT_SINGLE_RELATIONSHIP
			multi_rs: MT_MULTI_RELATIONSHIP
			ht_rs: MT_HASH_TABLE_RELATIONSHIP
			m_co_rs: MT_MULTI_COMPOSITE_RELATIONSHIP
			s_co_rs: MT_SINGLE_COMPOSITE_RELATIONSHIP
			rs_class_name: STRING
		do
			if c_get_object_class (rid) = Mt_Relationship_oid then
				if c_get_max_cardinality (rid) = 1 then
					!! single_rs.make_from_id (rid)
					Result := single_rs
				else
					!! multi_rs.make_from_id (rid)
					Result := multi_rs
				end
			else
				!! rs_class_name.make (0)
				rs_class_name.from_c (c_get_relationship_class_name (rid))
				if rs_class_name.is_equal (HashTableRelationship) then
					!! ht_rs.make_from_id (rid)
					Result := ht_rs
				elseif rs_class_name.is_equal (CompositeRelationship) then
					if c_get_max_cardinality (rid) = 1 then
						!! s_co_rs.make_from_oid (rid)
						Result := s_co_rs
					else
						!! m_co_rs.make_from_oid (rid)
						Result := m_co_rs
					end
				end
			end
		end
		
feature -- Attributes
	
	properties_initialized: BOOLEAN
		-- Attributes and relationships are initialized?

feature -- Streaming

	open_stream: MT_CLASS_STREAM is
		do
			!! Result.make (oid)
		end
		
feature {NONE} -- Implementation

	saved_attributes: ARRAY [MT_ATTRIBUTE] 

	saved_relationships: ARRAY [MT_RELATIONSHIP] 

	Mt_Relationship_oid: INTEGER is
		local
			to_c: ANY
			a_class_name: STRING
		once
			a_class_name := "Mt Relationship"
			to_c := a_class_name.to_c
			Result := c_get_class_from_name ($to_c)
		end
	
	HashTableRelationship: STRING is "HashTableRelationship"
	
	CompositeRelationship: STRING is "CompositeRelationship"
		
end -- class MT_CLASS
