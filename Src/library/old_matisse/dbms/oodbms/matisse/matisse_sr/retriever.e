deferred class RETRIEVER 
 
inherit

	STORER_EXTERNAL
		export 
			{NONE} all
		end

feature -- Access

	retrieve(key:like anchor):EXT_STORABLE is
			-- Retrieve object structure, from external representation previously stored.
		require
			Key_valid: is_valid_key(key)
        	deferred
        	end
	
	anchor:ANY 
			-- Used to get arguments.

feature -- Status
	is_valid_key(a_key: like anchor):BOOLEAN is
			-- override as required in descendants
		do
			Result := True
		end
end
