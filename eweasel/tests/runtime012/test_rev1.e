class TEST

inherit
	INTERNAL
	MEMORY

create
	make

feature

	make is
		local
			l_spec, l_spec_bis: SPECIAL [INTEGER_64]
			l_spec_exp: SPECIAL [EXP]
			l_spec_exp2: SPECIAL [EXP2]
			p: POINTER
			l_count: NATURAL_64
			l_string: STRING
		do
			collection_off

				-- This will create a SPECIAL array slightly below the 4GB size limit.
			create l_spec.make (0x1FFFFFFF)
				-- The creation of the empty string is to force in workbench mode
				-- the wiping out of the temporary local that holds the above
				-- SPECIAL object so that when the GC is called below we do reclaim our
				-- 4GB we don't use.
			create l_string.make_empty
				-- Check that resizing works when we go above 4GB.
			l_spec := l_spec.aliased_resized_area (0x20000001)

			if l_spec.count /= 536870913 then
				io.put_string ("Not OK - 1%N")
			end
			if l_spec.capacity /= 536870913 then
				io.put_string ("Not OK - 2%N")
			end

			l_count := l_spec.count.as_natural_64

			if (l_count * 8) > physical_size_64 (l_spec) then
				if (l_count * 8) - physical_size_64 (l_spec) > 32 then
					io.put_string ("Not OK - 3%N")
					io.put_natural_64 ((l_count * 8) - physical_size_64 (l_spec))
					io.put_new_line
				end
			elseif physical_size_64 (l_spec) - (l_count * 8) > 32 then
				io.put_string ("Not OK - 4%N")
				io.put_natural_64 (physical_size_64 (l_spec) - (l_count * 8))
				io.put_new_line
			end

			p := l_spec.item_address (0x20000000)

				-- Get rid of the 4GB we have allocated.
			l_spec := Void
			collection_on
			full_collect
			collection_off

				-- Check that equality works by creating too large SPECIALs
			create l_spec.make (0x1FFFFFFF)
			create l_string.make_empty
			create l_spec_bis.make (0x1FFFFFFF)
			create l_string.make_empty
			if not l_spec.standard_is_equal (l_spec_bis) or not l_spec.is_deep_equal (l_spec_bis) then
				io.put_string ("Not equal - 1%N")
			end

				-- Check various call to copy data between specials
			l_spec.copy_data (l_spec_bis, 0x1FFFFFF0, 0x1FFFFFF0, 0xE)
			l_spec.move_data (0x0, 0x1FFFFFF0, 0xE)
			l_spec.overlapping_move (0x1FFFFFEF, 0x1FFFFFF0, 0xE)
			l_spec.non_overlapping_move (0x1FFFFFE0, 0x1FFFFFF0, 0xE)

				-- We clean one of the 4GB allocated.
			l_spec_bis := Void
			collection_on
			full_collect
			collection_off
	
				-- Check that shallow duplication works
			l_spec := l_spec.twin

			if l_spec.count /= 536870911 then
				io.put_string ("Not OK - 5%N")
			end
			if l_spec.capacity /= 536870911 then
				io.put_string ("Not OK - 6%N")
			end

			l_count := l_spec.count.as_natural_64

			if (l_count * 8) > physical_size_64 (l_spec) then
				if (l_count * 8) - physical_size_64 (l_spec) > 32 then
					io.put_string ("Not OK - 7%N")
					io.put_natural_64 ((l_count * 8) - physical_size_64 (l_spec))
					io.put_new_line
				end
			elseif physical_size_64 (l_spec) - (l_count * 8) > 32 then
				io.put_string ("Not OK - 8%N")
				io.put_natural_64 (physical_size_64 (l_spec) - (l_count * 8))
				io.put_new_line
			end

				-- Clean up the previous 4GB of the SPECIAL before the twin.
			collection_on
			full_collect
			collection_off

				-- Check that deep duplication works
			l_spec := l_spec.deep_twin

			if l_spec.count /= 536870911 then
				io.put_string ("Not OK - 9%N")
			end
			if l_spec.capacity /= 536870911 then
				io.put_string ("Not OK - 10%N")
			end

			l_count := l_spec.count.as_natural_64

			if (l_count * 8) > physical_size_64 (l_spec) then
				if (l_count * 8) - physical_size_64 (l_spec) > 32 then
					io.put_string ("Not OK - 11%N")
					io.put_natural_64 ((l_count * 8) - physical_size_64 (l_spec))
					io.put_new_line
				end
			elseif physical_size_64 (l_spec) - (l_count * 8) > 32 then
				io.put_string ("Not OK - 12%N")
				io.put_natural_64 (physical_size_64 (l_spec) - (l_count * 8))
				io.put_new_line
			end

				-- Clean up the 8GB we allocated.
			l_spec := Void
			collection_on
			full_collect
			collection_off

				-- Check that special of expanded initialization works.
				-- The line below will create a SPECIAL which is about 6GB in workbench because
				-- we have the header, but only 4GB in finalized mode.
			create l_spec_exp.make (0x8000000)
			create l_string.make_empty

			l_spec_exp := Void
			collection_on
			full_collect
			collection_off

				-- Repeat the test but this time with expanded containing references
				-- Check that special of expanded initialization works. This will be
				-- 6GB in both workbench and finalized
			create l_spec_exp2.make (0x8000000)
			create l_string.make_empty
		end

end
