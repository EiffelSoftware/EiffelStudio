class MATISSE_STORER 

inherit
	DATABASE_STORER

	MATISSE_CONST
		export 
			{NONE} all
		end

	MATISSE_TABLES
		export
			{NONE} all
		end

	TYPES
		export 
			{NONE} all
		end 

feature {TRAVERSAL_ACTION} -- Element change

	putobject,put_object(object:ANY) is
		do
debug("matisse-sr")
	shifter.increase
    io.put_string(shifter.out)
    io.put_string("MATISSE_STORER.put_object ")
    io.put_string(object.generator)
    io.new_line
end
			update_table(object)
			if is_special(object) then
				put_special_object(object)
			else
				put_normal_object(object)
			end
debug("matisse-sr")
	shifter.decrease
end
    	end

	delete_sub_closure(es:EXT_STORABLE) is
			do
debug("matisse-sr")
    io.put_string(shifter.out)
    io.put_string("MATISSE_STORER.delete_sub_closure ")
    io.put_string(es.generator)
    io.new_line
end
				if is_special(es) then
					delete_special_object(es)
				else
					delete_normal_object(es)
				end
    		end

feature {NONE} -- Implementation
	delete_closure_orphans(es:EXT_STORABLE) is
			-- iterate through old idf_table oids, deleting all objects
			-- except the last one, which is an EXT_STORABLE, and was
			-- just rewritten.
		local
			oid,i:INTEGER
			one_object:MT_OBJECT
			an_idf_proxy:PROXY_IDF_TABLE
		do
			oid := es.stored_table_id

			if oid /= 0 then
				!!an_idf_proxy.make(0, oid) 
				an_idf_proxy.load

debug("matisse-idf")
	io.put_string("MATISSE_STORER.delete_closure_orphans:%N")
end
				from i := 0 until i >= an_idf_proxy.oids_index - 1 loop
debug("matisse-idf")
	io.put_string("    oid = ")
	io.put_integer(an_idf_proxy.ith_oid(i))
	io.new_line
end
					!!one_object.make(an_idf_proxy.ith_oid(i))
					one_object.remove
					i := i + 1
				end

debug("matisse-idf")
	io.put_string("    deleting old IDF table, oid = ")
	io.put_integer(oid)
	io.new_line
end
				-- now delete the old IDF table
				!!one_object.make(oid)
				one_object.remove
			end
		end

	update_table(object:ANY) is
			-- Create or update object in database
		local 
			reverse_refs : STORE_REF_TABLE
			field_to_update : STRING
			one_class : MT_CLASS
			one_object,other_object : MT_OBJECT
			one_rel : MT_RELATIONSHIP
			one_attribute : MT_ATTRIBUTE
			other_oid, one_integer : INTEGER
			special_object : SPECIAL[ANY]
			es:EXT_STORABLE
			class_desc:ODB_CLASS_DESCRIPTOR
		do
debug("matisse-feat")
    io.put_string(shifter.out)
    io.put_string("MATISSE_STORER.update_table ")
    io.put_string(class_name(object))
    io.new_line
end
			es ?= object
			if es /= Void then
				if es.retrieved_id /= 0 then
					-- use existing object in database
					!!one_object.make(es.retrieved_id)
					delete_closure_orphans(es)
				else
					-- Create object new in database
					!!one_class.make(class_name(object)) 
					one_object := one_class.new_instance
					es.set_retrieved_id(one_object.oid)
				end

				-- now overwrite the IDF_TABLE id with the new one
				es.set_stored_table_id(idf_proxy.oid)
			else
				-- Create object new in database
				!!one_class.make(class_name(object)) 
				one_object := one_class.new_instance
			end

			-- record it in the current IDF_TABLE
			idf_proxy.put_flag(object)
			idf_proxy.put_oid(one_object.oid)

			-- if it's a special, create its attributes
			if c_is_special_object($object) then
				class_desc := odb_schema.class_descriptor(object)
				special_object ?= object check special_object /= Void end
				!!one_attribute.make(class_desc.db_field_name("eif_size"))
 				one_attribute.set_value(one_object,Mts32,c_size_of_special($object))
				!!one_attribute.make(class_desc.db_field_name("eif_count"))
				one_attribute.set_value(one_object,Mts32,special_object.count)
			end

			-- Is object referenced in reverse reference table yet?
			reverse_refs := ref_tables.item($object)
			if reverse_refs = Void then 
				-- create reverse reference table for object
				!!reverse_refs.make_target(one_object.oid, $object)
				ref_tables.add_table(reverse_refs)
			else
				-- retrieve table for this oid and iterate through it, stitching up reverse refs
				reverse_refs.set_target_oid(one_object.oid)

				from
					reverse_refs.start
				until        
					reverse_refs.off
				loop
 					-- Change field in database
					other_oid := ref_tables.oid(reverse_refs.item_object_ptr)
					!!other_object.make(other_oid) 
					class_desc := odb_schema.class_descriptor_by_name(other_object.name)
					if reverse_refs.is_item_object_special then	-- Element of special area
						!!one_rel.make(class_desc.db_field_name("area"))
					else	
						!!one_rel.make(class_desc.db_field_name(reverse_refs.item_field_name))
						other_object.remove_all_successors(one_rel)
					end
					other_object.append_successor(one_rel,one_object)
 					reverse_refs.forth
				end            
			end 
		end

	put_normal_object(object:ANY) is
		local
			q, ftype, other_oid, one_oid, a_boolean, k, eif_fld_idx, z:INTEGER 
			one_integer : INTEGER_REF
			object_field : ANY
			reverse_refs : STORE_REF_TABLE
			one_object, other_object : MT_OBJECT
			one_rel : MT_RELATIONSHIP 
			one_attribute : MT_ATTRIBUTE
			one_boolean : BOOLEAN_REF 
			one_area : SPECIAL[ANY] 
			one_item : ANY 
			one_array : ARRAY[ANY]
			a_boolean_array:ARRAY[BOOLEAN]
			a_boolean_char_array:ARRAY[CHARACTER]
			class_desc:ODB_CLASS_DESCRIPTOR
			feat_desc:ODB_FEATURE_DESCRIPTOR
			mt_type_code:INTEGER
		do
			debug("matisse-feat")
				io.put_string(shifter.out)
				io.put_string("put_normal_object ")
				io.put_string(class_name(object))
				io.new_line
			end

			class_desc := odb_schema.class_descriptor(object)
			!!one_object.make(ref_tables.oid($object))

			from 
				class_desc.features_by_field_index.start
			until
				class_desc.features_by_field_index.off
			loop
				feat_desc := class_desc.features_by_field_index.item_for_iteration
				eif_fld_idx := class_desc.features_by_field_index.key_for_iteration

				mt_type_code := feat_desc.db_type
				object_field := field(eif_fld_idx, object)
				!!one_attribute.make(feat_desc.db_name)

				debug("matisse-feat")
					io.put_string(shifter.out) io.put_string(field_name(eif_fld_idx, object)) io.put_string("--") 
					io.put_string(class_desc.db_field_name(field_name(eif_fld_idx, object))) 
					io.put_string(" (") io.put_integer(eif_fld_idx) io.put_string(")")
				end

				if object_field /= Void then
					ftype := field_type(eif_fld_idx, object)

					inspect ftype
 					when Reference_type then -- Eiffel REFERENCE

						if mt_type_code /= Mtrelationship_type then
							if mt_type_code = Mtu8_array then
								a_boolean_array ?= object_field check a_boolean_array /= Void end
								!!a_boolean_char_array.make(a_boolean_array.lower, a_boolean_array.upper)
								from z := a_boolean_array.lower until z > a_boolean_array.upper loop
									if a_boolean_array.item(z) then a_boolean_char_array.put('t',z) else a_boolean_char_array.put('f',z) end
									z := z + 1
								end
								one_attribute.set_value(one_object,Mtu8_array,a_boolean_char_array)
								debug("matisse-feat") io.put_string("	----> Mtu8_array%N") end

							else -- mt_type_code = Mtdouble_list, Mtfloat_list, Mts32_list, Mtstring_list, Mtstring, Mts32_array, Mtstring_array, Mtdouble_array, Mtfloat_array
								one_attribute.set_value(one_object, mt_type_code ,object_field)
								debug("matisse-feat") io.put_string("	----> mt_type:") io.put_integer(mt_type_code) io.new_line end
							end

						else -- mapped to a Matisse Relationship
							one_array ?= object_field  
							if one_array /= Void then one_area ?= one_array.area end

							-- only bother with non-ARRAYs or ARRAY[reference type]
							if one_array = Void or else not(is_special_simple($one_area)) then
								debug("matisse-feat") io.put_string("	----> REFERENCE") end
								-- Is tc list of pointer inside field empty ?
								reverse_refs := ref_tables.item_i_th_field(eif_fld_idx ,$object)
								if reverse_refs /= Void then -- REFERENCE or ARRAY[REFERENCE]
									-- Has object in field already been stored ? 
									if reverse_refs.is_target_stored then
										-- Object in field is already in database -> update database for object's field
										debug("matisse-feat") io.put_string("	----> REL (target already stored)") end
										one_oid := ref_tables.oid($object)
										other_oid := reverse_refs.target_oid
										!!one_rel.make(class_desc.db_field_name(field_name(eif_fld_idx ,object)))
										!!one_object.make(one_oid) 
										!!other_object.make(other_oid) 
										one_object.remove_all_successors(one_rel)
										one_object.append_successor(one_rel,other_object)
									else    
										debug("matisse-feat") io.put_string("	----> add REL ref (target not yet stored)") end
										reverse_refs.add_reverse_ref(eif_fld_idx ,$object)
									end
								else
									debug("matisse-feat") io.put_string("	----> add ref table; add REL ref") end
									-- We want an object never seen before --> create its list
									!!reverse_refs.make_target_from_i_th_field(eif_fld_idx ,$object)
									reverse_refs.add_reverse_ref(eif_fld_idx ,$object)
									ref_tables.add_table(reverse_refs)
								end
								debug("matisse-feat") io.new_line end
							end
						end

					when Integer_type then
						one_attribute.set_value(one_object,Mts32,object_field)
						debug("matisse-feat") io.put_string("	----> Mts32%N") end

					when Real_type then
						one_attribute.set_value(one_object,Mtfloat,object_field)
						debug("matisse-feat") io.put_string("	----> Mtfloat%N") end

					when Double_type then
						one_attribute.set_value(one_object,Mtdouble,object_field)
						debug("matisse-feat") io.put_string("	----> Mtdouble%N") end

					when Character_type then
						one_attribute.set_value(one_object,Mtchar,object_field)
						debug("matisse-feat") io.put_string("	----> Mtchar%N") end

					when Boolean_type then
						one_boolean ?= field(eif_fld_idx,object) check one_boolean/= Void end
						if one_boolean.item then a_boolean := 1 else a_boolean := 0 end
						one_attribute.set_value(one_object,Mts32,a_boolean)
						debug("matisse-feat") io.put_string("	----> Mts32%N") end

					else
						-- Do not know how to store this type  (POINTER, BIT N) 
					end -- inspect

					debug("matisse-feat")
						if not is_ok then
							io.put_string("	### last op Error ### ")
							io.put_string(error_message)
							io.new_line
							end
					end

				else -- Void field
					debug("matisse-feat")
						io.put_string("	----> No Operation (field is Void)%N")
					end
				end

				class_desc.features_by_field_index.forth
			end -- loop
		end

	put_special_object(object:ANY) is
		local
			a_special : SPECIAL[ANY]
			nb_field,j,ftype, other_oid, one_oid : INTEGER
			object_field : ANY
			reverse_refs : STORE_REF_TABLE
			one_object, other_object, one_void_object : MT_OBJECT
			one_rel : MT_RELATIONSHIP 
			one_attribute : MT_ATTRIBUTE
			one_class : MT_CLASS
			class_desc:ODB_CLASS_DESCRIPTOR
		do
debug("matisse-feat")
    io.put_string(shifter.out)
    io.put_string("PUT_SPECIAL_OBJECT%N")
end
			class_desc := odb_schema.class_descriptor(object)

			a_special ?= object
			check a_special /= Void end

			one_oid := ref_tables.oid($object)
			!!one_object.make(one_oid) 

			from
				nb_field := a_special.count
				j := 0
			until
				j >= nb_field
			loop
				-- Is there anything to store ?
				object_field := a_special.item(j)
				if object_field /= Void then
					-- Is ct list of pointer inside field empty ?
					reverse_refs := ref_tables.item_i_th_field(j+1,$a_special)
					if reverse_refs /= Void then
						-- Has object in field already been stored ? 
						if reverse_refs.is_target_stored then
							-- Object in field is already in database -> update database for object's field
							other_oid := reverse_refs.target_oid
							!!one_rel.make(class_desc.db_field_name("area"))
							!!other_object.make(other_oid) 
							one_object.append_successor(one_rel,other_object)
						else    
							reverse_refs.add_reverse_ref(j+1, $object)
						end
					else
						-- We want an object never seen before --> create its list
						!!reverse_refs.make_target_from_i_th_field(j+1,$object)
						reverse_refs.add_reverse_ref(j+1,$object)
						ref_tables.add_table(reverse_refs)
					end
				else -- store a VOID_OBJECT to simulate Void member
					-- Create object in database
					!!one_class.make("VOID_OBJECT") 
					one_void_object := one_class.new_instance

					-- add it to the successors
					!!one_rel.make("area")  
					one_object.append_successor(one_rel, one_void_object)
				end  
				j :=j + 1
			end
		end

	delete_normal_object(es:EXT_STORABLE) is
			-- iterate through old idf_table oids, deleting all objects
		do
debug("matisse-sr")
    io.put_string(shifter.out)
    io.put_string("delete_normal_object%N")
end
			delete_any_object(es)
		end

	delete_special_object(es:EXT_STORABLE) is
		do
			delete_any_object(es)
debug("matisse-sr")
    io.put_string(shifter.out)
    io.put_string("delete_special_object%N")
end
		end

	delete_any_object(es:EXT_STORABLE) is
			-- iterate through old idf_table oids, deleting all objects
		local
			oid,i:INTEGER
			one_object:MT_OBJECT
			an_idf_proxy:PROXY_IDF_TABLE
		do
			oid := es.stored_table_id

			if oid /= 0 then
				!!an_idf_proxy.make(0, oid) 
				an_idf_proxy.load

				from i := 0 until i >= an_idf_proxy.oids_index loop
					!!one_object.make(an_idf_proxy.ith_oid(i))
					one_object.remove
					i := i + 1
				end

				-- now delete the old IDF table
				!!one_object.make(oid)
				one_object.remove
			end
		end

end
