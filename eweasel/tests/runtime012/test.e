class TEST

inherit
	INTERNAL
	MEMORY

create
	make

feature

	make is
		local
			l_spec: SPECIAL [INTEGER_64]
			l_count: NATURAL_64
		do
			collection_off

			create l_spec.make (0x1FFFFFFF)
			l_spec := l_spec.aliased_resized_area (0x20000001)

			if l_spec.count /= 536870913 then
				io.put_string ("Not OK%N")
			end
			if l_spec.capacity /= 536870913 then
				io.put_string ("Not OK%N")
			end

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

			l_spec := Void
			collection_on
			full_collect
			collection_off

			create l_spec.make (0x1FFFFFFF)
			l_spec := l_spec.twin

			if l_spec.count /= 536870911 then
				io.put_string ("Not OK%N")
			end
			if l_spec.capacity /= 536870911 then
				io.put_string ("Not OK%N")
			end

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

			collection_on
			full_collect
			collection_off

			l_spec := l_spec.deep_twin

			if l_spec.count /= 536870911 then
				io.put_string ("Not OK%N")
			end
			if l_spec.capacity /= 536870911 then
				io.put_string ("Not OK%N")
			end

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
