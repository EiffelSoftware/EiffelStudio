indexing	
	description: "OBJECTs, consisting of a composition of instances. The joining%
                   %client/supplier links have aggregation rather than association semantics."
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class COMPOSED_OBJECT

inherit
	STORE_SHIFTER	-- this is only for debug - it should be removed one day...

	EXT_STORABLE
		redefine
			closure_execute
		end

feature -- Initialisation
--	co_make(is_a_subpart:BOOLEAN) is
	co_make is
	        -- make a composed_object, indicating whether it is intended as an aggregation
	        -- sub-part object, or as an aggregation "top" object (i.e. a "whole")
	    require
			Agg_parent_not_set: agg_parent = Void
	    do
			agg_parent := Current
			co_mark_for_store
--		is_subpart := is_a_subpart
	    ensure
			Agg_parent_set: is_agg_root
	    end

feature -- Status
	is_agg_root:BOOLEAN is
			-- is this object currently an aggregation root object (true if not is_subpart
			-- or else is_subpart but not yet assembled)
		do
		    Result := agg_parent = Current
		ensure
		    Valid_result: agg_parent = Current implies Result
		end

--        is_subpart:BOOLEAN
	           -- is this object intended as a subpart rather than a whole?

	is_sub_agg_root:BOOLEAN is
		do
			Result := agg_parent = Void
		end

	is_stored:BOOLEAN is
            do
                Result := rep_info /= Void
            end
	
	is_in_aggregation(root_object:COMPOSED_OBJECT):BOOLEAN is
			-- is 'Current' in the aggregation closure of 'root_object'?
		require
			Root_object_exists: root_object /= Void
		local
			found, exhausted:BOOLEAN
			csr: COMPOSED_OBJECT
		do
			from
				csr := Current
			until
				found or exhausted
			loop
				found := csr.agg_parent = root_object
				csr := csr.agg_parent
				exhausted := csr = Void or else csr.is_agg_root
			end
			Result := found
		end

--
-- the following would be a very powerful basis for validity checking, but needs to be thought
-- about more; particularly, how can one say when an object is truly "assembled". Also, is is
-- reasonable to try and test validity of subparts, even if they are assembled? Perhaps only
-- the validity of the whole should be testable in the assembled state...
--
--	    is_assembled:BOOLEAN is
--		       -- if a subpart, has this object been assembled into an aggregate, or is
--		       -- it still sitting waiting to be used?
--	        deferred
--	        end
--
--    feature -- Validity
--	    is_valid:BOOLEAN is
--	        do
--	 	       if is_assembled then
--		           Result := is_valid_when_assembled
--		       else
--		           Result := is_valid_when_unassembled
--		       end
--	        end
--
--	    is_valid_when_unassembled:BOOLEAN is
--	            -- True if 'Current' is valid in its unassembled state
--	        deferred
--	        end
--
--	    is_valid_when_assembled:BOOLEAN is
--	            -- True if 'Current' is valid in its assembled state
--	        deferred
--	        end
--

feature -- Structural Composition
	agg_parent: COMPOSED_OBJECT

	rep_info:ANY
		-- repository information, e.g. OID **** SEE EXT_STORABLE's retrieved_id

feature -- Persistence
	co_marked_for_store:BOOLEAN
		-- True if this composition closure needs to be stored

	co_mark_for_store is
	    do
	        co_marked_for_store := True
	    end

	co_unmark_for_store is
	    do
	        co_marked_for_store := False
	    end

feature -- Modify Structure
	co_attach_subpart(obj:COMPOSED_OBJECT) is
			-- attach 'obj' as aggregation subpart of 'Current';
			-- to be called whenever a subpart attachment is made
		require
			Obj_not_already_subpart: obj.is_agg_root
		do
			obj.co_attach_as_subpart(Current)
			co_mark_for_store
		ensure
			Obj_subpart_of_current: obj.agg_parent = Current
		end

	co_detach_subpart(obj:COMPOSED_OBJECT) is
			-- detach 'obj' from 'Current'; 
			-- to be called whenever a subpart detachment is made
		require
			Obj_already_subpart: obj.agg_parent = Current
		do
			obj.co_detach_as_subpart
			co_mark_for_store
		ensure
			Obj_detached: obj.is_agg_root
		end

   	co_add_association(obj:COMPOSED_OBJECT) is
			-- add an association to 'obj'
			-- to be called whenever an association link is made
		do
			co_mark_for_store
		end

	co_remove_association(obj:COMPOSED_OBJECT) is
			-- remove an association to 'obj'
			-- to be called whenever an association link is broken
		do
			co_mark_for_store
		end

feature {COMPOSED_OBJECT} -- Modify Structure
	co_attach_as_subpart(root_obj:COMPOSED_OBJECT) is
			-- attach 'Current' as subpart of 'root_obj'
		require
			Not_already_subpart: is_agg_root
		do
			agg_parent := root_obj
			co_mark_for_store
		ensure
			Is_subpart: agg_parent = root_obj
		end

	co_detach_as_subpart is
			-- detach 'Current' as subpart of 'top_root'
		require
			Already_subpart: not is_agg_root
		do
			agg_parent := Current
			co_mark_for_store
		ensure
			Is_agg_root: is_agg_root
		end

feature -- Traversal
	closure_execute(root_target:COMPOSED_OBJECT) is
			-- traverse a sub-aggregation closure
	    local
	        comp_trav:AGGREGATE_TRAVERSAL
	    do
			!!comp_trav.make(Current)
			if root_target /= Void then
				comp_trav.execute(root_target)
			else
				-- first-time call only
				comp_trav.execute(Current)
			end
	    end

feature -- Comparison
	frozen co_equal(some: COMPOSED_OBJECT; other: like some) is
		do
			-- to be implemented using the standard traversal & action method, if possible
		end

	is_co_equal(other:like Current):BOOLEAN is
		do
			-- to be implemented using the standard traversal & action method, if possible
		end

feature -- Duplication
	frozen co_clone(other: like Current): like other is
			-- create a limited deep-clone of the current composition
			-- closure so that inside the closure, objects are cloned, 
			-- while only references to objects outside are copied.
		do
			-- to be implemented using the standard traversal & action method, if possible
		end

	frozen co_copy(other: like Current) is
			-- update objects in the composition closure 'Current'
			-- so as to be content-equal to 'other'
		do
			-- to be implemented using the standard traversal & action method, if possible
		end

feature {NONE} -- Implementation

invariant
        -- Agg_parent_exists: agg_parent /= Void -- not for the moment - Void used to mean sub_aggregate

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+
