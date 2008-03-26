indexing
	description: "Common routine for RT_DBG_ classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_COMMON

inherit
	INTERNAL

	RT_EXTENSION_COMMON

feature -- Object access

	object_field_count (obj: ANY): INTEGER is
		do
			Result := field_count (obj)
		end

	object_records (obj: ANY): ?ARRAYED_LIST [RT_DBG_RECORD] is
		local
			i, cnb: INTEGER
			r: ARRAYED_LIST [RT_DBG_RECORD]
		do
			cnb := object_field_count (obj)
			if cnb > 0 then
				create r.make (cnb)
				from
					i := 1
				until
					i > cnb
				loop
					r.extend (object_record (i, obj))
					i := i + 1
				end
				Result := r
			end
		end

	object_record (i: INTEGER; obj: ANY): ?RT_DBG_RECORD is
		local
			ft: INTEGER
		do
			ft := field_type (i, obj)
			inspect ft
			when Integer_8_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_8]} Result.make (i, ft, integer_8_field (i, obj))
			when Integer_16_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_16]} Result.make (i, ft, integer_16_field (i, obj))
			when integer_32_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_32]} Result.make (i, ft, integer_32_field (i, obj))
			when Integer_64_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_64]} Result.make (i, ft, integer_64_field (i, obj))
			when natural_8_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_8]} Result.make (i, ft, natural_8_field (i, obj))
			when natural_16_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_16]} Result.make (i, ft, natural_16_field (i, obj))
			when natural_32_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_32]} Result.make (i, ft, natural_32_field (i, obj))
			when natural_64_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_64]} Result.make (i, ft, natural_64_field (i, obj))
			when Pointer_type then
				create {RT_DBG_FIELD_RECORD [POINTER]} Result.make (i, ft, pointer_field (i, obj))
			when Reference_type then
				create {RT_DBG_FIELD_RECORD [ANY]} Result.make (i, ft, field (i, obj))
			when Expanded_type then
				create {RT_DBG_FIELD_RECORD [ANY]} Result.make (i, ft, field (i, obj))
			when Boolean_type then
				create {RT_DBG_FIELD_RECORD [BOOLEAN]} Result.make (i, ft, boolean_field (i, obj))
			when real_32_type then
				create {RT_DBG_FIELD_RECORD [REAL_32]} Result.make (i, ft, real_32_field (i, obj))
			when real_64_type then
				create {RT_DBG_FIELD_RECORD [REAL_64]} Result.make (i, ft, real_64_field (i, obj))
			when character_8_type then
				create {RT_DBG_FIELD_RECORD [CHARACTER_8]} Result.make (i, ft, character_8_field (i, obj))
			when character_32_type then
				create {RT_DBG_FIELD_RECORD [CHARACTER_32]} Result.make (i, ft, character_32_field (i, obj))
--			when Bit_type then
--			when none_type then
			else
			end
--			Result.set_offset (field_offset (i, obj))
		end

	object_is_expanded (object: ANY): BOOLEAN is
			-- Is `object' an expanded value ?
		do
			Result := c_object_is_expanded ($object)
		end

feature -- Query

	changes_between (csr1: RT_DBG_CALL_RECORD; csr2: ?RT_DBG_CALL_RECORD): ARRAYED_LIST [TUPLE [obj: ANY; record: RT_DBG_RECORD]] is
			-- from `r1' to -beginning-of- `r2'.
		require
			csr1_not_void: csr1 /= Void
		local
			o: ANY
			chgs: like changes_between
			r: RT_DBG_RECORD
		do
			create Result.make (10)
			if csr1.is_flat and then {fr: like changes_between} csr1.flat_field_records then
				Result := fr
			else
					--| Keep Full records
				if {flds: LIST [RT_DBG_RECORD]} csr1.field_records then
					from
						o := csr1.object
						flds.start
					until
						flds.after
					loop
						r := flds.item_for_iteration
						Result.extend ([o, r])
						flds.forth
					end
				end
				if {rcds: LIST [RT_DBG_CALL_RECORD]} csr1.call_records then
					from
						rcds.start
					until
						rcds.after or rcds.item_for_iteration = csr2
					loop
						chgs := changes_between (rcds.item_for_iteration, csr2)
						Result.append (chgs)
						rcds.forth
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- External implementation

	c_object_is_expanded (object: POINTER): BOOLEAN is
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"eif_is_expanded(HEADER($object)->ov_flags)"
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
