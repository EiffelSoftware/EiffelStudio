indexing
	description: "Call record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_CALL_RECORD

inherit
	DEBUG_OUTPUT

	RT_DBG_INTERNAL
		export
			{NONE} all
		end

	RT_DBG_COMMON
		export
			{NONE} all
		end

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
			if object /= Void then
				is_expanded := object_is_expanded (object)
			end
			last_position := [0, 0]
			rt_information_available := True
		end

	recorder: RT_DBG_EXECUTION_RECORDER
			-- Associated recorder.

feature -- Properties

	object: ANY
			-- Target object.

	dynamic_class_type_id: INTEGER
			-- Related dynamic class type id.
		do
			if {o: ANY} object then
				Result := rt_dynamic_type (o) --class_type_id
			end
		end

	class_type_id: INTEGER
			-- Related written class type id.

	feature_rout_id: INTEGER
			-- Related feature routine id.

	breakable_info: ?TUPLE [line: INTEGER; nested: INTEGER]
			-- Breakable info when call occurred.

	depth: INTEGER
			-- Call stack depth of Current's call

	parent: ?like Current
			-- Parent's call record.

	call_records: ?ARRAYED_LIST [!like Current]
			-- Sub call records.

	value_records: ?ARRAYED_LIST [RT_DBG_RECORD]
			-- Recorded values (assignment...)

	flat_value_records: ?ARRAYED_LIST [RT_DBG_RECORD]
			-- Flat value records list

feature -- Measure

	rt_information_available: BOOLEAN
			-- Is Runtime information available for this call ?
			--| i.e: is this call in the main call stack

	last_position: !TUPLE [line: INTEGER; nested: INTEGER]
			-- Last position

	replayed_position: ?TUPLE [line: INTEGER; nested: INTEGER]
			-- Replayer position
			-- if Void, let's use `last_breakable_info'

feature -- Change

	wipe_out_value_records
			-- Wipe out value records
		do
			value_records := Void
			flat_value_records := Void
		end

	notify_breakable_info (a_line, a_nested: INTEGER)
			-- Set last position
		require
			a_line_valid: a_line > 0
			a_nested_valid: a_nested >= 0
		do
			last_position.line := a_line
			last_position.nested := a_nested
			debug ("RT_EXTENSION")
				dtrace_indent (depth); dtrace ("BP_INFO (" + a_line.out + ", " + a_nested.out + ")")
				if feature_name /= Void then
					dtrace (" - " + feature_name)
				end
				dtrace ("%N")
			end
		end

feature -- Status

	is_expanded: BOOLEAN
			-- Is `object' an expanded value ?

	is_flat: BOOLEAN
			-- Is Current record flat ?

feature {RT_DBG_EXECUTION_RECORDER, RT_DBG_CALL_RECORD} -- Change

	attach_to (p: !like Current)
			-- Attach Current call record to parent call record `c'
		require
			not_in_parent_records: parent = Void or else parent.call_records = Void
					or else not parent.call_records.has (p)
		do
			parent := p
			p.add_record (Current)
			breakable_info := p.last_position.twin
		ensure
			in_parent_records: {ot_p: like parent} parent and then {cr: like call_records} ot_p.call_records and then cr.has (Current)
		end

	add_record (c: !like Current)
			-- Add call record `c' to Current's sub call records
		require
			record_parented_to_current: c.parent = Current
			not_flat: not is_flat
		local
			l_call_records: like call_records
		do
			l_call_records := call_records
			if l_call_records = Void then
				create l_call_records.make (5)
				call_records := l_call_records
			end
			l_call_records.extend (c)
		ensure
			in_records: {cr: like call_records} call_records and then cr.has (c)
		end

	remove_parent
			-- Unattach from `parent' call record
		do
			parent := Void
		end

	add_value_record (rec: !RT_DBG_RECORD)
			-- Add value record
		require
			is_not_flat: not is_flat
		do
			if value_records = Void then
				create value_records.make (10)
			end
			value_records.force (rec)
			recorder.increment_records_count (1)
		end

	record_fields
			-- Records fields of target `object'
		require
			object_not_void: object /= Void
			is_not_flat: not is_flat
		local
			rs: like value_records
		do
			if not is_expanded then
				if {o: like object} object then
					rs := object_records (o)
				end
				value_records := rs
			end

			debug ("RT_EXTENSION")
				if {ot_rs: like value_records} rs then
					dtrace_indent (depth); dtrace ("record_fields -> " + ot_rs.count.out + " value(s).%N")
					ot_rs.do_all (agent (r: RT_DBG_RECORD)
						do
							if {ot_r: RT_DBG_RECORD} r then
								dtrace (" -> " + ot_r.position.out + ") " + ot_r.to_string + "%N")
							end
						end)
				else
					dtrace_indent (depth); dtrace ("record_fields -> None.%N")
				end
			end
		end

	close
			-- Close current call
			-- It will discard useless records, and flatten sub calls' records.
		do
			if recorder.flatten_when_closing then
				wipe_out_local_records
				flatten_value_records
				optimize_flat_value_records
			end
			rt_information_available := False
		end

	wipe_out_local_records
			-- Remove local records, since we leave the stack
			-- we won't be able to access those locals anymore
		do
			if not is_flat and then {vrecs: like value_records} value_records then
				from
					vrecs.start
				until
					vrecs.after
				loop
					if vrecs.item.is_local_record then
						vrecs.remove
					else
						vrecs.forth
					end
				end
			end
		end

	flatten_value_records
			-- Flatten value records structure
		require
			not_flat: not is_flat
		do
			if not is_flat then
				flat_value_records := changes_between (Current, Void, True)
				value_records := Void
				if not recorder.keep_calls_records then
					call_records := Void
				end
				is_flat := True
			end
		ensure
			is_flat: is_flat
			no_value_records: value_records = Void
			flat_value_records_not_void: flat_value_records /= Void
			no_records: not recorder.keep_calls_records implies call_records = Void
		end

	optimize_flat_value_records
			-- Optimize the flatten records to discard useless records
		require
			is_flat: is_flat
		local
			ot: ARRAYED_LIST [ANY] -- indexed by `oi'
			ort: ARRAY [LIST [RT_DBG_RECORD]] -- indexed by `oi'
			orcds: LIST [RT_DBG_RECORD]
			rec: RT_DBG_RECORD
			o: ANY
			oi: INTEGER
			b: BOOLEAN
			n: INTEGER
			retried: BOOLEAN
		do
			if not retried and then {ffrcds: like flat_value_records} flat_value_records then
				n := 0
				if ffrcds.count > 1 then
					from
						create ot.make (10)
						create ort.make (1, ot.capacity - 1)
						ffrcds.start
					until
						ffrcds.after
					loop
						rec := ffrcds.item_for_iteration
						if {rec_obj: ANY} rec.associated_object then
							if o /= rec_obj then
								o := rec_obj
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
							if orcds.is_empty then
								orcds.force (rec)
							else
								from
									b := False
									orcds.finish
								until
									orcds.before or b
								loop
									b := orcds.item_for_iteration.position = rec.position
									orcds.back
								end
								if not b then
										-- Add only if no other similar record exists
									orcds.force (rec)
								else
									n := n + 1
								end
							end
						else
							--| this is not an attribute(or field) record
							--| thus forget about them, not kept for optimized flat fields
						end

						ffrcds.forth
					end

						--| rebuild flat_value_records
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
							ffrcds.extend (orcds.item_for_iteration)
							orcds.forth
						end
						ot.forth
					end
				end
				debug ("RT_EXTENSION")
					dtrace_indent (depth); dtrace ("optimize_flat_field_records : to " + ffrcds.count.out + " (-" + n.out + ")%N")
				end
				recorder.increment_records_count (-n)
			end
		rescue
			dtrace ("Error: optimize_flat_field_records : rescued%N")
			retried := True
			retry
		end

feature {RT_DBG_EXECUTION_RECORDER, RT_DBG_CALL_RECORD} -- Query

	record_count_but (c: ?like Current): INTEGER
			-- Number of records contained by Current and sub calls
			-- apart from the records contained by `c' (and sub calls)
		local
			r: !like Current
		do
			if is_flat then
				if {ffr: like flat_value_records} flat_value_records then
					Result := ffr.count
				end
			else
				if {fr: like value_records} value_records then
					Result := fr.count
				end
				if {lst: like call_records} call_records then
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
			Result := Current
			if {p: like parent} parent then
				Result := p.bottom
			end
		end

	call_by_id (a_id: STRING): like Current
		require
			a_id_not_empty: a_id.count > 0
		local
			p: INTEGER
			i: INTEGER
			r: !like Current
			sub_id: STRING
		do
			debug ("RT_EXTENSION")
				print ("query call by id ["+a_id+"]%N")
			end
			p := a_id.index_of ('.', 1)
			if p > 0 then
				sub_id := a_id.substring (p + 1, a_id.count)
				i := a_id.substring (1, p-1).to_integer_32
			else
				i := a_id.to_integer_32
			end
			if call_records.valid_index (i) then
				r := call_records.i_th (i)
				if sub_id = Void then
					Result := r
				else --if r /= Void then
					Result := r.call_by_id (sub_id)
				end
			end
		end

	available_calls_to_bottom: INTEGER
			-- Number of available calls to reach the bottom record.
		do
			if {p: like parent} parent then
				Result := p.available_calls_to_bottom
			end
			Result := Result + 1
		end

	calls_as_string: STRING is
			-- String representation of Current
		do
			Result := to_string (-1)
		end

	to_string (a_level: INTEGER): STRING is
			-- String representation of Current
		do
			create Result.make (5)
			Result.append_character ('[')
			Result.append_integer (depth)
			Result.append_character ('.')
			Result.append_integer (rt_reverse_updated_dynamic_type (dynamic_class_type_id))
			Result.append_character ('.')
			Result.append_integer (rt_reverse_updated_dynamic_type (class_type_id))
			Result.append_character ('.')
			Result.append_integer (feature_rout_id)
			Result.append_character ('.')
			if {bi: like breakable_info} breakable_info then
				Result.append_integer (bi.line)  -- bp slot index
				Result.append_character ('.')
				Result.append_integer (bi.nested) -- bp slot nested index
			else
				Result.append_integer (0) -- bp slot index
				Result.append_character ('.')
				Result.append_integer (0) -- bp slot nested index
			end
			Result.append_character ('%T')
			if is_flat then
				Result.append_character ('#')
			end
			if not rt_information_available then
				Result.append_character ('?')
			end
			if {cr: like call_records} call_records then
				Result.append_character ('+')
				Result.append_integer (cr.count)
				Result.append_character ('(')
				if a_level /= 0 then
					from
						cr.start
					until
						cr.after
					loop
						Result.append_string (cr.item.to_string (a_level - 1))
--						if {cri: RT_DBG_CALL_RECORD} cr.item then
--							Result.append_string (cri.to_string (a_level - 1))
--						end
						cr.forth
					end
				end
				Result.append_character (')')
			end
			Result.append_character (']')
		end

feature -- debug

	debug_output: STRING
			-- Debug output as string representation
		local
			tn: STRING
		do
			tn := type_name_of_type (class_type_id)
			if {o: like object} object and then {otn: STRING} o.generating_type then
				if tn = Void or else not otn.is_equal (tn) then
					if tn /= Void then
						tn := otn + " from " + tn
					else
						tn := otn
					end
				end
			end
			if tn = Void then
				tn := "_"
			end

			Result := "{" + tn + "}."
			if {fn: like feature_name} feature_name then
				Result.append (fn + " ")
			end
			Result.append (feature_rout_id.out + " <" + depth.out + ">")
			if {bi: like breakable_info} breakable_info then
				Result.append_character (' ')
				Result.append_character ('(')
				Result.append_integer (bi.line)  -- bp slot index
				Result.append_character (',')
				Result.append_integer (bi.nested) -- bp slot nested index
				Result.append_character (')')
				Result.append_character (' ')
			end
			if is_flat then
				Result.append_character ('&')
			end

			if {obj: like object} object and then rt_dynamic_type (obj) /= class_type_id then
				Result.append_string (" -> ERROR Dtype(obj) /= " + class_type_id.out)
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

invariant
--	last_breakable_info_not_void: last_breakable_info /= Void

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
