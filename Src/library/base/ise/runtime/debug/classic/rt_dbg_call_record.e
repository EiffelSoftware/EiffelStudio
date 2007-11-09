indexing
	description: "Call record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_CALL_RECORD

inherit
	RT_DBG_COMMON

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (rec: like recorder; ref: ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Make as call `{cid}.fid' for object `ref' and depth `dep'
		do
			recorder := rec
			class_type_id := cid
			feature_rout_id := fid
			depth := dep
			object := ref
			is_expanded := object_is_expanded (object)
		end

	recorder: RT_DBG_EXECUTION_RECORDER
			-- Associated recorder.

feature -- Properties

	class_type_id: INTEGER
			-- Related class type id.

	feature_rout_id: INTEGER
			-- Related feature routine id.

	depth: INTEGER
			-- Call stack depth of Current's call

	object: ANY
			-- Target object.

	parent: like Current
			-- Parent's call record.

	call_records: ARRAYED_LIST [like Current]
			-- Sub call records.

	field_records: ARRAYED_LIST [RT_DBG_RECORD]
			-- Recorded fields from target `object'.			

	flat_field_records: ARRAYED_LIST [TUPLE [obj: ANY; rec: RT_DBG_RECORD]]

feature -- Status

	is_expanded: BOOLEAN
			-- Is `object' an expanded value ?

	is_flat: BOOLEAN
			-- Is Current record flat ?

feature {RT_DBG_EXECUTION_RECORDER, RT_DBG_CALL_RECORD} -- Change

	attach_to (p: like Current)
			-- Attach Current call record to parent call record `c'
		require
			not_in_parent_records: parent = Void or else parent.call_records = Void
					or else not parent.call_records.has (p)
		do
			parent := p
			parent.add_record (Current)
		ensure
			in_parent_records: parent.call_records.has (Current)
		end

	add_record (c: like Current)
			-- Add call record `c' to Current's sub call records
		require
			record_parented_to_current: c.parent = Current
			not_flat: not is_flat
		do
			if call_records = Void then
				create call_records.make (5)
			end
			call_records.extend (c)
		ensure
			in_records: call_records.has (c)
		end

	remove_parent
			-- Unattach from `parent' call record
		do
			parent := Void
		end

	record_fields
			-- Records fields of target `object'
		require
			object_not_void: object /= Void
			is_not_flat: not is_flat
		local
			rs: like field_records
		do
			if not is_expanded then
				rs := object_records (object)
				field_records := rs
			end

			debug ("RT_EXTENSION")
				if rs /= Void then
					dtrace_indent (depth); dtrace ("record_fields -> " + rs.count.out + " value(s).%N")
					rs.do_all (agent (r: RT_DBG_RECORD)
						do
							dtrace (" -> " + r.position.out + ") " + r.to_string + "%N")
						end)
				else
					dtrace_indent (depth); dtrace ("record_fields -> None.%N")
				end
			end
		end

	close
			-- Close current call
			-- It will discard useless records, and flatten sub calls' records.
		require
			object_not_void: object /= Void
		do
			flatten
			flat_optimize
		end

	flatten
			-- Flatten record fields structure
		require
			not_flat: not is_flat
		do
			if not is_flat then
				flat_field_records := changes_between (Current, Void)
				field_records := Void
				call_records := Void
				is_flat := True
			end
		ensure
			is_flat: is_flat
			no_field_records: field_records = Void
			no_records: call_records = Void
			flat_field_records_not_void: flat_field_records /= Void
		end

	flat_optimize
			-- Optimize the flatten records to discard useless records
		require
			is_flat: is_flat
		local
			ot: ARRAYED_LIST [ANY] -- indexed by `oi'
			ort: ARRAY [LIST [RT_DBG_RECORD]] -- indexed by `oi'
			orcds: LIST [RT_DBG_RECORD]
			ffrcds: like flat_field_records
			tr: TUPLE [obj: ANY; rec: RT_DBG_RECORD]
			o: ANY
			oi: INTEGER
			r: RT_DBG_RECORD
			b: BOOLEAN
			n: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				ffrcds := flat_field_records
				check ffrcds /= Void end
				n := 0
				if ffrcds.count > 1 then
					from
						create ot.make (10)
						create ort.make (1, ot.capacity - 1)
						ffrcds.start
					until
						ffrcds.after
					loop
						tr := ffrcds.item_for_iteration

						if o /= tr.obj then
							o := tr.obj
							ot.search (o)
							if not ot.exhausted then
								oi := ot.index
								orcds := ort.item (oi)
							else
								ot.extend (o)
								ot.finish
								oi := ot.index
								create {ARRAYED_LIST [RT_DBG_RECORD]} orcds.make (10)
								ort.force (orcds, oi)
							end
						--else-- use previous values (ie: index)
						end
						check
							oi > 0
							o /= Void
							orcds /= Void
						end
						r := tr.rec
						if orcds.is_empty then
							orcds.force (r)
						else
							from
								b := False
								orcds.finish
							until
								orcds.before or b
							loop
								b := orcds.item_for_iteration.position = r.position
								orcds.back
							end
							if not b then
									-- Add only if no other similar record exists
								orcds.force (r)
							else
								n := n + 1
							end
						end
						ffrcds.forth
					end
						--| rebuild flat_field_records
					ffrcds.wipe_out
					from
						ot.start
						oi := ot.index
					until
						ot.after
					loop
						oi := ot.index
						o := ot.item_for_iteration
						orcds := ort.item (oi)
						from
							orcds.start
						until
							orcds.after
						loop
							ffrcds.extend ([o, orcds.item_for_iteration])
							orcds.forth
						end
						ot.forth
					end
				end
				debug ("RT_EXTENSION")
					dtrace_indent (depth); dtrace ("flat_optimize : to " + ffrcds.count.out + " (-" + n.out + ")%N")
				end
				recorder.increment_records_count (-n)
			end
		rescue
			dtrace ("Error: flat_optimize : rescued%N")
			retried := True
			retry
		end

feature {RT_DBG_EXECUTION_RECORDER, RT_DBG_CALL_RECORD} -- Query

	field_records_count: INTEGER
			-- Count of `field_records'.
		local
			rcds: like field_records
		do
			rcds := field_records
			if rcds /= Void then
				Result := rcds.count
			end
		end

	record_count_but (c: like Current): INTEGER
			-- Number of records contained by Current and sub calls
			-- apart from the records contained by `c' (and sub calls)
		local
			r: like Current
			lst: like call_records
		do
			if is_flat then
				Result := flat_field_records.count
			else
				if field_records /= Void then
					Result := field_records.count
				end
				lst := call_records
				if lst /= Void then
					from
						lst.start
					until
						lst.after
					loop
						r := lst.item_for_iteration
						if r /= c then
							Result := Result + r.record_count_but (Void)
						end
						lst.forth
					end
				end
			end
		end

	bottom: like Current
			-- Bottom's call record.
		do
			if parent = Void then
				Result := Current
			else
				Result := parent.bottom
			end
		end

	available_calls_to_bottom: INTEGER
			-- Number of available calls to reach the bottom record.
		do
			if parent /= Void then
				Result := parent.available_calls_to_bottom
			end
			Result := Result + 1
		end

feature -- debug

	debug_output: STRING
			-- Debug output as string representation
		do
			if object /= Void then
				Result := "{" + object.generator + "}."
			else
				Result := "{_}."
			end

			if feature_name /= Void then
				Result.append (feature_name + " ")
			end
			Result.append (feature_rout_id.out + " <" + depth.out + ">")
			if is_flat then
				Result.append_character ('&')
			end
		end

	feature_name: STRING
			-- Optional feature name (for debugging purpose).

	set_feature_name (fn: like feature_name) is
			-- Set optional feature name
			-- (debugging purpose)
		do
			feature_name := fn
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
