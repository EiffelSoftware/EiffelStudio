class EXT_STORABLE 

inherit

	TRAVERSAL

	STORE_HANDLE

	MEMORY
		export {NONE} all
		end

	IDF_ID
		export {NONE} all
		end

feature -- store and retrieve

	store (arg: IO_MEDIUM)  is
		-- Produce an external representation of the
		-- entire object structure reachable from current object.
		-- Retrievable within current system only.
		do
			storer.item.store(Current,arg) 
		end -- store

	retrieve(arg: ANY): EXT_STORABLE is
		-- Retrieve object.
		do
			Result ?= retriever.item.retrieve(arg)
		end -- retrieve

	default_actions : TRAVERSAL_ACTION is
		-- Default action used during traversal.
		once
			!!Result
		end -- default_actions

	table_id : INTEGER is 
		-- Identifier of table necessary to retrieve objects in database
		do
			Result := id_cell.item
		end -- table_id
	
	retrieve_by_name (file_name: STRING): EXT_STORABLE is
		do
			Result ?= basic_retriever.retrieve (file_name)
		end

end -- class EXT_STORABLE
