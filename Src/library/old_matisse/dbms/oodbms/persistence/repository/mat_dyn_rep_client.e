indexing
	description:  "Dynamic database repository client for MATISSE repository. %
                  %Each instance corresponds to a Matisse Indexed stream of REP_ITEM%
                  %descendants (which is itself an EXT_STORABLE descendant).%
                  %It is assumed that indices called 'int_key' and 'ext_key' exists for the class.%
                  %Called a dynamic repository client since it always queries the database."
    keywords:     "database, cursor, matisse"
    revision:     "%%A%%"
    source:       "%%P%%"
	copyright:    "See notice at end of class"

class MAT_DYN_REP_CLIENT

inherit
	MAT_REP_CLIENT
	    rename
			make as mat_make
	    end

creation
	make

feature -- Initialisation
	make(a_ref_item:like ref_item; a_rep_name:STRING)  is
		do
			-- make rep client
			rep_client_make(a_ref_item, a_rep_name)

			-- Matisse initialisation
			mat_make
		end

feature -- Status
	has_key (a_key:STRING): BOOLEAN is
			-- is key known in Matisse Index?
	    local
			an_attribute:MT_ATTRIBUTE
			an_ext_storable:EXT_STORABLE
			stream_result_obj:LINKED_LIST[DB_RESULT]
	    do
			start_version_access("has_key")
			start_query(True)

			-- set start and end criteria entries in selection
			index_start_criteria.put(a_key,1)
			index_end_criteria.put(a_key,1)

			-- DO THE QUERY
			stream.execute(selection)
			!!stream_result_obj.make
			selection.set_container(stream_result_obj)

			-- EXAMINE the RESULTS
			if selection.is_ok then
				selection.load_result
				Result := not stream_result_obj.empty
			end

			end_version_access("has_key")
	    end

	is_locked (a_key:STRING): BOOLEAN is
			-- Root object tree locked in repository
	    do
			-- locking not yet implemented; just check it's there
			Result := has_key(a_key)
	    end

 	empty:BOOLEAN is
	    do
		    start_version_access("empty")
		    !!rep_class.make(name)
		    Result := rep_class.instances_count = 0
		    end_version_access("empty")
	    end

feature -- Cursor Movement
	go_top is
			-- set item_key to first entry in index
	    local
			keys:ARRAYED_LIST[STRING]
	    do
			item_key := First_key
			keys := retrieve_n_keys(1, True, True)

			if not keys.empty then
				item_key := keys.i_th(1)
			else
				append_fail_reason("go_top: retrieve_n_keys(First_key) failed")
			end	
	    end

	go_bottom is
			-- set item_key to last entry in index
	    local
			keys:ARRAYED_LIST[STRING]
	    do
			item_key := Last_key
			keys := retrieve_n_keys(1, False, True)

			if not keys.empty then
				item_key := keys.i_th(1)
			else
				append_fail_reason("go_bottom: retrieve_n_keys(Last_key) failed")
			end	
	    end

	set_key(a_key:STRING) is
			-- set item_key to a_key if valid
	    do
			if is_hard_match then
				if has_key(a_key) then
				     item_key := clone(a_key)
				else
					append_fail_reason("set_key: repository does not have key ")
					append_fail_reason(a_key)
					append_fail_reason(" (using hard-match)")
				end
			else
				item_key := clone(a_key)
			end
	    end

feature -- Repository Retrieval
	retrieve_n_keys(n:INTEGER; dir_forward, include_current:BOOLEAN): ARRAYED_LIST [STRING] is
		do
			Result := retrieve_n_attrs("stored_key", n, dir_forward, include_current)
			
			-- if not a hard match, key should be adjusted forward to the exact key of the 
			-- first thing that actually matched
			if not Result.empty and not is_hard_match then
				if dir_forward then
					item_key := clone(Result.i_th(1))
				else
					item_key := clone(Result.i_th(Result.count))
				end
			end
		end

	retrieve_n_attrs(attr_name:STRING; n:INTEGER; dir_forward, include_current:BOOLEAN): ARRAYED_LIST [STRING] is
			-- get n items, stringified, above or below db_cursor position
			-- or until run out of items. THIS CURRENTLY RETRIEVES ONLY
			-- KEYS, not STRINGIFIED OBJECTS
	    local
			i: INTEGER
			mt_obj:MT_OBJECT
			key_attribute:MT_ATTRIBUTE
			key_value:STRING
			limit_counter:STREAM_COUNTER
			class_desc:ODB_CLASS_DESCRIPTOR
	    do
			!!Result.make(0)

			start_version_access("retrieve_n_attrs")
			start_query(dir_forward)

			-- set index criteria depending on direction
			if dir_forward then
				index_start_criteria.put(item_key,1)
				index_end_criteria.put(Last_key,1)
			else
				index_start_criteria.put(First_key,1)
				index_end_criteria.put(item_key,1)
			end

			-- set the limit counter up and attach it to the selection object
			!!limit_counter.make(n)
			selection.set_action(limit_counter)

debug("rep")
	io.put_string("about to do stream.execute%N")
end
			-- PERFORM QUERY
			stream.execute(selection)
			!!stream_result.make
			selection.set_container(stream_result)

			-- LOAD the RESULTS
			if selection.is_ok then
debug("rep")
	io.put_string("about to do selection.load_result%N")
end
				selection.load_result	-- also closes the index stream

debug("rep")
	io.put_string("about to process results%N")
end
				from 
					stream_result.start 
					if not stream_result.off and not include_current then -- ditch 1st element from the list
						stream_result.remove
					end
				until 
					stream_result.off 
				loop
					mt_obj ?= stream_result.item.data
					if mt_obj /= Void then
debug("rep")
	io.put_string("getting key_attr.value%N")
end
						class_desc := odb_schema.class_descriptor_by_name(rep_class.name)
						!!key_attribute.make(class_desc.db_field_name(attr_name))		-- to display required attribute value
						key_value ?= key_attribute.value(mt_obj)
						check Result_key_valid: key_value /= Void end
						if dir_forward then
							Result.extend(key_value)
						else
							Result.put_front(key_value)
						end
					end
					stream_result.forth
				end
			else
				build_fail_reason("Retrieve N", "selection not ok", rep_session.error_message,rep_session.error_code)
			end
			end_version_access("retrieve_n_attrs")
	    end

	retrieve: like ref_item is
			-- get items matching item_key.
	    do
			Result := retrieve_by_key(item_key)
	    end

	retrieve_for_update: like ref_item is
			-- get item matching key and set locks on root object tree
	    do
	    end

feature -- Retrieval by specified key
	retrieve_by_key(a_key:STRING): like ref_item is
			-- get item matching key.
	    local
			key_attribute:MT_ATTRIBUTE
			limit_counter:STREAM_COUNTER
			mt_obj:MT_OBJECT
			idf_table_oid:INTEGER_REF
			an_ext_storable:EXT_STORABLE
			stream_result_obj:LINKED_LIST[DB_RESULT]
			msg:STRING
			class_desc:ODB_CLASS_DESCRIPTOR
	    do
			start_version_access("retrieve_by_key")
			start_query(True)

			-- set start and end criteria entries in selection
			index_start_criteria.put(a_key,1)
			index_end_criteria.put(a_key,1)

			-- set the limit counter up and attach it to the selection object
			-- should really just unset the action here... (but not available on DB_SELECTION)
			!!limit_counter.make(1)
			selection.set_action(limit_counter)

			-- DO THE QUERY
			stream.execute(selection)
			!!stream_result_obj.make
			selection.set_container(stream_result_obj)

			-- LOAD the RESULTS
			if selection.is_ok then
				selection.load_result
				stream_result_obj.start

				-- get the oid of the IDF table for this object
				if not stream_result_obj.empty then
					mt_obj ?= stream_result_obj.item.data
				end
				if mt_obj /= Void then
					class_desc := odb_schemas.item(rep_name).class_descriptor_by_name(rep_class.name)
					!!key_attribute.make(class_desc.db_field_name("stored_table_id"))	-- to get IDF table of obj
					idf_table_oid ?= key_attribute.value(mt_obj)
					check Result_oid_exists: idf_table_oid /= Void end

					if idf_table_oid.item > 0 then
						!!an_ext_storable
		  				an_ext_storable ?= an_ext_storable.retrieve(idf_table_oid.item)
						if an_ext_storable  /= Void then
							Result ?= an_ext_storable
							check Result_is_info_item: Result /= Void end
						else
							set_fail_reason("retrieve_by_key: retrieved object exists but not a REP_ITEM")
						end
					else
						set_fail_reason("retrieve_by_key: retrieved object exists but has no IDF_TABLE")
					end
				else
					msg := "retrieve_by_key: no object found matching key <"
					msg.append(a_key) msg.append(">")
					set_fail_reason(msg)
				end
			else
				build_fail_reason("Retrieve", "selection not ok", rep_session.error_message,rep_session.error_code)
			end

			end_version_access("retrieve_by_key")
	    end

	retrieve_by_key_for_update (a_key:STRING): like ref_item is
			-- get item matching key and lock for modify
	    do
			-- for the moment, just do a normal retrieve. In future, may simply
			-- mark root instance as "lock_required"
			Result := retrieve_by_key(a_key)
	    end

feature -- Repository Update
	insert(an_item:like ref_item) is
	        -- insert a new item into repository
	    do
			start_transaction("insert")

			an_item.store

			end_transaction("insert")
	    end

	update(an_item:like ref_item) is
	        -- replace item with same key value in repository with an_item
	    do
			start_transaction("update")

			-- so the following is probably incorrect
			an_item.store

			end_transaction("update")
	    end

feature -- Repository Removal
	delete(an_item:like ref_item) is
	        -- delete current item in repository
	    do
			start_transaction("delete")

			an_item.co_mark_for_store
			an_item.delete

			end_transaction("delete")
	    end

	delete_by_key(a_key:STRING) is
	        -- delete item in repository with key = a_key
	    local
	        an_item:REP_ITEM
	        msg:STRING
	    do
			an_item := retrieve_by_key(a_key)

			if an_item /= Void then
				delete(an_item)
			else
				msg := "delete_by_key: no object found matching key <"
				msg.append(a_key) msg.append(">")
				set_fail_reason(msg)
			end
	    end

	wipe_out is
			-- wipe out all objects of this type from the repository
		do
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+
