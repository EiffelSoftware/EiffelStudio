indexing
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_LOCAL_RECORD [G]

inherit
	RT_DBG_RECORD
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

	frozen local_value_at (dep: INTEGER; pos: INTEGER; a_rt_type: like rt_type): ANY is
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

	value: G
			-- Associated value.

	callstack_depth: INTEGER
			-- Related call stack depth.

	rt_type: NATURAL_32
			-- Field type

feature -- Access

	current_value_record: RT_DBG_RECORD
			-- Record for current value
		do
			Result := object_local_record (callstack_depth, position, rt_type)
		end

	associated_object: ANY
			-- Associated object, if any
		do
			--| No associated object for locals
		end

	is_local_record: BOOLEAN = True
			-- <Precursor>

	is_same_as (other: !RT_DBG_RECORD): BOOLEAN
		do
			Result := {c: like Current} other and then position = c.position and then value = c.value
		end

	debug_output: STRING
		do
			Result := Precursor + " (depth=" + callstack_depth.out + ")"
		end

	to_string: STRING
			-- String representation
		do
			inspect type
			when {INTERNAL}.reference_type then
				if {v: ANY} value then
					Result := ($v).out
				else
					Result := "Void"
				end
			when {INTERNAL}.expanded_type then
				Result := ($value).out
			else
				Result := value.out
			end
		end

feature -- Change properties

	get_value
			-- Get `value'
		do
			if {v: like value} local_value_at (callstack_depth, position, rt_type) then
				value := v
			else
				value := default_value
			end
		end

feature -- Runtime

	restore (val: !RT_DBG_RECORD)
			-- Restore `value' , and associate `val' as `backup'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".restore: depth=" + callstack_depth.out + " #" + position.out + "%N")
			end
			if is_same_as (val) then
				debug ("RT_DBG_REPLAY")
					dtrace (" -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_local_from_record (Current)
				debug ("RT_DBG_REPLAY")
					dtrace (" -> restored: from [" + val.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (bak: !RT_DBG_RECORD)
			-- Revert previous change due to Current
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".revert: depth=" + callstack_depth.out + " #" + position.out + "%N")
			end
			set_local_from_record (bak)
			debug ("RT_DBG_REPLAY")
				dtrace (" -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
			end
		end

feature {NONE} -- Internal Implementation

	set_local_from_record (r: !RT_DBG_RECORD)
			-- Set object field defined by `r' on target `obj'
		do
			if {ot_record: RT_DBG_LOCAL_RECORD [like value]} r then
				set_local_value_at (callstack_depth, position, rt_type, ot_record.value)
			else
				check should_not_occur: False end
			end
		end

feature {NONE} -- Implementation

	default_value: G is
			-- Default value
		do
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
