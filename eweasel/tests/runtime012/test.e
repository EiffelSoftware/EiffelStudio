class TEST

inherit
	INTERNAL

create
	make

feature

	make is
		local
			l_spec: SPECIAL [INTEGER_64]
			l_count: NATURAL_64
		do
			create l_spec.make (0x1FFFFFFF)
			l_spec := l_spec.aliased_resized_area (0x20000001)

			io.put_integer (l_spec.count) io.put_new_line
			io.put_integer (l_spec.capacity) io.put_new_line

			l_count := l_spec.count.as_natural_64

			if (l_count * 8) > physical_size_64 (l_spec) then
				if (l_count * 8) - physical_size_64 (l_spec) > 32 then
					io.put_natural_64 ((l_count * 8) - physical_size_64 (l_spec))
					io.put_new_line
				end
			elseif physical_size_64 (l_spec) - (l_count * 8) > 32 then
				io.put_natural_64 (physical_size_64 (l_spec) - (l_count * 8))
				io.put_new_line
			end
		end

end
