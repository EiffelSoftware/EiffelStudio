indexing
	description: "Static database repository. Provides internal storage and%
                    %access methods, and a deferred template method for initial (one-time)%
                    %population. Descendents can implement this with an SQL query %
                    %for example."
	keywords:    "static database repository"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

deferred class STAT_REP_CLIENT

inherit
	REP_CLIENT
		rename
			make as rep_client_make
		end

feature -- Initialisation
	make is
		do
			!!content.make
			item_key := clone(first_key)
		end

feature -- Access
	sanity_limit:INTEGER is 200
		-- maximum number of items to be returned

feature -- Status
	has_key(a_key:STRING):BOOLEAN is
			-- 'a_key' exists in currently chosen index
			-- do a soft-match; i.e. for nr chars in a_key
	    do
			move_to_key(a_key)
			Result := not content.off
	    end

	empty:BOOLEAN is
	    do
			Result := content.empty
	    end

feature -- Indexing
	index_names:ARRAYED_LIST [STRING] is
			-- list of index names for this class.
		do
		end

feature -- Repository Cursor Movement: non-key
	set_key(a_key:STRING) is
	    do
			if has_key(a_key) then
			    item_key := a_key
			end
	    end

	go_top is
	    do
			content.start
			if not content.off then
		    	item_key := content.item.key
			end
	    end

	go_bottom is
	    do
			content.finish
			if not content.off then
		    	item_key := content.item.key
			end
	    end

feature -- Repository Retrieval
	retrieve_n_keys(n:INTEGER; dir_forward, include_current:BOOLEAN): ARRAYED_LIST [STRING] is
	    local
			i: INTEGER
	    do
			-- set the repository cursor to where we think we are
			move_to_key(item_key)

			!!Result.make(0)

			if dir_forward then
		    	from
			        i := 1
					if not include_current and not content.off then
		            	content.forth
					end
			    until
			        i > n or content.off
			    loop
		        	Result.extend(content.item.item.key)
		    	    content.forth
			        i := i + 1
			    end
			else
		    	from
			        i := 1
					if not include_current and not content.off then
		            	content.back
					end
			    until
			        i > n or content.off
			    loop
		        	Result.put_front(content.item.item.key)
		    	    content.back
			        i := i + 1
			    end
			end
	    end

	retrieve:like ref_item is
	    local
	        msg:STRING
	    do
			move_to_key(item_key)
			if not content.off then
				Result := content.item.item
			else
			    msg := "retrieve: item with key " msg.append(item_key)
		    	msg.append(" not in repository")
			    set_fail_reason(msg)
			end
	    end

  	retrieve_for_update: like ref_item is
		-- get item matching item_key
	    do
	        Result := retrieve
	    end

	retrieve_by_key(a_key:STRING):like ref_item is
	    local
	        msg:STRING
	    do
			move_to_key(a_key)
			if not content.off then
				Result := content.item.item
			else
			    msg := "retrieve: item with key " msg.append(a_key)
		    	msg.append(" not in repository")
			    set_fail_reason(msg)
			end
	    end

  	retrieve_by_key_for_update(a_key:STRING): like ref_item is
			-- get item matching a_key
	    do
	        Result := retrieve_by_key(a_key)
	    end

feature -- Repository Update
	insert(an_item:like ref_item) is
	        -- insert a new item into repository
	    local
			cell: STAT_REP_KEY_CELL[like ref_item, STRING]
	    do
			-- add to source
			source.extend(an_item)

			!!cell.make(source.item, source.item.key)
			content.extend(cell)
	    end

	update(an_item:like ref_item) is
	        -- write an_item back to repository, replacing current
	        -- item with same key
	    local
			errstr:STRING
			cell: STAT_REP_KEY_CELL[like ref_item, STRING]
	    do
			-- go to the position corresponding to 'an_item'
			move_to_key(an_item.key)
	
			-- find the item in the source list
			if source.has(content.item.item) then
			    source.search_after(content.item.item)

			    -- make sure we're on the right item
		    	if source.item.key.is_equal(an_item.key) then
			    	source.replace(an_item)

					-- do a traversal to fix all links
					-- NOT YET IMPLEMENTED

					-- replace in the content lists
					!!cell.make(source.item, source.item.key)
					content.replace(cell)
			    else
					-- something badly wrong in list searching!
		        	errstr := "update: source.search_after(item) failed; key = "
		    	    errstr.append(content.item.item.key)
			        set_fail_reason(errstr)
			    end
			else
			    errstr := "update: source.has(item) failed; key = "
			    errstr.append(content.item.item.key)
			    set_fail_reason(errstr)
			end
	    end

feature -- Repository Removal
	delete(an_item:like ref_item) is
	    do
			source.prune_all(an_item)
			content.remove
	    end

	delete_by_key(a_key:STRING) is
	        -- delete item with key a_key from repository. Transaction
			-- fails if item does not exist in repsitory.
	    do
			move_to_key(a_key)
			if not content.off then
				delete(content.item.item)
			else
			    set_fail_reason("delete_by_key: item does not exist")
			end
	    end

	wipe_out is
			-- wipe out all objects of this type from the repository
		do
		end

feature {NONE} -- Implementation
	populate(a_source: like source) is
				-- populate content
	    do
			populate_source(a_source)
			populate_content
	    end

	populate_source(a_source: like source) is
			-- populate source
	    deferred
	    ensure
	        Source_populated: source /= Void
	    end

	populate_content is
			-- build content lists once source is populated
	    require
			Source_populated: source /= Void
	    local
			cell: STAT_REP_KEY_CELL[like ref_item,STRING]
	    do
			from
				source.start
			until
				source.off
			loop
				!!cell.make(source.item, source.item.key)
				content.extend(cell)

				source.forth
			end
	    end


	move_to_key(a_key:STRING) is
			-- set the repository cursor according to the key; soft search
	    local
			found:BOOLEAN
			db_key:STRING
			key_cell:STAT_REP_KEY_CELL[like ref_item, STRING]
	    do
			!!key_cell.make(ref_item,a_key)

			-- sort list if necessary
			if not content.sorted then
				content.sort
			end

			content.search_after(key_cell)
			if not content.off then
				db_key := content.item.key
				if a_key.count < db_key.count then
				    found := a_key.is_equal(db_key.substring(1, a_key.count))
				else
				    found := a_key.is_equal(db_key)
				end
	        end

			-- simulate a failed search by putting cursor off end
			if not found then
				content.finish
				content.forth
			end
	    ensure
			Match_found: not content.off implies a_key.is_equal(content.item.key.substring(1, a_key.count))
	    end

feature {NONE} -- Structure
	content:FAST_SORTED_TWO_WAY_LIST [STAT_REP_KEY_CELL[like ref_item, STRING]]

	source:FAST_SORTED_TWO_WAY_LIST [like ref_item]

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
