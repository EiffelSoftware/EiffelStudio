indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OBJECT_ID_MANAGER

feature -- Access

	frozen eif_object_id (an_object: ANY): INTEGER is
			-- Unique for current object in any given session
		do
			reference_list.extend (
				create {CLI_CELL [WEAK_REFERENCE]}.put (create {WEAK_REFERENCE}.make (an_object)))
			Result := reference_list.count
		end

	frozen eif_id_object (an_id: INTEGER): ANY is
			-- Object associated with `an_id' (void if no such object)
		local
			wr: WEAK_REFERENCE
		do
			if reference_list.valid_index (an_id) then
				wr := reference_list.i_th (an_id).item
				if wr /= Void then
					Result ?= wr.get_target
				end
			end
		end

feature -- Removal

	frozen eif_object_id_free (an_id: INTEGER) is
			-- Free the entry associated with `object_id' if any
			--| the `object_id' is not reset because of uniqueness:
			--| another call shouldn't give a new id
		do
			if reference_list.valid_index (an_id) then
				reference_list.put_i_th (Void, an_id)
			end
		end

feature {IDENTIFIED_CONTROLLER} -- Implementation

	reference_list: ARRAYED_LIST [CLI_CELL [WEAK_REFERENCE]] is
			-- List of weak references used. Id's correspond to indices in this list.
		once
			create Result.make (50)
		end

end -- class WEL_IDENTIFIED

