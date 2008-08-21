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
		require
			an_id_non_negative: an_id >= 0
		local
			l_success: BOOLEAN
			wr: WEAK_REFERENCE
		do
			l_success := xyz_mutex.wait_one
			if xyz_reference_list.valid_index (an_id) then
				wr := xyz_reference_list.i_th (an_id)
				if wr /= Void then
					Result ?= wr.target
					if Result = Void then
							-- Object was collected, let's discard the weak reference object
						xyz_reference_list.put_i_th (Void, an_id)
					end
				end
			end
			xyz_mutex.release_mutex
		end

	eif_object_id (an_object: ANY): INTEGER is
			-- New identifier for `an_object'
		local
			l_success: BOOLEAN
		do
			l_success := xyz_mutex.wait_one
			xyz_reference_list.extend (create {WEAK_REFERENCE}.make_from_target (Current))
			Result := xyz_reference_list.count
			xyz_mutex.release_mutex
		ensure
			eif_object_id_positive: Result > 0
			inserted: eif_id_object (Result) = an_object
		end

	eif_object_id_free (an_id: INTEGER) is
			-- Free the entry `an_id'
		require
			an_id_non_negative: an_id >= 0
		local
			l_success: BOOLEAN
		do
			l_success := xyz_mutex.wait_one
			if xyz_reference_list.valid_index (an_id) then
				xyz_reference_list.put_i_th (Void, an_id)
			end
			xyz_mutex.release_mutex
		ensure
			removed: eif_id_object (an_id) = Void
		end

feature {IDENTIFIED_CONTROLLER} -- Implementation

	xyz_reference_list: ARRAYED_LIST [WEAK_REFERENCE] is
			-- List of weak references used. Id's correspond to indices in this list.
			-- Synchronization has to be done with `xyz_mutex'.
		indexing
			once_status: global
		once
			create Result.make (50)
		ensure
			xyz_reference_list_not_void: Result /= Void
		end

	xyz_mutex: SYSTEM_MUTEX is
			-- Mutex to protect access to global list `xyz_reference_list'.
		indexing
			once_status: global
		once
			create Result.make
		ensure
			xyz_mutex_not_void: Result /= Void
		end

end
