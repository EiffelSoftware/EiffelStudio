indexing
	description: "Field record"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_FIELD_RECORD [G]

inherit
	RT_DBG_RECORD
		rename
			position as index,
			set_position as set_index
		redefine
			is_same_as
		end

	INTERNAL

create
	make

feature {NONE} -- Initialization

	make (i,t: INTEGER; v: like value)
			-- Make field record with index `i', type `t' an value `v'
		do
			index := i
			type := t
			value := v
		end

feature -- Properties

	value: G
			-- Associated value.

feature -- Access

	is_same_as (other: RT_DBG_RECORD): BOOLEAN
		local
			c: like Current
		do
			if Precursor {RT_DBG_RECORD} (other) then
				c ?= other
				Result := c /= Void and then value = c.value
			end
		end

	to_string: STRING
			-- String representation
		local
			v: ANY
		do
			inspect type
			when {INTERNAL}.reference_type then
				v ?= value
				if v = Void then
					Result := "Void"
				else
					Result := ($v).out
				end
			when {INTERNAL}.expanded_type then
				Result := ($value).out
			else
				Result := value.out
			end
		end

feature -- Change properties

	set_value (v: like value)
			-- Set `value'
		do
			value := v
		end

feature -- Runtime

	restore (obj: ANY; bak: RT_DBG_RECORD)
			-- Restore `value' on `obj', and associate `bak' as `backup'
		do
			debug ("RT_EXTENSION")
				dtrace (generator + ".restore (" + obj.generator + " #" + index.out + ")%N")
 				dtrace (" -> " + field_name (index,obj) + ": offset " + field_offset (index, obj).out + "%N")
			end
			if is_same_as (bak) then
				debug ("RT_EXTENSION")
					dtrace (" -> unchanged because same value [" + to_string + "].%N")
				end
			else
				set_backup (bak)
				set_object_field (obj, Current)
				debug ("RT_EXTENSION")
					dtrace (" -> restored: from [" + bak.to_string + "] to [" + to_string + "] %N")
				end
			end
		end

	revert (obj: ANY)
			-- Revert previous change due to Current to `obj'
		local
			bak: like backup
		do
			debug ("RT_EXTENSION")
				dtrace (generator + ".revert (" + obj.generator + " #" + index.out + ")%N")
			end
			bak := backup
			if bak /= Void then
				set_object_field (obj, bak)
				set_backup (Void)
				debug ("RT_EXTENSION")
					dtrace (" -> reverted: from [" + to_string + "] to [" + bak.to_string + "] %N")
				end
			end
		end

feature {NONE} -- Internal Implementation

	set_object_field (obj: ANY; r: RT_DBG_RECORD)
			-- Set object field defined by `r' on target `obj'
		local
			i: like index
			l_fr_integer_8: RT_DBG_FIELD_RECORD [INTEGER_8]
			l_fr_integer_16: RT_DBG_FIELD_RECORD [INTEGER_16]
			l_fr_integer_32: RT_DBG_FIELD_RECORD [INTEGER_32]
			l_fr_integer_64: RT_DBG_FIELD_RECORD [INTEGER_64]
			l_fr_natural_8: RT_DBG_FIELD_RECORD [NATURAL_8]
			l_fr_natural_16: RT_DBG_FIELD_RECORD [NATURAL_16]
			l_fr_natural_32: RT_DBG_FIELD_RECORD [NATURAL_32]
			l_fr_natural_64: RT_DBG_FIELD_RECORD [NATURAL_64]
			l_fr_pointer: RT_DBG_FIELD_RECORD [POINTER]
			l_fr_any: RT_DBG_FIELD_RECORD [ANY]
			l_fr_boolean: RT_DBG_FIELD_RECORD [BOOLEAN]
			l_fr_real_32: RT_DBG_FIELD_RECORD [REAL_32]
			l_fr_real_64: RT_DBG_FIELD_RECORD [REAL_64]
			l_fr_character_8: RT_DBG_FIELD_RECORD [CHARACTER_8]
			l_fr_character_32: RT_DBG_FIELD_RECORD [CHARACTER_32]
		do
			i := index
			inspect
				r.type
			when Integer_8_type then
				l_fr_integer_8 ?= r
				set_integer_8_field (i, obj, (l_fr_integer_8).value)
			when Integer_16_type then
				l_fr_integer_16 ?= r
				set_integer_16_field (i, obj, (l_fr_integer_16).value)
			when integer_32_type then
				l_fr_integer_32 ?= r
				set_integer_32_field (i, obj, (l_fr_integer_32).value)
			when Integer_64_type then
				l_fr_integer_64 ?= r
				set_integer_64_field (i, obj, (l_fr_integer_64).value)
			when Natural_8_type then
				l_fr_natural_8 ?= r
				set_natural_8_field (i, obj, (l_fr_natural_8).value)
			when Natural_16_type then
				l_fr_natural_16 ?= r
				set_natural_16_field (i, obj, (l_fr_natural_16).value)
			when natural_32_type then
				l_fr_natural_32 ?= r
				set_natural_32_field (i, obj, (l_fr_natural_32).value)
			when Natural_64_type then
				l_fr_natural_64 ?= r
				set_natural_64_field (i, obj, (l_fr_natural_64).value)
			when Pointer_type then
				l_fr_pointer ?= r
				set_pointer_field (i, obj, (l_fr_pointer).value)
			when Reference_type then
				l_fr_any ?= r
				set_reference_field (i, obj, (l_fr_any).value)
			when Expanded_type then
				l_fr_any ?= r
				set_reference_field (i, obj, (l_fr_any).value)
			when Boolean_type then
				l_fr_boolean ?= r
				set_boolean_field (i, obj, (l_fr_boolean).value)
			when real_32_type then
				l_fr_real_32 ?= r
				set_real_32_field (i, obj, (l_fr_real_32).value)
			when real_64_type then
				l_fr_real_64 ?= r
				set_real_64_field (i, obj, (l_fr_real_64).value)
			when character_8_type then
				l_fr_character_8 ?= r
				set_character_8_field (i, obj, (l_fr_character_8).value)
			when character_32_type then
				l_fr_character_32 ?= r
				set_character_32_field (i, obj, (l_fr_character_32).value)
--			when Bit_type then
--			when none_type then
			else
			end
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
