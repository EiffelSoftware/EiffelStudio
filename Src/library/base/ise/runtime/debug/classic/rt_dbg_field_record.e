indexing
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_FIELD_RECORD [G]

inherit
	RT_DBG_VALUE_RECORD
		rename
			position as index
		end

	INTERNAL

create
	make

feature {NONE} -- Initialization

	make (obj: !ANY; i,t: INTEGER; v: like value)
			-- Make field record with index `i', type `t' an value `v'
		do
			object := obj
			index := i
			type := t
			value := v
		end

feature -- Properties

	object: !ANY
			-- Associated object.

	value: G
			-- Associated value.

feature -- Access

	current_value_record: RT_DBG_VALUE_RECORD
			-- Record for current value
		do
			Result := object_record (index, object)
		end

	associated_object: ANY
			-- Associated object, if any
		do
			Result := object
		end

	is_local_record: BOOLEAN = False
			-- <Precursor>

	is_same_as (other: !RT_DBG_VALUE_RECORD): BOOLEAN
			-- Is Current same as `other' ?
		do
			Result := {c: like Current} other and then index = c.index and then value = c.value
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
				if {v2: like value} value then
					Result := v2.out
				else
					check False end
				end
			end
		end

feature -- Change properties

	get_value
			-- Get value on `obj'
		do
			if {v: like value} field (index, object) then
				value := v
			else
				value := default_value
			end
		end

feature -- Runtime

	restore (val: !RT_DBG_VALUE_RECORD)
			-- Restore `value' on `object', and associate `val' as `backup'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".restore (" + object.generator + " #" + index.out + ")%N")
 				dtrace (" -> " + field_name (index, object) + ": offset " + field_offset (index, object).out + "%N")
			end
			if is_same_as (val) then
				debug ("RT_DBG_REPLAY")
					dtrace (" -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_object_field (object, Current)
				debug ("RT_DBG_REPLAY")
					dtrace (" -> restored: from [" + val.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (bak: !RT_DBG_VALUE_RECORD)
			-- Revert previous change due to Current to `object'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".revert (" + object.generator + " #" + index.out + ")%N")
			end
			set_object_field (object, bak)
			debug ("RT_DBG_REPLAY")
				dtrace (" -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
			end
		end

feature {NONE} -- Internal Implementation

	set_object_field (obj: !ANY; r: !RT_DBG_VALUE_RECORD)
			-- Set object field defined by `r' on target `obj'
		local
			i: like index
		do
			i := index
			inspect
				r.type
			when Integer_8_type then
				if {l_fr_integer_8: RT_DBG_FIELD_RECORD [INTEGER_8]} r then
					set_integer_8_field (i, obj, (l_fr_integer_8).value)
				end
			when Integer_16_type then
				if {l_fr_integer_16: RT_DBG_FIELD_RECORD [INTEGER_16]} r then
					set_integer_16_field (i, obj, (l_fr_integer_16).value)
				end
			when integer_32_type then
				if {l_fr_integer_32: RT_DBG_FIELD_RECORD [INTEGER_32]} r then
					set_integer_32_field (i, obj, (l_fr_integer_32).value)
				end
			when Integer_64_type then
				if {l_fr_integer_64: RT_DBG_FIELD_RECORD [INTEGER_64]} r then
					set_integer_64_field (i, obj, (l_fr_integer_64).value)
				end
			when Natural_8_type then
				if {l_fr_natural_8: RT_DBG_FIELD_RECORD [NATURAL_8]} r then
					set_natural_8_field (i, obj, (l_fr_natural_8).value)
				end
			when Natural_16_type then
				if {l_fr_natural_16: RT_DBG_FIELD_RECORD [NATURAL_16]} r then
					set_natural_16_field (i, obj, (l_fr_natural_16).value)
				end
			when natural_32_type then
				if {l_fr_natural_32: RT_DBG_FIELD_RECORD [NATURAL_32]} r then
					set_natural_32_field (i, obj, (l_fr_natural_32).value)
				end
			when Natural_64_type then
				if {l_fr_natural_64: RT_DBG_FIELD_RECORD [NATURAL_64]} r then
					set_natural_64_field (i, obj, (l_fr_natural_64).value)
				end
			when Pointer_type then
				if {l_fr_pointer: RT_DBG_FIELD_RECORD [POINTER]} r then
					set_pointer_field (i, obj, (l_fr_pointer).value)
				end
			when Reference_type then
				if {l_fr_any: RT_DBG_FIELD_RECORD [ANY]} r then
					set_reference_field (i, obj, (l_fr_any).value)
				end
			when Expanded_type then
				if {l_fr_eany: RT_DBG_FIELD_RECORD [ANY]} r then
					set_reference_field (i, obj, (l_fr_eany).value)
				end
			when Boolean_type then
				if {l_fr_boolean: RT_DBG_FIELD_RECORD [BOOLEAN]} r then
					set_boolean_field (i, obj, (l_fr_boolean).value)
				end
			when real_32_type then
				if {l_fr_real_32: RT_DBG_FIELD_RECORD [REAL_32]} r then
					set_real_32_field (i, obj, (l_fr_real_32).value)
				end
			when real_64_type then
				if {l_fr_real_64: RT_DBG_FIELD_RECORD [REAL_64]} r then
					set_real_64_field (i, obj, (l_fr_real_64).value)
				end
			when character_8_type then
				if {l_fr_character_8: RT_DBG_FIELD_RECORD [CHARACTER_8]} r then
					set_character_8_field (i, obj, (l_fr_character_8).value)
				end
			when character_32_type then
				if {l_fr_character_32: RT_DBG_FIELD_RECORD [CHARACTER_32]} r then
					set_character_32_field (i, obj, (l_fr_character_32).value)
				end
--			when Bit_type then
--			when none_type then
			else
			end
		end

feature {NONE} -- Implementation

	default_value: G is
			-- Default value
		do
		end

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
