note
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_ATTRIBUTE_RECORD [G -> detachable ANY]

inherit
	RT_DBG_VALUE_RECORD
		rename
			position as offset
		redefine
			debug_output
		end

create
	make

feature {NONE} -- Initialization

	make (obj: ANY; o,eif_t: INTEGER; t: NATURAL_32; v: like value)
			-- Make field record with index `i', type `t' an value `v'
		require
			obj_attached: obj /= Void
		do
			object := obj
			offset := o
			type := eif_t
			rt_type := t
			value := v
		end

feature -- Properties

	object: ANY
			-- Associated object.

	value: detachable G
			-- Associated value.

	rt_type: NATURAL_32
			-- Field type

feature -- Access

	current_value_record: detachable RT_DBG_VALUE_RECORD
			-- Record for current value
		do
			Result := object_attribute_record (offset, rt_type, object)
		end

	associated_object: detachable ANY
			-- Associated object, if any
		do
			Result := object
		end

	is_local_record: BOOLEAN = False
			-- <Precursor>

	is_same_as (other: RT_DBG_VALUE_RECORD): BOOLEAN
		do
			Result := attached {like Current} other as l_att and then
					offset = l_att.offset and then
					value = l_att.value
		end

	debug_output: STRING_32
		do
			Result := Precursor + " (object=" + object.generating_type.name_32 + ")"
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
				check expanded_value_attached: value /= Void end
				if v /= Void then
					Result := ($v).out
				else
					create Result.make_empty
				end
			else
				if v /= Void then
					Result := out_value (v)
				else
					check should_not_be_void: False end
					create Result.make_empty
				end
			end
		end

feature -- Change properties

	get_value
			-- Get `value'
		do
			if attached {like value} field_at (offset, rt_type, object) as v then
				value := v
			else
				value := default_value
			end
		end

feature -- Runtime

	restore (val: RT_DBG_VALUE_RECORD)
			-- Restore `value' on `object'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".restore (" + object.generator + " #" + offset.out + ")%N")
				if attached field_name_at (offset, object) as fn then
 					dtrace ({STRING_32} " -> " + fn  + "%N")
 				else
 					dtrace (" -> Unknown name%N")
				end
			end
			if is_same_as (val) then
				debug ("RT_DBG_REPLAY")
					dtrace ({STRING_32} " -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_attribute_from_record (object, Current)
				debug ("RT_DBG_REPLAY")
					dtrace ({STRING_32} " -> restored: from [" + val.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (bak: RT_DBG_VALUE_RECORD)
			-- Revert previous change due to Current to `object'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".revert (" + object.generator + " #" + offset.out + ")%N")
			end
			set_attribute_from_record (object, bak)
			debug ("RT_DBG_REPLAY")
				dtrace ({STRING_32} " -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
			end
		end

feature {NONE} -- Internal Implementation

	set_attribute_from_record (obj: ANY; r: RT_DBG_VALUE_RECORD)
			-- Set object field defined by `r' on target `obj'
		require
			obj_attached: obj /= Void
			r_attached: r /= Void
		do
			if attached {RT_DBG_ATTRIBUTE_RECORD [like value]} r as ot_record then
				set_field_at (offset, rt_type, ot_record.value, obj)
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
