indexing
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_ATTRIBUTE_RECORD [G]

inherit
	RT_DBG_RECORD
		rename
			position as offset
		end

create
	make

feature {NONE} -- Initialization

	make (obj: !ANY; o,eif_t: INTEGER; t: NATURAL_32; v: like value)
			-- Make field record with index `i', type `t' an value `v'
		do
			object := obj
			offset := o
			type := eif_t
			rt_type := t
			value := v
		end

feature -- Properties

	object: !ANY
			-- Associated object.

	value: G
			-- Associated value.

	rt_type: NATURAL_32
			-- Field type

feature -- Access

	current_value_record: RT_DBG_RECORD
			-- Record for current value
		do
			Result := object_attribute_record (offset, rt_type, object)
		end

	associated_object: ANY
			-- Associated object, if any
		do
			Result := object
		end

	is_local_record: BOOLEAN = False
			-- <Precursor>

	is_same_as (other: !RT_DBG_RECORD): BOOLEAN
		do
			Result := {c: like Current} other and then offset = c.offset and then value = c.value
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
			if {v: like value} field_at (offset, rt_type, object) then
				value := v
			else
				value := default_value
			end
		end

feature -- Runtime

	restore (val: !RT_DBG_RECORD)
			-- Restore `value' on `object'
		do
			debug ("RT_EXTENSION")
				dtrace (generator + ".restore (" + object.generator + " #" + offset.out + ")%N")
 				dtrace (" -> " + field_name_at (offset, object) + "%N")
			end
			if is_same_as (val) then
				debug ("RT_EXTENSION")
					dtrace (" -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_attribute_from_record (object, Current)
				debug ("RT_EXTENSION")
					dtrace (" -> restored: from [" + val.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (bak: !RT_DBG_RECORD)
			-- Revert previous change due to Current to `object'
		do
			debug ("RT_EXTENSION")
				dtrace (generator + ".revert (" + object.generator + " #" + offset.out + ")%N")
			end
			set_attribute_from_record (object, bak)
			debug ("RT_EXTENSION")
				dtrace (" -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
			end
		end

feature {NONE} -- Internal Implementation

	set_attribute_from_record (obj: !ANY; r: !RT_DBG_RECORD)
			-- Set object field defined by `r' on target `obj'
		do
			if {ot_record: RT_DBG_ATTRIBUTE_RECORD [like value]} r then
				set_field_at (offset, rt_type, ot_record.value, obj)
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
