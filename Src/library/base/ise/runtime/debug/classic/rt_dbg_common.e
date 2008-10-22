indexing
	description: "Common routine for RT_DBG_ classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_COMMON

inherit
	RT_EXTENSION_COMMON

feature -- Query

	changes_between (csr1: RT_DBG_CALL_RECORD; csr2: ?RT_DBG_CALL_RECORD): ?ARRAYED_LIST [RT_DBG_VALUE_RECORD] is
			-- Return records from `r1' to -beginning-of- `r2'.
		require
			csr1_not_void: csr1 /= Void
		local
			chgs: like changes_between
			c,v: CURSOR
		do
			if csr1.is_flat then
				Result := csr1.value_records
			else
				create Result.make (30)
					--| Get Full records
				if {vrecs: LIST [RT_DBG_VALUE_RECORD]} csr1.value_records then
					v := vrecs.cursor
					Result.append (vrecs)
					vrecs.go_to (v)
				end
				if {crecs: LIST [RT_DBG_CALL_RECORD]} csr1.call_records then
					c := crecs.cursor
					from
						crecs.start
					until
						crecs.after or crecs.item_for_iteration = csr2
					loop
						chgs := changes_between (crecs.item_for_iteration, csr2)
						if chgs /= Void then
							Result.append (chgs)
						end
						crecs.forth
					end
					crecs.go_to (c)
				end
			end
		ensure
			result_not_void: Result /= Void
		end


indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
