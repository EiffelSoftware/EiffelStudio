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
				create {CLI_CELL [WEAK_REFERENCE]}.put (create {WEAK_REFERENCE}.make_from_target (an_object)))
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
					Result ?= wr.target
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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

