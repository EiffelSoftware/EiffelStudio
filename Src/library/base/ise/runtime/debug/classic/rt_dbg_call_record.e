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
			create steps.make (3)
		end

	recorder: !RT_DBG_EXECUTION_RECORDER
			-- Associated recorder.

feature -- Properties

	object: ANY
			-- Target object.

	dynamic_class_type_id: INTEGER
			-- Related dynamic class type id.
		local
			o: ANY
		do
			o := object
			if o /= Void then
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

	steps: !ARRAYED_LIST [BOOLEAN]
			-- Steps data
			--| True->value;False->call
			--| When not is_replaying, Cursor is always `after'
			--| When is_replaying, Cursor point to replayed position's step

	call_records: ?ARRAYED_LIST [!like Current]
			-- Sub call records.

	value_records: ?ARRAYED_LIST [RT_DBG_VALUE_RECORD]
			-- Recorded values (assignment...)

	flat_value_records_has_local: BOOLEAN
			-- Does `value_records' has local values ?
		require
			is_flat: is_flat
		local
			c: CURSOR
		do
			if {vals: like value_records} value_records then
				c := vals.cursor
				from
					vals.start
				until
					vals.after or Result
				loop
					Result := vals.item.is_local_record
					vals.forth
				end
				vals.go_to (c)
			end
		end

feature -- Measure

	rt_information_available: BOOLEAN
			-- Is Runtime information available for this call ?
			--| i.e: is this call in the main call stack

	last_position: !TUPLE [line: INTEGER; nested: INTEGER]
			-- Last position

feature -- Change

	wipe_out_value_records
			-- Wipe out value records
		local
			n: INTEGER
			vs: like value_records
		do
			vs := value_records
			if vs /= Void then
				n := n + vs.count
				value_records := Void
			end
			if object /= Void then
				n := n + 1
				object := Void
			end
			recorder.increment_records_count (-n)
		end

	set_breakable_info (v: like breakable_info)
			-- Set breakable_info
		do
			breakable_info := v
		end

	register_position (a_line, a_nested: INTEGER)
			-- Set last position
		require
			a_line_valid: a_line > 0
			a_nested_valid: a_nested >= 0
		do
			last_position.line := a_line
			last_position.nested := a_nested
			debug ("RT_DBG_RECORD")
				dtrace_indent (depth); dtrace ("BP_INFO (" + a_line.out + ", " + a_nested.out + ")%N")
			end
		end

feature -- Status

	is_expanded: BOOLEAN
			-- Is `object' an expanded value ?

	is_flat: BOOLEAN
			-- Is Current record flat ?

	is_closed: BOOLEAN
			-- Is Current record closed ?

	call_records_closed: BOOLEAN
			-- Is call_records entries closed ?
		require
			is_not_closed: not is_closed
		local
			curs: CURSOR
			c: !like Current
		do
			if {l_calls: like call_records} call_records and then l_calls.count > 0 then
				curs := l_calls.cursor
				from
					Result := True
					l_calls.finish
				until
					l_calls.before or not Result
				loop
					c := l_calls.item
					Result := c.is_closed
					l_calls.back
				end
				l_calls.go_to (curs)
			else
				Result := True
			end
		end

feature {RT_DBG_EXECUTION_RECORDER, RT_DBG_CALL_RECORD} -- Change

	attach_to (p: !like Current)
			-- Attach Current call record to parent call record `c'
		require
			not_in_parent_records: parent = Void or else parent.call_records = Void
					or else not parent.call_records.has (p)
		do
			parent := p
			p.add_call_record (Current)
			set_breakable_info (p.last_position.twin)
		ensure
			in_parent_records: {ot_p: like parent} parent and then {cr: like call_records} ot_p.call_records and then cr.has (Current)
		end

	add_call_record (c: !like Current)
			-- Add call record `c' to Current's sub call records
		require
			record_parented_to_current: c.parent = Current
			not_flat: not is_flat
			valid_records_cursor: value_records /= Void implies value_records.after
		local
			l_call_records: like call_records
		do
			l_call_records := call_records
			if l_call_records = Void then
				create l_call_records.make (5)
				call_records := l_call_records
			end
			l_call_records.force (c)
			l_call_records.finish
			l_call_records.move (+1) --| point `after' when not replaying
			register_call_step
			if depth = 0 then
				depth := c.depth - 1
			end
		ensure
			in_records: {cr: like call_records} call_records and then cr.has (c) and then cr.after
		end

	remove_parent
			-- Unattach from `parent' call record
		do
			parent := Void
		end

	add_value_record (v: !RT_DBG_VALUE_RECORD)
			-- Add value record
		require
			is_not_flat: not is_flat
			valid_records_cursor: value_records /= Void implies value_records.after
		local
			l_value_records: like value_records
		do
			l_value_records := value_records
			if l_value_records = Void then
				create l_value_records.make (5)
				value_records := l_value_records
			end
			v.set_breakable_info (last_position.twin)
			l_value_records.force (v)
			l_value_records.finish
			l_value_records.move (+1) --| point `after' when not replaying
			register_value_step
			recorder.increment_records_count (+1)
		ensure
			in_records: {vr: like value_records} value_records and then vr.has (v) and then vr.after
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

			debug ("RT_DBG_RECORD")
				if {ot_rs: like value_records} rs then
					dtrace_indent (depth); dtrace ("record_fields -> " + ot_rs.count.out + " value(s).%N")
					ot_rs.do_all (agent (r: RT_DBG_VALUE_RECORD)
						do
							if {ot_r: RT_DBG_VALUE_RECORD} r then
								dtrace (" -> " + ot_r.position.out + ") " + ot_r.to_string + "%N")
							end
						end)
				else
					dtrace_indent (depth); dtrace ("record_fields -> None.%N")
				end
			end
		end

	close_call_records
			-- Close sub calls
		require
			is_not_closed: not is_closed
		local
			curs: CURSOR
			c: !like Current
		do
			if {l_calls: like call_records} call_records and then l_calls.count > 0 then
				curs := l_calls.cursor
				from
					l_calls.finish
				until
					l_calls.before
				loop
					c := l_calls.item
					if not c.is_closed then
						c.deep_close
					end
					l_calls.back
				end
				l_calls.go_to (curs)
			end
		ensure
			call_records_closed: call_records_closed
		end

	close
			-- Close current call
			-- It will discard useless records, and flatten sub calls' records.
		require
			is_not_closed: not is_closed
			call_records_closed: call_records_closed
		do
				--| Make sure sub calls are also closed
			if recorder.flatten_when_closing then
				flatten_value_records
				optimize_flat_value_records
			end
			rt_information_available := False
			is_closed := True
		ensure
			is_closed: is_closed
		end

	deep_close
			-- Close current call and call_records entries
		require
			is_not_closed: not is_closed
		do
			close_call_records
			close
		ensure
			call_records_closed: call_records_closed
			is_closed: is_closed
		end

	deep_close_until (r: !like Current)
			-- Close Current, and all parent calls until call `r'
		require
			is_not_closed: not is_closed
			r_not_current: r /= Current
		local
			n: ?like Current
		do
			from
				deep_close
				n := parent
			until
				n = Void or n = r
			loop
				n.deep_close
				n := n.parent
			end
		end

	flatten_value_records
			-- Flatten value records structure
		require
			not_flat: not is_flat
		local
			n: INTEGER
		do
			debug ("RT_DBG_OPTIMIZATION")
				dtrace_indent (depth); dtrace ("flatten_value_records (depth=" + depth.out + ") -start-%N")
			end
			if value_records = Void then
				create value_records.make (0)
			end
			if {vals: like value_records} value_records then
				get_value_records_flattened_into (vals)
			end
			if not recorder.keep_calls_records then
				call_records := Void
			end

			is_flat := True
			debug ("RT_DBG_OPTIMIZATION")
				dtrace_indent (depth); dtrace ("flatten_value_records (depth=" + depth.out + ") -end-%N")
			end
		ensure
			is_flat: is_flat
			flat_value_records_not_void: value_records /= Void
			no_records: not recorder.keep_calls_records implies call_records = Void
		end

	get_value_records_flattened_into (vals: !like value_records) is
			-- Flatten record `rec'
			--| Note: all value records and object will be removed from sub call records.
		require
			rec_not_flat_if_current: is_flat implies value_records /= vals
		local
			vrecs: like value_records
			v: RT_DBG_VALUE_RECORD
			c: CURSOR
			n: INTEGER
		do
			vrecs := value_records
			if is_flat then
				check value_records_not_void_if_flat: vrecs /= Void end
				c := vrecs.cursor
				vals.append (vrecs)
				vrecs.go_to (c)
				n := vrecs.count
			else
				if vrecs /= Void then
					if vrecs = vals then --| i.e: rec = flattening call record
						-- Remove local records, since the stack won't be accessible anymore
						-- thus we won't be able to access those locals anymore
						from
							vals.start
						until
							vals.after
						loop
							v := vals.item
							if v = Void or else v.is_local_record then
								vals.remove
								n := n - 1
							else
								vals.forth
							end
						end
					else
						--| Should not occurs, but in case it is not a closed call record
						--| let's keep this code.
						c := vrecs.cursor
						from
							vrecs.start
						until
							vrecs.after
						loop
							v := vrecs.item
							if v /= Void and then not v.is_local_record then
								vals.extend (v)
								n := n + 1
							end
							vrecs.forth
						end
						vrecs.go_to (c)
					end
				end

				if {crecs: like call_records} call_records then
					c := crecs.cursor
					from
						crecs.start
					until
						crecs.after
					loop
						debug ("RT_DBG_WARNING")
							if not crecs.item_for_iteration.is_flat then
								print ("Rec not flat !!!! %N")
							end
						end
						crecs.item_for_iteration.get_value_records_flattened_into (vals)
						crecs.forth
					end
					crecs.go_to (c)
				end
			end

			if vals /= value_records then
				wipe_out_value_records
			else
				object := Void
				n := n - 1
			end
			recorder.increment_records_count (n)
		ensure
			flat_value_records_has_no_local: not flat_value_records_has_local
		end

	optimize_flat_value_records
			-- Optimize the flatten records to discard useless records
			--| Note: at this point, there should not be any locals
			--| since we don't keep them in flat mode (we can not restore them anyway)
		require
			is_flat: is_flat
		local
			ot: ARRAYED_LIST [ANY] -- indexed by `oi'
			ort: ARRAY [LIST [RT_DBG_VALUE_RECORD]] -- indexed by `oi'
			orcds: LIST [RT_DBG_VALUE_RECORD]
			rec: RT_DBG_VALUE_RECORD
			o: ANY
			oi: INTEGER
			b: BOOLEAN
			n: INTEGER
			retried: BOOLEAN
		do
			if not retried and then {vals: like value_records} value_records then
				n := 0
				if vals.count > 1 then
					from
						create ot.make (10)
						create ort.make (1, ot.capacity - 1)
						vals.start
					until
						vals.after
					loop
						rec := vals.item_for_iteration
						check is_not_local_record: not rec.is_local_record end
						if {rec_obj: ANY} rec.associated_object then
							if o /= rec_obj then
								o := rec_obj
								ot.search (o)
								if not ot.exhausted then
									oi := ot.index
									orcds := ort.item (oi)
								else
									ot.force (o)
									ot.finish
									oi := ot.index
									create {ARRAYED_LIST [RT_DBG_VALUE_RECORD]} orcds.make (10)
									if not ort.valid_index (oi) then
										ort.grow (oi + ort.count // 2)
									end
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

						vals.forth
					end

						--| rebuild flat_value_records
					vals.wipe_out
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
							vals.force (orcds.item_for_iteration)
							orcds.forth
						end
						ot.forth
					end
				end
				debug ("RT_DBG_OPTIMIZATION")
					dtrace_indent (depth); dtrace ("optimize_flat_value_records (depth=" + depth.out + "): to " + vals.count.out + " (-" + n.out + ")%N")
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
			p: CURSOR
		do
			if is_flat then
				if {ffr: like value_records} value_records then
					Result := ffr.count
				end
			else
				if {vrs: like value_records} value_records then
					Result := vrs.count
				end
				if {crs: like call_records} call_records then
					p := crs.cursor
					from
						crs.start
					until
						crs.after
					loop
						r := crs.item_for_iteration
						if r /= c then
							Result := Result + r.record_count_but (Void)
						end
						crs.forth
					end
					crs.go_to (p)
				end
			end
			if object /= Void then
				Result := Result + 1
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
			debug ("RT_DBG_REPLAY")
				dtrace_indent (depth); dtrace ("call_by_id (" + a_id + ")%N")
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
				else
					Result := r.call_by_id (sub_id)
				end
			end
			debug ("RT_DBG_REPLAY")
				dtrace_indent (depth); dtrace ("call_by_id (" + a_id + ") -> Result=")
				if Result = Void then
					dtrace ("Void")
				else
					dtrace (Result.to_string(0))
				end
				dtrace ("%N")
			end
		end

	associated_replayable_call: ?like Current
			-- Associated replayable call
		local
		do
			if rt_information_available then
				Result := Current
			elseif {p: like parent} parent then
				Result := p.associated_replayable_call
			end
		ensure
			Result_not_void: Result /= Void and then Result.rt_information_available
		end

	available_calls_to_bottom: INTEGER
			-- Number of available calls to reach the bottom record.
		do
			if {p: like parent} parent then
				Result := p.available_calls_to_bottom
			end
			Result := Result + 1
		end

	to_string (a_level: INTEGER): STRING is
			-- String representation of Current
		local
			subs: STRING
			l_steps: !like steps
			i: INTEGER
			val_cursor: CURSOR
			call_cursor: CURSOR
			c,v: INTEGER
			l_calls: like call_records
			l_values: like value_records
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
			if is_replaying and then {rbi: like replayed_position} replayed_position then
				Result.append_character ('.')
				Result.append_integer (rbi.line)  -- bp slot index
				Result.append_character ('.')
				Result.append_integer (rbi.nested) -- bp slot nested index
			end
			Result.append_character ('%T')
			if is_flat then
				Result.append_character ('#')
			end
			if not rt_information_available then
				Result.append_character ('?')
			end

				--| About records
			l_values := value_records
			l_calls := call_records
			c := 0
			v := 0
			if a_level /= 0 then
				l_steps := steps
				if l_steps.count > 0 and then {cursor: CURSOR} l_steps.cursor then
					create subs.make_empty
					from
						if l_values /= Void then
							val_cursor := l_values.cursor
							l_values.start
						end
						if l_calls /= Void then
							call_cursor := l_calls.cursor
							l_calls.start
						end
						i := l_steps.index
						l_steps.start
					until
						l_steps.after
					loop
						if l_steps.item then
							if False then --| Do not include assignments
								if l_values = Void then
									--| l_values can be Void if `is_flat' is True
								else
--| Keep comment, if ever we want to show in the debugger, one entry by assignment step.
--									if l_steps.index = i then
--										subs.append_character ('!')
--									end
									l_values.move (+1)
								end
							end
							v := v + 1
						else
							if l_calls = Void then
								--| l_calls can be Void if we don't keep call records on close
							else
								if l_steps.index = i then
									subs.append_character ('!')
								end
								subs.append_string (l_calls.item.to_string (a_level - 1))
								l_calls.move (+1)
							end
							c := c + 1
						end
						l_steps.forth
					end
					if val_cursor /= Void then
						l_values.go_to (val_cursor)
						check v = l_values.count end
					end
					if call_cursor /= Void then
						l_calls.go_to (call_cursor)
						check c = l_calls.count end
					end
					l_steps.go_to (cursor)
				end
			else
				if l_values /= Void then
					v := l_values.count
				end
				if l_calls /= Void then
					c := l_calls.count
				end
			end
			if c > 0 then
				Result.append_character ('+')
				Result.append_integer (c)
				Result.append_character ('(')
				if subs /= Void then
					Result.append_string (subs)
				end
				Result.append_character (')')
			end
			Result.append_character (']')
		end

feature {RT_DBG_EXECUTION_RECORDER} -- Steps

	is_replaying: BOOLEAN
			-- Is currently replaying ?
		do
			Result := recorder.is_replaying
		end

	replayed_position_is_first: BOOLEAN
			-- Replayed position is first
		require
			is_replaying: is_replaying
		do
			Result := steps.isfirst or steps.before
		end

	replayed_position: ?like last_position
			-- Replayed position
		require
			is_replaying: is_replaying
		local
			l_steps: !like steps
		do
			l_steps := steps
			if l_steps.after then
				Result := last_position --|i.e: not replayed
			elseif l_steps.before then
				Result := [0, 0]
			else
				if l_steps.item then
					Result := value_records.item.breakable_info
				else
					Result := call_records.item.breakable_info
				end
			end
		end

	left_step: ARRAYED_LIST [RT_DBG_VALUE_RECORD]
			-- Record between current and previous step
			--| also move replayed cursors
		require
			is_replaying: is_replaying
		local
			l_steps: !like steps
		do
			l_steps := steps
			debug ("RT_DBG_REPLAY")
				debug_display_steps
			end
			l_steps.move (-1) --| Note: if it was already `before', then it will remains `before'

			debug ("RT_DBG_REPLAY")
				dtrace_indent (depth); dtrace ("left_step -> ")
				dtrace ("["+ l_steps.index.out +"/"+ l_steps.count.out +"]: ")
			end
			if not l_steps.before then
				if l_steps.item then --| Value
					value_records.move (-1)
					create Result.make (1)
					check value_records /= Void and then not value_records.before end
					Result.force (value_records.item)
					debug ("RT_DBG_REPLAY")
						dtrace ("VALUE ")
						dtrace (value_records.index.out + "/" + value_records.count.out )
					end
				else --| call
					call_records.move (-1)
					debug ("RT_DBG_REPLAY")
						dtrace ("CALL ")
						dtrace (call_records.index.out + "/" + call_records.count.out )
					end
					check call_records /= Void and then not call_records.before end
					Result := changes_between (call_records.item, Void)
				end
			end
			debug ("RT_DBG_REPLAY")
				if Result = Void then
					dtrace ("=> Void %N")
				else
					dtrace ("=> " + Result.count.out + " %N")
				end
			end
		end

	revert_left_step
			-- Revert previous left step
		require
			is_replaying: is_replaying
			steps_not_after: not steps.after
		local
			l_steps: !like steps
		do
			l_steps := steps
			debug ("RT_DBG_REPLAY")
				dtrace_indent (depth); dtrace ("revert_left_step -start-%N")
				debug_display_steps
			end
			if l_steps.before then
				l_steps.move (+1) --| Revert the step left which was acted as step back
			else
				if not l_steps.after then
					if l_steps.item then
						check value_records /= Void and then not value_records.after end
						value_records.move (+1)
					else
						check call_records /= Void and then not call_records.after end
						call_records.move (+1)
					end
				end
				l_steps.move (+1)
			end
			debug ("RT_DBG_REPLAY")
				dtrace_indent (depth); dtrace ("revert_left_step -end-%N")
			end
		ensure
			steps.after implies (call_records /= Void implies call_records.after) and
							(value_records /= Void  implies value_records.after)
		end

feature {NONE} -- Steps implementation

	register_call_step
			-- Register a call step
		require
			not_is_flat: not is_flat
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (depth); dtrace (depth.out + " -> register_call_step @" + last_position.line.out + " %N")
			end
			register_step (False)
		ensure
			steps_is_after: steps.after
		end

	register_value_step
			-- Register a value step
		require
			not_is_flat: not is_flat
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (depth); dtrace (depth.out + " -> register_value_step @" + last_position.line.out + " %N")
			end
			register_step (True)
		ensure
			steps_is_after: steps.after
		end

	register_step (b: BOOLEAN)
			-- Register a step
			--| b=True : value step (assignment)
			--| b=False: call step
		require
			not_is_flat: not is_flat
		local
			l_steps: like steps
		do
			l_steps := steps
			l_steps.force (b)
			l_steps.finish
			l_steps.move (+1)
		ensure
			steps_is_after: steps.after
		end

feature -- debug

	debug_display_steps
			-- Display `steps' for debugging purpose
		local
			l_steps: like steps
			i: INTEGER
			v,c: INTEGER
			val_cursor: CURSOR
			call_cursor: CURSOR
			l_values: like value_records
			l_calls: like call_records
		do
			l_steps := steps
			l_values := value_records
			l_calls := call_records
			if {cursor: CURSOR} l_steps.cursor then
				from
					i := l_steps.index
					v := 0
					c := 0
					l_steps.start

					print ("steps: " + i.out + " out of " + l_steps.count.out + "%N")
					if l_values /= Void then
						val_cursor := l_values.cursor
						print ("%Tvalues: " + l_values.index.out + " out of " + l_values.count.out + "%N")
						l_values.start
					else
						print ("%Tvalues: None %N")
					end
					if l_calls /= Void then
						call_cursor := l_calls.cursor
						print ("%Tcalls: " + l_calls.index.out + " out of " + l_calls.count.out + "%N")
						l_calls.start
					else
						print ("%Tcalls: None %N")
					end
				until
					l_steps.after
				loop
					print ("%T" + l_steps.index.out + "=" )
					if l_steps.item then
						v := v + 1
						print ("VALUE#" + v.out + ": ")
						if l_values = Void then
							print ("None")
						else
							print (l_values.item.to_string)
							l_values.move (+1)
						end
					else
						c := c + 1
						print ("CALL#" + c.out + ": ")
						if l_calls = Void then
							print ("None")
						else
							print (l_calls.item.to_string (0))
							l_calls.move (+1)
						end
					end
					if i = l_steps.index then
						print (" <- ")
					end
					print ("%N")
					l_steps.forth
				end
				if val_cursor /= Void then
					l_values.go_to (val_cursor)
				end
				if call_cursor /= Void then
					l_calls.go_to (call_cursor)
				end
				l_steps.go_to (cursor)
			end
		end

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
				Result.append_string (" -> ERROR Dtype(obj):" + rt_dynamic_type (obj).out + " /= " + class_type_id.out)
			end
		end

invariant
	non_empty_call_records: call_records /= Void implies call_records.count > 0

	value_records_not_void_if_flat: is_flat implies value_records /= Void

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
