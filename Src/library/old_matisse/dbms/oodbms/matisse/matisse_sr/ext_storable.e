class EXT_STORABLE 

inherit

	-- TRAVERSAL

	STORE_HANDLE

	MEMORY
		export {NONE} all
		end

	IDF_ID
		export {NONE} all
		end

	ES_ACTIONS

feature -- Traversal
	closure_execute(arg:ANY) is
		   -- execute a traversal on the total closure starting from Current
	    local
		   trav:TRAVERSAL
	    do
		    !!trav.make(Current)
		    trav.execute(arg)
	    end
 
feature -- Actions
	current_action_type:CELL[INTEGER] is
			-- set for all composed objects
		once
			!!Result.put(0)
		end

	set_action_type(an_action_type:INTEGER) is
		require
			Args_valid: is_valid_action_type(an_action_type)
		do
			current_action_type.replace(an_action_type)
		end

	is_valid_action_type(an_action_type:INTEGER):BOOLEAN is
	    do
	        Result := an_action_type = Es_default or 
				    an_action_type = Es_store or 
				    an_action_type = Es_retrieve or
				    an_action_type = Es_delete
		end

	actions: TRAVERSAL_ACTION is
             -- switch to particular action during traversal.
	    do
			inspect current_action_type.item
			when Es_default then
				Result := default_actions
			when Es_store then
				Result := store_actions
			when Es_delete then
				Result := delete_actions
			when Es_retrieve then
				Result := retrieve_actions
			end
	    end

	store_actions: CO_STORE_ACTION is once !!Result end
		-- action used for storing during traversal.

	retrieve_actions: CO_RETRIEVE_ACTION is once !!Result end
		-- action used for retrieving during traversal.

	delete_actions: CO_DELETE_ACTION is once !!Result end
		-- action used for retrieving during traversal.

	default_actions : TRAVERSAL_ACTION is  once !!Result end

feature -- store and retrieve

	store  is
			-- Produce an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable within current system only.
		do
			storer.item.store_closure(Current) 
		end

	pre_store_action is
			-- perform any action required before storage; typically computation of
			-- stored versions of data. To be overridden by descendents
		do 
		end

	retrieve(key:ANY): EXT_STORABLE is
			-- Retrieve object.
		do
			Result ?= retriever.item.retrieve(key)
		end

	delete is
		    -- delete object.
		do
			storer.item.delete_closure(Current) 
		end

	table_id : INTEGER is 
			-- Identifier of table necessary to retrieve objects in database
		do
			Result := id_cell.item
		end

--	retrieve_by_name (file_name: STRING): EXT_STORABLE is
--		do
--			Result ?= basic_retriever.retrieve (file_name)
--		end

feature -- {DATABASE_STORER, DATABASE_RETRIEVER}
-- this is totally dodgy, but since the IDF table is written every time, the 
-- correct OID should be written into the object. 
-- May be better to do properly with Matisse relationship
    set_stored_table_id(id:INTEGER) is
        do
	        stored_table_id := id
        end

    set_retrieved_id(id:INTEGER) is
        do
	        retrieved_id := id
        end

feature -- probably should be exported only to DATABASE_STORER, RETRIEVER as well....
    stored_table_id :INTEGER

    retrieved_id:INTEGER
            -- oid of this object as at most recent retrieve

end
