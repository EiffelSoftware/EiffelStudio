indexing
	description: "MATISSE-Eiffel Binding: representing single cardinality CompositeRelationship";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_SINGLE_COMPOSITE_RELATIONSHIP

inherit
	MT_COMPOSITE_RELATIONSHIP
		undefine
			is_equal
		end
		
	MT_SINGLE_RELATIONSHIP
		redefine
			set_successors_of
		end

creation
	make_from_oid	

feature {MATISSE}

	set_successors_of (a_predecessor: MT_STORABLE) is
			-- Remove the old successor of a_predecessor through the current 
			-- relationship by deleting it and then add the current 
			-- successor of a_predecessor which is held by an_object.
		local
			a_succ: MT_OBJECT
			sid: INTEGER
		do
			a_succ ?= field (eif_field_index, a_predecessor)
			if a_succ = Void then
				c_remove_all_succs_ignore_nosuccessors (oid, a_predecessor.oid)
			else
				sid := c_get_single_successor (a_predecessor.oid, oid)
				if sid = 0 then
					c_add_successor_first (a_predecessor.oid, oid, a_succ.oid)
				elseif sid /= a_succ.oid then
					c_remove_object (sid)
					c_add_successor_first (a_predecessor.oid, oid, a_succ.oid)
				end
			end
		end

	
end -- class MT_SINGLE_COMPOSITE_RELATIONSHIP
