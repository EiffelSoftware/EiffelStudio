indexing
	description: "Callstack record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_CALLSTACK_RECORD

inherit
	RT_DBG_COMMON

	DEBUG_OUTPUT

create
	make,
	make_root

feature {NONE} -- Initialization

	make_root (rec: like recorder) is
			-- Make as a root record
		do
			recorder := rec
			depth := 0
		end

	make (rec: like recorder; ref: ANY; cid,fid: INTEGER; dep: INTEGER) is
			-- Make as callstack `{cid}.fid' for object `ref' and depth `dep'
		do
			recorder := rec
			class_type_id := cid
			feature_rout_id := fid
			depth := dep
			object := ref
		end

	recorder: RT_DBG_EXECUTION_RECORDER
			-- Associated recorder

feature -- Recording

	record_fields is
		require
			object_not_void: object /= Void
		local
			rs: like field_records
		do
			rs := object_records (object)
			field_records := rs
--			if rs /= Void and then not rs.is_empty then
--				recorder.increment_records_count (rs.count)
--			end

			debug ("RT_EXTENSION_TRACE")
				if rs /= Void then
					dtrace ("record_fields -> " + rs.count.out + " value(s).%N")
					rs.do_all (agent (r: RT_DBG_RECORD)
						do
							dtrace (" -> " + r.position.out + ") " + r.to_string + "%N")
						end)
				else
					dtrace ("record_fields -> None.%N")
				end
			end
		end

	close is
		require
			object_not_void: object /= Void

		do
			debug ("RT_EXTENSION_TRACE")
				dtrace ("close ...%N")
			end
			flatten
			flat_optimize
		end

	flat_optimize is
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

				debug ("RT_EXTENSION_TRACE")
					dtrace ("flat_optimize : from " + ffrcds.count.out + "%N")
				end
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
						debug ("RT_EXTENSION_TRACE")
							dtrace ("flat_optimize (" + ffrcds.index.out + ") "
									+ tr.obj.generator
									+ tr.rec.debug_output + "%N")
						end
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
						debug ("RT_EXTENSION_TRACE")
							dtrace ("OPT: " + o.generator + " <" + ($o).out + "> (#" + orcds.count.out + ") %N")
						end
						from
							orcds.start
						until
							orcds.after
						loop
							debug ("RT_EXTENSION_TRACE")
								dtrace ("OPT: %T->" + orcds.item_for_iteration.position.out + " = " + orcds.item_for_iteration.to_string + "%N")
							end
							ffrcds.extend ([o, orcds.item_for_iteration])
							orcds.forth
						end
						ot.forth
					end
				end
				debug ("RT_EXTENSION_TRACE")
					dtrace ("flat_optimize : to " + ffrcds.count.out + " (-" + n.out + ")%N")
				end
				recorder.increment_records_count (-n)
			end
		rescue
			derror ("flat_optimize : rescued%N")
			retried := True
			retry
		end

feature -- Access

	call_records: ARRAYED_LIST [like Current]

	field_records: ARRAYED_LIST [RT_DBG_RECORD]

	parent: like Current

	record_count_but (c: like Current): INTEGER is
			--
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

feature -- Properties

	class_type_id: INTEGER

	feature_rout_id: INTEGER

	depth: INTEGER

	object: ANY

feature -- Status

	is_flat: BOOLEAN

feature -- debug

	debug_output: STRING is
			-- Debug output
		do
			Result := to_string
		end

	to_string: STRING is
			-- String representation
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

feature -- Queries

	flat_field_records: ARRAYED_LIST [TUPLE [obj: ANY; rec: RT_DBG_RECORD]]

	root: like Current is
			--
		do
			if parent = Void then
				Result := Current
			else
				Result := parent.root
			end
		end

	available_calls_to_bottom: INTEGER is
		do
			if parent /= Void then
				Result := parent.available_calls_to_bottom
			end
			Result := Result + 1
			debug ("RT_EXTENSION")
				dtrace ("available_calls_to_root (" + to_string + ") -> " + Result.out + "%N")
			end
		end

feature -- Change

	flatten is
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

	attach_to (c: like Current) is
		require
			not_in_parent_records: parent = Void or else parent.call_records = Void
					or else not parent.call_records.has (c)
		do
			parent := c
			parent.add_record (Current)
		ensure
			in_parent_records: parent.call_records.has (Current)
		end

	add_record (r: like Current) is
		require
			record_parented_to_current: r.parent = Current
			not_flat: not is_flat
		do
			if call_records = Void then
				create call_records.make (5)
			end
			call_records.extend (r)
		ensure
			in_records: call_records.has (r)
		end

	remove_parent is
			--
		do
			parent := Void
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
