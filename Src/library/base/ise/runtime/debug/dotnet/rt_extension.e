indexing
	description : "Eiffel class instanciated and used from the Eiffel runtime."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	RT_EXTENSION

inherit
	RT_EXTENSION_GENERAL

	RT_EXTENSION_I

feature -- Notification

	notify (a_id: INTEGER; a_data: TUPLE)
			-- Notify operation `a_id' with data `a_data'
		local
			retried: BOOLEAN
		do
			if not retried then
				inspect a_id
				when Op_enter_feature,
					 Op_leave_feature,
					 Op_exec_replay_record,
					 Op_exec_replay,
					 Op_exec_replay_query
				then
					-- Not yet implemented on dotnet platform
				when Op_object_storage_save then
					process_object_storage_save (object_storage_argument (a_data))
				when Op_object_storage_load then
					process_object_storage_load (object_storage_argument (a_data))
				else
					debug ("RT_EXTENSION")
						dtrace ("Error: " + out + " ->" + a_id.out + "%N")
					end
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify (" + a_id.out + ")%N")
			end
			retried := True
			retry
		end

	notify_argument (a_id: INTEGER): TUPLE
			-- Empty argument container for operation `a_id'.
		local
			retried: BOOLEAN
		do
			if not retried then
				inspect a_id
				when Op_enter_feature, Op_leave_feature, Op_rescue_feature,
					 Op_exec_replay_record, Op_exec_replay, Op_exec_replay_query
				then
					-- Not yet implemented on dotnet platform
				when Op_object_storage_save, Op_object_storage_load then
					create {like object_storage_argument} Result
				else
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify_argument (" + a_id.out + ")%N")
			end
			retried := True
			retry
		end


feature {NONE} -- Object storage

	object_storage_argument (t: TUPLE): TUPLE [ref: ANY; fn: POINTER; succeed: BOOLEAN]
			-- Argument for `process_object_storage_save' and `process_object_storage_load'.
		do
			Result ?= t
		end

	process_object_storage_save (t: like object_storage_argument)
			-- Process the object saving for `t' data
		local
			fn: STRING
		do
			create fn.make_from_c (t.fn)
			t.succeed := saved_object_to (t.ref, fn) /= Void
		end

	process_object_storage_load (t: like object_storage_argument)
			-- Process the object loading for `t' data
		local
			obj: ANY
			fn: STRING
		do
			create fn.make_from_c (t.fn)
			obj := object_loaded_from (t.ref, fn)
			t.succeed := obj /= Void
			t.ref := obj
		end

invariant
	no_attribute: (create {INTERNAL}).field_count (Current) = 0
			-- Since this object is shared among threads,
			-- it is better to avoid any attribute conflict

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
