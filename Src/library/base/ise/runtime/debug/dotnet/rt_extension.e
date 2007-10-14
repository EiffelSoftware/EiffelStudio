indexing
	description : "Eiffel class instanciated and used from the Eiffel runtime."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	RT_EXTENSION

inherit
	RT_EXTENSION_COMMON

	RT_EXTENSION_I

feature -- Notification

	notify (a_id: INTEGER; a_data: TUPLE) is
			-- Notify operation `a_id' with data `a_data'
		local
			retried: BOOLEAN
		do
			if not retried then
				debug ("RT_EXTENSION_TRACE")
					dtrace ("RT_EXTENSION.notify (" + a_id.out + ")%N")
				end
				inspect a_id
				when Op_enter_feature then
				when Op_leave_feature then
				when Op_exec_replay_record then
				when Op_exec_replay then
				when Op_exec_replay_query then
				when Op_object_storage_save then
					process_object_storage_save (object_storage_argument (a_data))
				when Op_object_storage_load then
					process_object_storage_load (object_storage_argument (a_data))
				else
					derror (out + " ->" + a_id.out + "%N")
				end
				debug ("RT_EXTENSION_TRACE")
					dtrace ("RT_EXTENSION.notify (" + a_id.out + ") -> DONE.%N")
				end
			end
		rescue
			derror ("Rescue -> RT_EXTENSION.notify (" + a_id.out + ")%N")
			retried := True
			retry
		end

	notify_argument (a_id: INTEGER): TUPLE is
			-- Empty argument container for operation `a_id'.
		local
			retried: BOOLEAN
		do
			if not retried then
				inspect a_id
				when Op_enter_feature, Op_leave_feature then
				when Op_exec_replay_record, Op_exec_replay, Op_exec_replay_query then
				when Op_object_storage_save, Op_object_storage_load then
					create {like object_storage_argument} Result
				else
				end
			end
		rescue
			derror ("Rescue -> RT_EXTENSION.notify_argument (" + a_id.out + ")%N")
			retried := True
			retry
		end

feature -- Direct Access

	saved_object_to (r: ANY; fn: STRING): ANY is
			-- Save object `r' into file `fn'
		local
			file: RAW_FILE
		do
			create file.make (fn)
			if not file.exists or else file.is_writable then
				file.create_read_write
				file.independent_store (r)
				file.close
				Result := r
			else
				Result := Void
			end
		end

	object_loaded_from (r: ANY; fn: STRING): ANY is
			-- Loaded object from file `fn'.
			-- if `r' is Void return a new object
			-- else load into `r'
			-- If failure then results Void object.
		local
			o1, o2: ANY
			file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				o1 := r
				create file.make (fn)
				if file.exists and then file.is_readable then
					file.open_read
					o2 := file.retrieved
					file.close
					if o1 /= Void then
						if o1.same_type (o2) then
							o1.standard_copy (o2)
							Result := o1
						else
							Result := Void
						end
					else
						Result := o2
					end
				else
					Result := Void
				end
			else
				Result := r
			end
		rescue
			retried := True
			retry
		end

feature -- Constants (check eif_debug.h uses the same values)

	Op_enter_feature: INTEGER = 1
	Op_leave_feature: INTEGER = 2

	Op_exec_replay_record: INTEGER = 3
	Op_exec_replay: INTEGER = 4
	Op_exec_replay_query: INTEGER = 5

	Op_object_storage_save: INTEGER = 6
	Op_object_storage_load: INTEGER = 7

feature {NONE} -- Object storage

	object_storage_argument (t: TUPLE): TUPLE [ref: ANY; fn: POINTER; succeed: BOOLEAN] is
			-- Argument for `process_object_storage_save' and `process_object_storage_load'.
		do
			Result ?= t
		end

	process_object_storage_save (t: like object_storage_argument) is
			-- Process the object saving for `t' data
		local
			fn: STRING
			b: BOOLEAN
		do
			create fn.make_from_c (t.fn)
			t.succeed := saved_object_to (t.ref, fn) /= Void
		end

	process_object_storage_load (t: like object_storage_argument) is
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
