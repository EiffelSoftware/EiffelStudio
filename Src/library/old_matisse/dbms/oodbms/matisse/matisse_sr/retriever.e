deferred class RETRIEVER 
 
inherit

	STORER_EXTERNAL
		export {NONE} all
	end

feature -- Access

	retrieve(arg:like anchor): EXT_STORABLE is
            -- Retrieve object structure, from external
            -- representation previously stored.
        	deferred
        	end -- retrieve
	
	anchor : ANY 
		-- Used to get arguments.

end -- class RETRIEVER
