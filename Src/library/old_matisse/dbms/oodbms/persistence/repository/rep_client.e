indexing
	description:  "Simple Abstraction for database interfacing. Supports %
                    % the notion of a cursor in a container of objects, insertion, deletion, %
                    % and searching. This interface is intended to look like a database, %
                    % rather than a list, so it has features like go_top, go_bottom, %
                    % insert, delete etc.%
                    % %
                    % One of the main justifications for this class is to provide a known %
                    % interface to database operations, i.e. it acts as the sole (or one of %
                    % a few) known points of software interface to the database. If a new %
                    % database system is added (or the current one replaced), only this class %
                    % will be affected. %
                    % %
                    % There is a item_key, which is the key representing the current %
                    % position in the database, and selected_key, which is the key of the %
                    % database item which has been marked as being selected by the user%
                    % (e.g. via selection in a browser window). This distinction is needed %
                    % for situations where the user has selected an item, but the database%
                    % cursor points to where the user browser is set to, which could be %
                    % somewhere entirely different"
	keywords:	 "database, cursor"
	revision:	 "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

deferred class REP_CLIENT

inherit
	SHARED_ODB_ACCESS
		export
			{NONE} all
		end

	DB_ERROR_STATUS
	ASCII
	    export
			{NONE} all
	    end
	BASIC_ROUTINES
	    export
			{NONE} all
	    end

feature -- Initialisation
	make(a_ref_item:like ref_item; a_rep_name:STRING)  is
		require
			Ref_item_exists: a_ref_item /= Void
			Rep_name_exists: a_rep_name /= Void and then not a_rep_name.empty
		do
			ref_item := a_ref_item
			rep_name := a_rep_name
			set_hard_match
			index_name := default_index_name
		ensure
			Is_hard_match: is_hard_match
			Default_index_set: index_name = default_index_name
		end

feature -- Access
	rep_name:STRING
		-- logical name of the repository to which this client is attached

	item_key:STRING
		-- key of the notional current item of the REP_CLIENT
		-- Can only be set to a valid key, but in a client/server
		-- environment, may become invalid later.

	name:STRING is
		do
			Result := ref_item.generator
		end

feature -- Modification
	-- in a more dynamic system, could have individual item modifiabliltiy
	-- but we also have to consider data "ownership", which typically
	-- relates to whole data sources

	set_modifiable is
	    do
		is_modifiable := True
	    ensure
		Is_modifiable: is_modifiable = True
	    end

	unset_modifiable is
	    do
			is_modifiable := False
	    ensure
			Is_modifiable: is_modifiable = False
	    end

	set_hard_match is
	    do
			is_hard_match := True
	    ensure
			Is_hard_match: is_hard_match
	    end

	unset_hard_match is
	    do
			is_hard_match := False
	    ensure
			Is_hard_match: not is_hard_match
	    end

feature -- Status
	is_unique (an_item:like ref_item): BOOLEAN is
			-- checks 'an_item' for uniqueness against repository contents
			-- done by looking at INFO_ITEM.external_key
	    require
			Args_valid: an_item /= Void
	    local
			int_index:BOOLEAN
	    do
			Result := not has_key(an_item.key)
	    end

	has_key (a_key:STRING): BOOLEAN is
	    require
			Args_valid: a_key /= Void and not a_key.empty
	    deferred
	    end

	has (an_item:like ref_item): BOOLEAN is
			-- an item exists in repository with 'an_item'.key
	    require
			Args_valid: an_item /= Void
	    local
			int_index:BOOLEAN
	    do
			Result := has_key(an_item.key)

	    ensure
			Result implies has_key(an_item.key)
	    end

	empty: BOOLEAN is
	    deferred
	    end

	is_modifiable: BOOLEAN
	    -- is this client accessing a readonly repository (usually remote, owned
	    -- by some other business owner)

	is_hard_match:BOOLEAN
	    -- exact key match required for success in retrieve operations

feature -- Cursor Movement
	go_top is
	        -- set item_key to first key (or some standard guaranteed
	        -- first key)
	    deferred
	    ensure
			Valid_key: has_key(item_key) or else empty
	    end

	go_bottom is
	        -- set item_key to last key (or some standard guaranteed last key)
	    deferred
	    ensure
			Valid_key: has_key(item_key) or else empty
	    end

	set_key(a_key:STRING) is
	    require
			Args_valid: a_key /= Void and not a_key.empty
	    deferred
	    ensure
			Set_if_key_exists: (is_hard_match and has_key(a_key)) implies item_key.is_equal(a_key)
			Set_if_not_hard_match: not is_hard_match implies item_key.is_equal(a_key)
	    end

feature -- Indexing
	Key_len:INTEGER is
	    once
			-- get from database
			Result := 40
	    end

	First_key:STRING is
		-- guaranteed first string index value (all First_printables)
	    once
			!!Result.make(Key_len)
			Result.fill_character(charconv(First_printable))
	    end

	Last_key:STRING is
			-- guaranteed last string index value (all Last_printables)
	    once
			!!Result.make(Key_len)
			Result.fill_character(charconv(Last_printable))
	    end

	index_name:STRING

	default_index_name:STRING is "stored_key"
			-- assume there is always an index based on REP_ITEM.key

	set_index_name(a_name:STRING) is
			-- set name of index to be used in subsequent index stream operations (all retrieves)
		require
			Args_valid: a_name /= Void and then index_names.has(a_name)
		do
			index_name := a_name
		end

	index_names:ARRAYED_LIST [STRING] is
			-- list of all index names available for this repository
		deferred
		ensure
			Result_exists: Result /= Void
		end

feature -- Repository Retrieval
	retrieve_n_keys(n:INTEGER; dir_forward, include_current:BOOLEAN): ARRAYED_LIST [STRING] is
			-- get n item keys, starting above or below cursor position
			-- or until run out of items.
	    require
			Args_valid: n >= 0
	    deferred
	    ensure
			Result_exists: Result /= Void
	    end

	retrieve: like ref_item is
			-- get items matching item_key.
	    deferred
	    ensure
			Result_exists_if_ok: not last_op_fail implies Result /= Void
	    end

  	retrieve_for_update: like ref_item is
			-- get item matching item_key
	    require
			Is_modifiable: is_modifiable
	    deferred
	    ensure
			Exists: not last_op_fail implies Result /= Void
	    end

	retrieve_by_key(a_key:STRING): like ref_item is
			-- get items matching a_key.
	    require
			Args_valid: a_key /= Void
	    deferred
	    ensure
			Result_exists_if_ok: not last_op_fail implies Result /= Void
	    end

  	retrieve_by_key_for_update(a_key:STRING): like ref_item is
			-- get item matching a_key
	    require
			Args_valid: a_key /= Void
			Is_modifiable: is_modifiable
	    deferred
	    ensure
			Exists: not last_op_fail implies Result /= Void
	    end

feature -- Repository Update
	insert(an_item:like ref_item) is
	        -- insert a new item into repository
	    require
			Args_valid: an_item /= Void
			Is_modifiable: is_modifiable
			Is_unique: is_unique(an_item)
	    deferred
	    ensure
			Inserted: not last_op_fail implies has(an_item)
	    end

	update(an_item:like ref_item) is
	        -- write an_item back to repository, replacing current
	        -- item with same key
	    require
			Args_valid: an_item /= Void
			Is_modifiable: is_modifiable
			Exists_in_repository: has(an_item)
	    deferred
	    ensure
			Updated: not last_op_fail implies has(an_item)
	    end

feature -- Repository Removal
	delete(an_item:like ref_item) is
	        -- delete item with key item_key from repository. Transaction
			-- fails if item does not exist in repsitory.
	    require
			Args_valid: an_item /= Void
			Is_modifiable: is_modifiable
			Exists_in_repository: has(an_item)
	    deferred
	    ensure
			Deleted: not last_op_fail implies not has_key(an_item.key)
	    end

	delete_by_key(a_key:STRING) is
	        -- delete item with key a_key from repository. Transaction
			-- fails if item does not exist in repsitory.
	    require
			Args_valid: a_key /= Void
			Is_modifiable: is_modifiable
	    deferred
	    end

	wipe_out is
			-- wipe out all objects of this type from the repository
		deferred
		end

feature {NONE} -- Structure
	ref_item:REP_ITEM

invariant
	Ref_item_exists: ref_item /= Void
	Name_exists: name /= Void and then not name.empty
	Rep_name_exists: rep_name /= Void and then not rep_name.empty

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
