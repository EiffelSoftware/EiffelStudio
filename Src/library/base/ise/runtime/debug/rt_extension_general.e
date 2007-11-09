indexing
	description: "Common routine for RT_EXTENSION classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_EXTENSION_GENERAL

inherit
	RT_EXTENSION_COMMON

feature -- RT extension identifiers (check eif_debug.h uses the same values)

	Op_enter_feature: 		INTEGER = 10
	Op_leave_feature: 		INTEGER = 11
	Op_rescue_feature: 		INTEGER = 13

	Op_exec_replay_record: 	INTEGER = 15
	Op_exec_replay: 		INTEGER = 16
	Op_exec_replay_query: 	INTEGER = 17

	Op_object_storage_save: INTEGER = 31
	Op_object_storage_load: INTEGER = 32

feature -- Object storage Access

	saved_object_to (r: ANY; fn: STRING): ANY
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

	object_loaded_from (r: ANY; fn: STRING): ANY
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
						if o2 /= Void and then o1.same_type (o2) then
							o1.standard_copy (o2)
							Result := o1
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
