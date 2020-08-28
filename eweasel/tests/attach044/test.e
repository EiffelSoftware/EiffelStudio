class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_int: INTERNAL
			i, nb, l_dtype: INTEGER
		do
			create l_int
			from
				i := 1
				l_dtype := l_int.dynamic_type (Current)
				nb := l_int.field_count (Current)
			until
				i > nb
			loop
				if l_int.is_attached_type (l_int.field_static_type_of_type (i, l_dtype)) then
					l_int.set_reference_field (i, Current, "TEST")
					if not precondition_violation (Current, i) then
						io.put_string ("Not OK!%N")
					end
				else
					l_int.set_reference_field (i, Current, Void)
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	attached_string: attached STRING
	detachable_string: detachable STRING

	precondition_violation (obj: ANY; pos: INTEGER): BOOLEAN
		local
			l_int: INTERNAL
		do
			if not Result then
				create l_int
				l_int.set_reference_field (pos, Current, Void)
			end
		rescue
			Result := True
			retry
		end

end
