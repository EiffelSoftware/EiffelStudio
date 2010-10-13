indexing
	description	: "Class representing the index."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"
	
class
	SHARED_LIST

feature {SEARCHER} -- Search

	can_search: BOOLEAN is
			-- Can search?
		do
			Result := not deleting
		end

	start_search is
			-- Start a search.
		require
			can_search
		do
			searchers := searchers + 1
		end

	end_search is
			-- End a search.
		do
			searchers := searchers - 1
		end

feature {INSERTER} -- Insert

	can_insert: BOOLEAN is
			-- Can insert?
		do
			Result := not deleting and not inserting
		end

	start_insert is
			-- Start an insert.
		require
			can_insert
		do
			inserting := True
		end

	end_insert is
			-- End an insert.
		do
			inserting := False
		end

feature {DELETER} -- Delete

	can_delete: BOOLEAN is
			-- Can delete?
		do
			Result := not deleting and not inserting and searchers = 0
		end

	start_delete is
			-- Start a delete.
		require
			can_delete
		do
			deleting := True
		end

	end_delete is
			-- End a delete.
		do
			deleting := False
		end

feature {NONE} -- Implementation

	searchers: INTEGER
			-- How many searchers are there?

	inserting: BOOLEAN
			-- Is someone inserting?

	deleting: BOOLEAN
			-- Is someone deleting?

invariant

	searchers_not_negative: searchers >= 0

	no_actors_when_deleting: deleting implies (not inserting and searchers = 0)

	no_deleters_when_inserting: inserting implies not deleting

end
