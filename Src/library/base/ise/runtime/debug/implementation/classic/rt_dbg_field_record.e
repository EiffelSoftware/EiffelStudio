note
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_FIELD_RECORD [G -> detachable ANY]

inherit
	RT_DBG_VALUE_RECORD
		rename
			position as index
		end

create
	make

feature {NONE} -- Initialization

	make (obj: ANY; i,t: INTEGER; v: like value)
			-- Make field record with index `i', type `t' an value `v'
		require
			obj_attached: obj /= Void
		do
			object := obj
			index := i
			type := t
			value := v
		end

feature -- Properties

	object: ANY
			-- Associated object.

	value: detachable G
			-- Associated value.

feature -- Access

	current_value_record: detachable RT_DBG_VALUE_RECORD
			-- Record for current value
		do
			Result := object_record (index, object)
		end

	associated_object: detachable ANY
			-- Associated object, if any
		do
			Result := object
		end

	is_local_record: BOOLEAN = False
			-- <Precursor>

	is_same_as (other: RT_DBG_VALUE_RECORD): BOOLEAN
			-- Is Current same as `other' ?
		do
			Result := attached {like Current} other as l_field and then
					index = l_field.index and then
					value = l_field.value
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
					check False end
					create Result.make_empty
				end
			end
		end

feature -- Change properties

	get_value
			-- Get value on `obj'
		local
			l_reflected_object: like reflected_object
		do
			l_reflected_object := reflected_object
			l_reflected_object.set_object (object)
			if attached {like value} l_reflected_object.field (index) as v then
				value := v
			else
				value := default_value
			end
		end

feature -- Runtime

	restore (val: RT_DBG_VALUE_RECORD)
			-- Restore `value' on `object', and associate `val' as `backup'
		do
			debug ("RT_DBG_REPLAY")
				reflected_object.set_object (object)
				dtrace (generator + ".restore (" + object.generator + " #" + index.out + ")%N")
 				dtrace ({STRING_32} " -> " + reflected_object.field_name (index) + ": offset " + reflected_object.field_offset (index).out + "%N")
			end
			if is_same_as (val) then
				debug ("RT_DBG_REPLAY")
					dtrace ({STRING_32} " -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_object_field (object, Current)
				debug ("RT_DBG_REPLAY")
					dtrace ({STRING_32} " -> restored: from [" + val.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (bak: RT_DBG_VALUE_RECORD)
			-- Revert previous change due to Current to `object'
		do
			debug ("RT_DBG_REPLAY")
				dtrace (generator + ".revert (" + object.generator + " #" + index.out + ")%N")
			end
			set_object_field (object, bak)
			debug ("RT_DBG_REPLAY")
				dtrace ({STRING_32} " -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
			end
		end

feature {NONE} -- Internal Implementation

	set_object_field (obj: ANY; r: RT_DBG_VALUE_RECORD)
			-- Set object field defined by `r' on target `obj'
		require
			obj_attached: obj /= Void
			r_attached: r /= Void
		local
			i: like index
			l_reflected_object: like reflected_object
		do
			i := index
			l_reflected_object := reflected_object
			l_reflected_object.set_object (obj)
			inspect
				r.type
			when Integer_8_type then
				if attached {RT_DBG_FIELD_RECORD [INTEGER_8]} r as l_fr_integer_8 then
					l_reflected_object.set_integer_8_field (i, (l_fr_integer_8).value)
				end
			when Integer_16_type then
				if attached {RT_DBG_FIELD_RECORD [INTEGER_16]} r as l_fr_integer_16 then
					l_reflected_object.set_integer_16_field (i, (l_fr_integer_16).value)
				end
			when integer_32_type then
				if attached {RT_DBG_FIELD_RECORD [INTEGER_32]} r as l_fr_integer_32 then
					l_reflected_object.set_integer_32_field (i, (l_fr_integer_32).value)
				end
			when Integer_64_type then
				if attached {RT_DBG_FIELD_RECORD [INTEGER_64]} r as l_fr_integer_64 then
					l_reflected_object.set_integer_64_field (i, (l_fr_integer_64).value)
				end
			when Natural_8_type then
				if attached {RT_DBG_FIELD_RECORD [NATURAL_8]} r as l_fr_natural_8 then
					l_reflected_object.set_natural_8_field (i, (l_fr_natural_8).value)
				end
			when Natural_16_type then
				if attached {RT_DBG_FIELD_RECORD [NATURAL_16]} r as l_fr_natural_16 then
					l_reflected_object.set_natural_16_field (i, (l_fr_natural_16).value)
				end
			when natural_32_type then
				if attached {RT_DBG_FIELD_RECORD [NATURAL_32]} r as l_fr_natural_32 then
					l_reflected_object.set_natural_32_field (i, (l_fr_natural_32).value)
				end
			when Natural_64_type then
				if attached {RT_DBG_FIELD_RECORD [NATURAL_64]} r as l_fr_natural_64 then
					l_reflected_object.set_natural_64_field (i, (l_fr_natural_64).value)
				end
			when Pointer_type then
				if attached {RT_DBG_FIELD_RECORD [POINTER]} r as l_fr_pointer then
					l_reflected_object.set_pointer_field (i, (l_fr_pointer).value)
				end
			when Reference_type then
				if attached {RT_DBG_FIELD_RECORD [ANY]} r as l_fr_any and then attached {ANY} l_fr_any.value as vr then
					l_reflected_object.set_reference_field (i, vr)
				end
			when Expanded_type then
				if attached {RT_DBG_FIELD_RECORD [ANY]} r as l_fr_eany and then attached {ANY} l_fr_eany.value as ve then
					l_reflected_object.set_reference_field (i, ve)
				end
			when Boolean_type then
				if attached {RT_DBG_FIELD_RECORD [BOOLEAN]} r as l_fr_boolean then
					l_reflected_object.set_boolean_field (i, (l_fr_boolean).value)
				end
			when real_32_type then
				if attached {RT_DBG_FIELD_RECORD [REAL_32]} r as l_fr_real_32 then
					l_reflected_object.set_real_32_field (i, (l_fr_real_32).value)
				end
			when real_64_type then
				if attached {RT_DBG_FIELD_RECORD [REAL_64]} r as l_fr_real_64 then
					l_reflected_object.set_real_64_field (i, (l_fr_real_64).value)
				end
			when character_8_type then
				if attached {RT_DBG_FIELD_RECORD [CHARACTER_8]} r as l_fr_character_8 then
					l_reflected_object.set_character_8_field (i, (l_fr_character_8).value)
				end
			when character_32_type then
				if attached {RT_DBG_FIELD_RECORD [CHARACTER_32]} r as l_fr_character_32 then
					l_reflected_object.set_character_32_field (i, (l_fr_character_32).value)
				end
--			when none_type then
			else
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

invariant
	object_attached: object /= Void

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
