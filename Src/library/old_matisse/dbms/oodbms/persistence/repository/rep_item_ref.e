indexing
    description:  "Proxy equivalent of a REP_ITEM; holds just enough information to %
                  %correctly identify the REP_ITEM. Main use is to replace direct references %
                  %to objects by shared objects. For example, the DOCTOR case: rather %
                  %than patients:LIST[PATIENT], patient_refs:LIST[REP_ITEM_REF[PATIENT]] can be used. This %
                  %will have the effect of just storing a few strings (keys etc), rather than a %
                  %reference to an actual PATIENT. This is important with an OO persistence %
                  %mechanism, since if live references from shared objects were used, the entire %
                  %database can be retrieved (undesirable!)."
    keywords:	  "database, REP_ITEM"
    revision:	  "%%A%%"
    source:	      "%%P%%"
	copyright:    "See notice at end of class"

class REP_ITEM_REF [G->REP_ITEM]

inherit
	SHARED_ACCESS
	DB_ERROR_STATUS

creation
	from_rep_item, from_key

feature -- Initialisation
	from_rep_item(an_item:G) is
	    require
	        Args_valid: an_item /= Void
	    do
			stored_key := an_item.key
			rep_client_name := an_item.rep_client_name
	    end

	from_key(a_rep_client_name, a_rep_item_key:STRING) is
			-- create a ref to an object using a REP_CLIENT name and
			-- key. No checking is done, so the caller is not required
			-- to have access to the REP_CLIENT repository, or know about it.
		require
			Valid_rep_client: a_rep_client_name /= Void and then not a_rep_client_name.empty
			Valid_key: a_rep_item_key /= Void and then not a_rep_item_key.empty
		do
			stored_key := a_rep_item_key
			rep_client_name := a_rep_client_name
		end

feature -- Status
	is_caching:BOOLEAN
		-- True if result of first retrieve used for all
		-- later accesses.

feature -- Status Setting
	set_caching is 
		do
			is_caching := True
		end

	unset_caching is
		do
			is_caching := False
		end

feature -- Access
	stored_key:STRING
			-- called stored_key rather than key due to the fact that 'key' is a
			-- keyword in most database ODLs

	rep_client_name:STRING

feature -- Conversion
	as_rep_item: like rep_item_cache is
			-- string format for viewing in browsers etc
		local
			rep:REP_CLIENT
			msg:STRING
		do
			clear_fail_reason

			if is_caching then
				Result := rep_item_cache

			else -- first-time access
				if archetype.has_type(rep_client_name) then
					rep := get_rep_client(rep_client_name)

					Result := rep.retrieve_by_key(stored_key)
					if rep.last_op_fail then
						set_fail_reason(rep.fail_reason)
					elseif archetype.rep_unit(rep_client_name).bus_obj_desc.rep_reference then
						is_caching := True
						rep_item_cache := Result
					end
				else
					!!msg.make(0)
					msg.append("REP_CLIENT <")
					msg.append(rep_client_name)
					msg.append("> does not exist")
					set_fail_reason(msg)
				end
			end
		ensure
			Fail_reason_given: Result = Void implies last_op_fail
		end

feature {NONE} -- Implementation
	rep_item_cache:REP_ITEM
		-- a cache for the object, after first retrieval
		-- FIXME: this wants to be 'G' really, not 'REP_ITEM', but
		-- it fails the VJRV compiler check (see ETL p332)

invariant
	Reason_given: last_op_fail implies (fail_reason /= Void and then not fail_reason.empty)

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
