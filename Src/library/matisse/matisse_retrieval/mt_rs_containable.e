indexing
	description: "This class gives the capability of MATISSE relationship to its descendant classes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MT_RS_CONTAINABLE

inherit
	MT_CONSTANTS
		export 
			{NONE} all
			{ANY} generator, out
		end
	
feature -- Status
	
	is_persistent: BOOLEAN is
			-- Are 'predecessor' and 'relationship' set?
		do
			Result := predecessor /= Void and then relationship /= Void
		end
	
feature {MT_RELATIONSHIP} -- Status setting

	revert_to_unloaded is
		do
			wipe_out_at_reverting
			successors_loaded := False
		end	

feature -- Primitive successor accessing

	mt_first_successor: MT_STORABLE is
		do
			Result := relationship.first_successor (predecessor)
		end
		
feature {MT_RELATIONSHIP} -- Access

	set_relationship (a_rel: like relationship) is
		do
			relationship := a_rel
		end
	
	set_predecessor (an_obj: like predecessor) is
		do
			predecessor := an_obj
		end



feature {NONE} -- Persistence

	check_persistence (an_obj: MT_STORABLE) is
			-- Does an_obj belong to 'relatioship.database'?
			-- If not, promote an_obj to persistent one.
		do
			if not relationship.database.has (an_obj) then
				relationship.database.persist (an_obj)
			end
		end

feature --{NONE} -- Implementation
	
	predecessor: MT_STORABLE
			-- If predecessor is Void, current object can not be used
			-- as a container of successors of MATISSE relationship.
		
	relationship: MT_MULTI_RELATIONSHIP
			-- If predecessor is set properly and relationship is void,
			-- current object could be a container of successors of 
			-- MATISSE relationship (but not yet). That is, current
			-- object is created by you, not by Eiffel-MATISSE Interface
			-- program.
		
	successors_loaded: BOOLEAN

	load_successors is
			-- Get all the successors of predecessor through relationship.
		local
			keys_count, i: INTEGER
		do
	--		SM, 01/25/99: do not see the use of this line and worst, it implies errors
	--		relationship.database.clear_all_properties_when_obsolete_wo_class (predecessor)
		if not successors_loaded then
				successors_loaded := True
				if is_persistent then
					relationship.load_successors (Current, predecessor)
				end
			end
			
		end


feature -- Removal

	wipe_out_at_reverting is
		deferred
		end	
	
end -- class MT_RS_CONTAINABLE


