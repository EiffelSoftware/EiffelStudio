note
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_LOCAL_RECORD [G -> detachable ANY]

inherit
	RT_DBG_VALUE_RECORD
		redefine
			debug_output
		end

create
	make

feature {NONE} -- Initialization

	make (dep, pos, eif_t: INTEGER; t: like rt_type)
			-- Make local record with index `i', type `t' an value `v'
		do
			callstack_depth := dep
			position := pos
			type := eif_t
			rt_type := t
		end

feature -- RT internals

	frozen local_value_at (dep: INTEGER; pos: INTEGER; a_rt_type: like rt_type): detachable ANY
			-- Object attached at local position `pos' for depth `dep'
			-- (directly or through a reference)
		require
			index_large_enough: pos >= 0
		local
			a_loc_type: INTEGER
		do
			if pos = 0 then
				a_loc_type := {RT_DBG_INTERNAL}.rt_DLT_RESULT
			else
				a_loc_type := {RT_DBG_INTERNAL}.rt_DLT_LOCALVAR
			end
			if a_loc_type /= {RT_DBG_INTERNAL}.rt_DLT_RESULT then
				-- FIXME: maybe handle the Result case.
				Result := stack_value_at (dep, a_loc_type, pos, a_rt_type)
			end
		end

	set_local_value_at (dep: INTEGER; pos: INTEGER; a_rt_type: like rt_type; val: like value)
		local
			a_loc_type: INTEGER
			res: INTEGER
		do
			if pos = 0 then
				a_loc_type := {RT_DBG_INTERNAL}.rt_DLT_RESULT
			else
				a_loc_type := {RT_DBG_INTERNAL}.rt_DLT_LOCALVAR
			end
			res := set_stack_value_at (dep, a_loc_type, pos, a_rt_type, val)
			check res = 0 end
		end

feature -- Properties

	value: detachable G
			-- Associated value.

	callstack_depth: INTEGER
			-- Related call stack depth.

	rt_type: NATURAL_32
			-- Field type

feature -- Access

	current_value_record: detachable RT_DBG_VALUE_RECORD
			-- Record for current value
		do
			Result := object_local_record (callstack_depth, position, rt_type)
		end

	associated_object: detachable ANY
			-- Associated object, if any
		do
			--| No associated object for locals
		end

	is_local_record: BOOLEAN = True
			-- <Precursor>

	is_same_as (other: RT_DBG_VALUE_RECORD): BOOLEAN
		do
			Result := attached {like Current} other as l_loc and then
					position = l_loc.position and then
					value = l_loc.value
		end

	debug_output: STRING_32
		do
			Result := Precursor + " (depth=" + callstack_depth.out + ")"
		end

	to_string: STRING
			-- String representation
		local
			v: like value
		do
			v := value
			inspect type
			when {REFLECTOR_CONSTANTS}.reference_type then
				if v /= Void then
					Result := ($v).out
				else
					Result := "Void"
				end
			when {REFLECTOR_CONSTANTS}.expanded_type then
				check value_attached: value /= Void end
				if v /= Void then
					Result := ($v).out
				else
					create Result.make_empty
				end
			else
				if v /= Void then
					Result := out_value (v)
				else
					create Result.make_empty
				end
			end
		end

feature -- Change properties

	get_value
			-- Get `value'
		do
			if attached {like value} local_value_at (callstack_depth, position, rt_type) as v then
				value := v
			else
				value := default_value
			end
		end

feature -- Runtime

	restore (val: RT_DBG_VALUE_RECORD)
			-- Restore `value' , and associate `val' as `backup'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".restore: depth=" + callstack_depth.out + " #" + position.out + "%N")
			end
			if is_same_as (val) then
				debug ("RT_DBG_REPLAY")
					dtrace ({STRING_32} " -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_local_from_record (Current)
				debug ("RT_DBG_REPLAY")
					dtrace ({STRING_32} " -> restored: from [" + val.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (bak: RT_DBG_VALUE_RECORD)
			-- Revert previous change due to Current
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".revert: depth=" + callstack_depth.out + " #" + position.out + "%N")
			end
			set_local_from_record (bak)
			debug ("RT_DBG_REPLAY")
				dtrace ({STRING_32} " -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
			end
		end

feature {NONE} -- Internal Implementation

	set_local_from_record (r: RT_DBG_VALUE_RECORD)
			-- Set object field defined by `r' on target `obj'
		require
			r_attached: r /= Void
		do
			if attached {RT_DBG_LOCAL_RECORD [like value]} r as ot_record then
				set_local_value_at (callstack_depth, position, rt_type, ot_record.value)
			else
				check should_not_occur: False end
			end
		end

feature {NONE} -- Output

	out_value (v: attached G): STRING
			-- Printable representation of `v'.
		require
			v_attached: attached v
		do
			Result := v.out
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Implementation

	default_value: detachable G
			-- Default value
		do
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
