deferred class DATABASE_STORER 

inherit

	STORE_SHIFTER
		export 
			{NONE} all
		end

	DB_STATUS_USE
		export 
			{NONE} all;
			{ANY} is_connected 
		end

	STORER
		export 
			{NONE} all;
			{TRAVERSAL_ACTION} put_object, delete_sub_closure
		undefine 
			is_integer, is_real , is_double, is_character, is_string
		end

	MEMORY
		export 
			{NONE} all
		undefine 
			dispose
		end

	ES_ACTIONS

	SHARED_ODB_ACCESS
		export
			{NONE} all
		end

feature {EXT_STORABLE} -- services

	store_closure(es:EXT_STORABLE) is
			-- Prepare storage and store closure reachable from 'es'; type of closure depends
			-- on whether es is EXT_STORABLE, COMPOSED_OBJECT etc
		local
			was_collecting : BOOLEAN
		do
debug("matisse-sr") 
    io.put_string(shifter.out)
    io.put_string("DATABASE_STORER.store_closure: ")
    io.put_string(class_name(es))
    io.new_line
end
			-- Stop garbage collector
			was_collecting := collecting full_collect collection_off

			-- unmark the total closure
			deep_unmark(es)

			-- wipe_out the proxy idf table stack
			idf_proxy_stack.wipe_out

			-- wipe_out the closures in progress stack
			sub_closures_in_progress.wipe_out

			--  set up reverse reference tables
			!!ref_tables.make(0)

			--  set the action to Store, then execute
			es.set_action_type(Es_store)
			es.closure_execute(Void)

			--  Set the garbage collector            
			if was_collecting then collection_on end
		end

	delete_closure(es:EXT_STORABLE) is
		local
			was_collecting : BOOLEAN
		do
debug("matisse-sr") 
    io.put_string(shifter.out)
    io.put_string("DATABASE_STORER.delete_closure: ")
    io.put_string(class_name(es))
    io.new_line
end
			-- Stop garbage collector
			was_collecting := collecting full_collect collection_off

			-- unmark the total closure
			deep_unmark(es)

			-- wipe_out the closures in progress stack
			sub_closures_in_progress.wipe_out

			-- delete the object composition (all instances in its IDF_TABLE,
			-- as well as the IDF_TABLE itself)
			es.set_action_type(Es_delete)
			es.closure_execute(Void)

			--  Set the garbage collector            
			if was_collecting then collection_on end
		end

feature {TRAVERSAL_ACTION} -- Implementation
	ref_tables:STORE_REF_TABLES

	dispose is
			-- Do nothing
		do
		end

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

feature {TRAVERSAL} -- Traversal
	update_ref_tables(es:EXT_STORABLE) is
			-- add an entry in rev ref tables for a forward reference to an object that is
			-- not going to be stored (due to being not marked, or in another composition);
			-- it must have already been stored in the past!
		require
			Objects_exist: es /= Void
		local
			reverse_refs : STORE_REF_TABLE
			ptr_ref:POINTER_REF
		do
			if es.retrieved_id /= 0 then
				-- Is object referenced in reverse reference table yet?
				reverse_refs := ref_tables.item($es)
				if reverse_refs = Void then 
debug("matisse-sr") 
    io.put_string(shifter.out)
    io.put_string("update_ref_tables - added new table for: ")
    io.put_string(class_name(es))
    io.put_string(" - OID=") io.put_integer(es.retrieved_id)
!!ptr_ref
ptr_ref.set_item($es)
    io.put_string("; PTR=") io.put_string(ptr_ref.out)
    io.new_line
end
					-- create reverse reference table for object
					!!reverse_refs.make_target(es.retrieved_id, $es)
					ref_tables.add_table(reverse_refs)
				end
			end
		end

	sub_closure_in_progress:EXT_STORABLE is
			-- current sub-closure in processing of a closure
		do
			Result := sub_closures_in_progress.item
		end

	sub_closures_in_progress:LINKED_STACK [EXT_STORABLE] is
			-- all unfinished sub-closures so far in current closure processing
		once
			!!Result.make
		end

invariant

    always_connected : is_connected

end
