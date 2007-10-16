indexing

	description: "Objects identified, uniquely during any session, by an integer"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class IDENTIFIED_ROUTINES

feature -- Basic operations

	eif_id_object (an_id: INTEGER): ANY is
			-- Object associated with `an_id'
		local
			wr: WEAK_REFERENCE
		do
			if reference_list.valid_index (an_id) then
				wr := reference_list.i_th (an_id)
				if wr /= Void then
					Result ?= wr.target
				end
			end
		end

	eif_object_id (an_object: ANY): INTEGER is
			-- New identifier for `an_object'
		do
			reference_list.extend (create {WEAK_REFERENCE}.make_from_target (Current))
			Result := reference_list.count
		end

	eif_object_id_free (an_id: INTEGER) is
			-- Free the entry `an_id'
		do
			if reference_list.valid_index (an_id) then
				reference_list.put_i_th (Void, an_id)
			end
		end

feature {NONE} -- Implementation

	reference_list: ARRAYED_LIST [WEAK_REFERENCE] is
			-- List of weak references used. Id's correspond to indices in this list.
		once
			create Result.make (50)
		end

end
