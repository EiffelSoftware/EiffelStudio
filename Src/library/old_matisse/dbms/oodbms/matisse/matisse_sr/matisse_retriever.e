class MATISSE_RETRIEVER 

inherit

	DATABASE_RETRIEVER
		export 
			{NONE} all
		redefine 
			anchor, is_valid_key
		end

	MATISSE_TABLES
		export 
			{NONE} all
		end

	MEMORY
		export 
			{NONE} all
		end

	SHARED_ODB_ACCESS
		export
			{NONE} all
		end

feature -- Retrieval

	retrieve(key:like anchor):EXT_STORABLE is
			-- Use IDF key to retrieve objects in repository
		local
			is_collecting : BOOLEAN
		do
debug("matisse-sr")
    io.put_string("RETRIEVE; key = ")
    io.put_integer(key.item)
    io.new_line
end
			is_collecting := collecting 
			collection_off

			ref_tables.clear_all
			idf_proxy_stack.wipe_out
			closures_in_progress.wipe_out

			Result ?= retrieve_closure(key)

			if is_collecting then collection_on end
		end


	retrieve_closure(key: like anchor) : EXT_STORABLE is
		-- Use key ( INTEGER ) to retrieve objects in database
		require else 
			key_positive: key /= Void and then key.item > 0
		local
			one_table : PROXY_IDF_TABLE
			i : INTEGER
			retrieved_object : ANY
			a_special : TO_SPECIAL[ANY]
		do
debug("matisse-sr")
	shifter.increase
	io.put_string(shifter.out)
    io.put_string("RETRIEVE_CLOSURE; key = ")
    io.put_integer(key.item)
    io.new_line
end
			if key.item > 0 then 
				!!one_table.make(0,key.item) 
				one_table.load
				idf_proxy_stack.extend(one_table)
				closures_in_progress.extend(idf_proxy.ith_oid(idf_proxy.flags_index - 1))

				from
					i := 0
				until
					i >= idf_proxy.flags_index
				loop
					if idf_proxy.is_ith_special(i) then
						retrieved_object ?= idf_proxy.ith_special(i)
						update_table(i,retrieved_object)
						update_references_in_special(i,retrieved_object,False)
					else
						retrieved_object ?= idf_proxy.ith_normal(i) 
						update_table(i,retrieved_object)
						update_references_in_normal(i,retrieved_object,False)
					end
					i:=i+1
				end
				Result ?= retrieved_object

-- store oid of root object in the object for later use in storing
Result.set_retrieved_id(idf_proxy.ith_oid(idf_proxy.flags_index - 1))

				idf_proxy_stack.remove
			end
debug("matisse-sr")
	shifter.decrease
end
		end

	update_table(i:INTEGER; object:ANY) is
			-- Insert object in table
		require
			Object_exists: object /= Void
		local
			reverse_refs : RETRIEVE_REF_TABLE
        	do
debug("matisse-sr")
	io.put_string(shifter.out)
    io.put_string("RETRIEVE - UPDATE_TABLE ")
    io.put_string(object.generator)
    io.new_line
end
			-- Is object referenced in table ?
			reverse_refs := ref_tables.item(idf_proxy.ith_oid(i))

			if reverse_refs = Void then 
				-- create list and put element in
				!!reverse_refs.make_target(idf_proxy.ith_oid(i),$object)
				ref_tables.add_table(reverse_refs)
debug("matisse-sr")
	io.put_string(shifter.out)
	io.put_string("CREATE table for object, oid=")
	io.put_integer(idf_proxy.ith_oid(i))
	io.new_line
end
			else
				-- need to set OID as well? - idf_proxy.ith_oid(i)
				reverse_refs.set_target_object_ptr($object)

				from
					reverse_refs.start 
				until        
					reverse_refs.off
				loop
					-- write my address into the object fields pointing to me
					change_inside_field($object, reverse_refs.item_object_ptr)
					reverse_refs.forth
				end           
			end 
		end

	update_references_in_special(i:INTEGER; object:ANY; is_exp:BOOLEAN)  is
			-- Special case
		require
			Object_exists: object /= Void
		local
			one_object : MT_OBJECT
			one_rel  : MT_RELATIONSHIP
			successors : ARRAY[MT_OBJECT]
			j : INTEGER
			reverse_refs:RETRIEVE_REF_TABLE 
			sobject:SPECIAL[ANY]
			other_oid : INTEGER
			dummy_obj : ANY
			an_attribute:MT_ATTRIBUTE
			mt_obj:MT_OBJECT
			idf_table_oid:like anchor
			class_desc:ODB_CLASS_DESCRIPTOR
		do
debug("matisse-sr")
	io.put_string(shifter.out)
    io.put_string("RETRIEVE - UPDATE_REFS IN SPECIAL%N")
end
			sobject ?= object
			!!one_object.make(idf_proxy.ith_oid(i))
			class_desc := odb_schema.class_descriptor(object)
			!!one_rel.make(class_desc.db_field_name("area"))
			successors := one_object.successors(one_rel)

			from
				j := successors.lower
			until 
				j > successors.upper
			loop
				other_oid := successors.item(j).oid

				-- if successor object oid is not known in the ref tables, then have to go and do a retrieve on it...
				if not idf_proxy.has_oid(other_oid) and then not closures_in_progress.has(other_oid) then
					!!mt_obj.make(other_oid)
					class_desc := odb_schema.class_descriptor_by_name(mt_obj.mt_generator.name)
					!!an_attribute.make(class_desc.db_field_name("stored_table_id")) 	-- to get IDF table of obj
					idf_table_oid ?= an_attribute.value(mt_obj)
					check Idf_oid_exists: idf_table_oid /= Void end
					dummy_obj := retrieve_closure(idf_table_oid)
				end

				reverse_refs := ref_tables.item(other_oid)
				if reverse_refs /= Void and then reverse_refs.is_target_retrieved then 
					change_inside_field(reverse_refs.target_object_ptr, pointer_on_special_item(j-1,$object))
				else    
					if reverse_refs /= Void then
						reverse_refs.add_reverse_ref(j,$object)
					else
						-- We want an object never seen before --> create its list
						!!reverse_refs.make_target_from_oid(other_oid)
						reverse_refs.add_reverse_ref(j,$object)
						ref_tables.add_table(reverse_refs)
					end
				end
				j:=j+1
			end
		end

	update_references_in_normal(i:INTEGER; object:ANY; is_exp:BOOLEAN)  is
			-- Normal case
		require
			Object_exists: object /= Void
		local
			nb_field,j,ftype : INTEGER
			fname:STRING
			object_field : ANY
			one_integer_value : INTEGER_REF 
			one_double_value : DOUBLE_REF 
			one_real_value : REAL_REF 
			one_char_value : CHARACTER_REF 
			one_reference_value : ANY
			one_attribute, an_attribute: MT_ATTRIBUTE
			one_object : MT_OBJECT
			reverse_refs : RETRIEVE_REF_TABLE
			fpointer : POINTER 
			successors : ARRAY[MT_OBJECT] 
			one_rel : MT_RELATIONSHIP
			other_oid : INTEGER
			dummy_obj : ANY
			mt_obj:MT_OBJECT
			idf_table_oid:like anchor
			class_desc, other_class_desc:ODB_CLASS_DESCRIPTOR
			feat_desc:ODB_FEATURE_DESCRIPTOR
			eif_fld_idx:INTEGER
			class_desc_cursor:CURSOR
		do
debug("matisse-sr")
	io.put_string(shifter.out)
    io.put_string("RETRIEVE - UPDATE_REFS IN NORMAL ")
    io.put_string(object.generator)
    io.new_line
end
			class_desc := odb_schema.class_descriptor(object)
			from 
				class_desc.features_by_field_index.start
			until
				class_desc.features_by_field_index.off
			loop
				feat_desc := class_desc.features_by_field_index.item_for_iteration
				eif_fld_idx := class_desc.features_by_field_index.key_for_iteration
				fname := field_name(eif_fld_idx, object)

				!!one_attribute.make(feat_desc.db_name)
				!!one_object.make(idf_proxy.ith_oid(i))

				ftype := field_type(eif_fld_idx ,object)
				inspect ftype
				when Reference_type then -- LIST or ARRAY [INTEGER,REAL,DOUBLE,STRING,CHARACTER]
					if one_attribute.aid /= 0 then
						one_reference_value ?= one_attribute.value(one_object)
						if one_reference_value /= Void then set_reference_field(eif_fld_idx ,object ,one_reference_value) end

					else -- REFERENCE 
						!!one_rel.make(feat_desc.db_name)
						successors := one_object.successors(one_rel)

if not successors.empty then	-- no successors on db (i.e. a Void)

						other_oid := successors.item(successors.lower).oid

						-- successor object oid is not in the current closure, do a retrieve on it; this
						-- will add its entries to the ref_tables. Don't retrieve:
						-- 		- objects already retrieved
						--		- objects partially retrieved (on the stack)
						--		- objects which are successors of "agg_parent" relationship, due to that relationship
						if not idf_proxy.has_oid(other_oid) and then not closures_in_progress.has(other_oid) and then not fname.is_equal("agg_parent")then
							!!mt_obj.make(other_oid)
							other_class_desc := odb_schema.class_descriptor_by_name(mt_obj.mt_generator.name)
							!!an_attribute.make(other_class_desc.db_field_name("stored_table_id")) 	-- to get IDF table of obj
							idf_table_oid ?= an_attribute.value(mt_obj)
							check Idf_oid_exists: idf_table_oid /= Void end
							class_desc_cursor := class_desc.features_by_field_index.cursor		-- save current firld iteration position
							dummy_obj := retrieve_closure(idf_table_oid)
							class_desc.features_by_field_index.go_to(class_desc_cursor)		-- return to field iteration position
						end

						reverse_refs := ref_tables.item(other_oid) -- have to look again, since table might now exist
						if reverse_refs /= Void and then reverse_refs.is_target_retrieved then 
							change_inside_field(reverse_refs.target_object_ptr, pointer_on_field(eif_fld_idx-1,$object))
						else 
							if reverse_refs /= Void then
								reverse_refs.add_reverse_ref(eif_fld_idx, $object)
							else
								-- We want an object never seen before --> create its list
								!!reverse_refs.make_target_from_oid(other_oid)
								reverse_refs.add_reverse_ref(eif_fld_idx, $object)
								ref_tables.add_table(reverse_refs)
							end
						end
end
					end  
				when Integer_type then -- INTEGER
					one_integer_value ?= one_attribute.value(one_object)
					if one_integer_value /= Void then set_integer_field (eif_fld_idx,object,one_integer_value.item) end

				when Real_type then -- REAL
					one_real_value ?= one_attribute.value(one_object)
					if one_real_value /= Void then set_real_field (eif_fld_idx,object,one_real_value.item) end

				when Double_type then -- DOUBLE
					one_double_value ?= one_attribute.value(one_object)
					if one_double_value /= Void then set_double_field (eif_fld_idx,object,one_double_value.item) end

				when Character_type then -- CHARACTER
					one_char_value ?= one_attribute.value(one_object)
					if one_char_value /= Void then set_character_field (eif_fld_idx,object,one_char_value.item) end

				when Boolean_type then -- BOOLEAN
					one_integer_value ?= one_attribute.value(one_object)
					if one_integer_value /= Void and one_integer_value.item = 1 then set_boolean_field (eif_fld_idx,object,True) end

				else
					-- Do not know how to store this type  (POINTER, BIT N) 
				end

				class_desc.features_by_field_index.forth
			end
		end

feature -- Status
	is_valid_key(key: like anchor):BOOLEAN is
		do
			Result := key /= Void and then key.item > 0
		end

feature {NONE} -- Implementation

	idf_proxy:PROXY_IDF_TABLE is
			-- IDF_PROXY of closure currently being processed
		do
			Result := idf_proxy_stack.item
		end

	idf_proxy_stack:LINKED_STACK [PROXY_IDF_TABLE] is
			-- stack corresponding to recursion of store traversals so far
		once
			!!Result.make
		end

	closures_in_progress:LINKED_STACK [INTEGER] is
			-- stack of closures represented by root object OID
		once
			!!Result.make
		end

	ref_tables:RETRIEVE_REF_TABLES is
		once
			!!Result.make(0)
		end

	anchor : INTEGER_REF

	shifter : SHIFTER is
			-- a string displayed before each field information. Contains only tab chars
		once
			!!Result.make
		end

end
