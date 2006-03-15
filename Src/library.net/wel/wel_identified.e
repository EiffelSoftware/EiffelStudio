indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDENTIFIED

inherit
	IDENTIFIED_CONTROLLER
		export
			{NONE} object_id_stack_size, extend_object_id_stack
		end
		
feature {NONE} - Access

	frozen eif_object_id (an_object: ANY): INTEGER is
			-- Unique for current object in any given session
		do
			reference_list.extend (create {WEAK_REFERENCE}.make_from_target (an_object))
			Result := reference_list.count
		end

	frozen eif_id_object (an_id: INTEGER): WEL_WINDOW is
			-- Object associated with `an_id' (void if no such object)
		do
			Result ?= eif_id_system_object (an_id)
		end

	frozen eif_id_any_object (an_id: INTEGER): ANY is
			-- Object associated with `an_id' (void if no such object)
		do
			Result ?= eif_id_system_object (an_id)
		end

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

	reference_list: ARRAYED_LIST [WEAK_REFERENCE] is
			-- List of weak references used. Id's correspond to indices in this list.
		once
				-- Reuse `list' from IDENTIFIED to preserve classic behavior where
				-- IDs used by IDENTIFIED and WEL_IDENTIFIED are shared.
			Result := (create {IDENTIFIED}).reference_list
		end

feature {NONE} -- Implementation

	frozen eif_id_system_object (an_id: INTEGER): SYSTEM_OBJECT is
			-- Object associated with `an_id' (void if no such object)
		local
			wr: WEAK_REFERENCE
		do
			if reference_list.valid_index (an_id) then
				wr := reference_list.i_th (an_id)
				if wr /= Void then
					Result := wr.target
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class WEL_IDENTIFIED

