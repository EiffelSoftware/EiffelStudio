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
			l_spec_exp, l_spec_exp_bis: SPECIAL [EXP]
			l_spec_exp2, l_spec_exp2_bis: SPECIAL [EXP2]
			l_exp, l_expd: EXP
			l_exp2, l_exp2d: EXP2
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
				io.put_string ("Not equal!!")
				io.put_new_line
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

				-- Clean up the previous 4GB of the SPECIAL before the twin.
			collection_on
			full_collect
			collection_off

				-- Check that deep duplication works
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

				-- Check that insertion and access in a special of expanded works.
			l_exp.set (0xFFF, 0x0, 0x1, 0xF0F0F0F0)

			if l_expd /~ l_spec_exp.item (0x7FFFFFF) then
				io.put_string ("Not great")
				io.put_new_line
			end

			p := l_spec_exp.item_address (0x7FFFFFF)

			l_spec_exp.put (l_exp, 0x7FFFFFF)
			if l_exp /~ l_spec_exp.item (0x7FFFFFF) then
				io.put_string ("Not great")
				io.put_new_line
			end

			l_spec_exp.put_default (0x7FFFFFF)
			if l_expd /~ l_spec_exp.item (0x7FFFFFF) then
				io.put_string ("Not great")
				io.put_new_line
			end

				-- Check various call to copy data between specials
			create l_spec_exp_bis.make (0x7FFFFFF)
			create l_string.make_empty
			if
				not l_spec_exp.standard_is_equal (l_spec_exp_bis) or
				not l_spec_exp.is_deep_equal (l_spec_exp_bis)
			then
				io.put_string ("Not equal!!")
				io.put_new_line
			end

			l_spec_exp.copy_data (l_spec_exp_bis, 0x7FFFFF0, 0x7FFFFF0, 0xE)
			l_spec_exp.move_data (0x0, 0x7FFFFF0, 0xE)
			l_spec_exp.overlapping_move (0x7FFFFEF, 0x7FFFFF0, 0xE)
			l_spec_exp.non_overlapping_move (0x7FFFFE0, 0x7FFFFF0, 0xE)

				-- Clean up the memory allocated for the two special of expanded.
			l_spec_exp := Void
			l_spec_exp_bis := Void
			collection_on
			full_collect
			collection_off

				-- Repeat the test but this time with expanded containing references
				-- Check that special of expanded initialization works. This will be
				-- 6GB in both workbench and finalized
			create l_spec_exp2.make (0x8000000)
			create l_string.make_empty

				-- Check that insertion and access in a special of expanded works.
			l_exp2.set (0xFFF, 0x0, 0x1, 0xF0F0F0F0)

			if l_exp2d /~ l_spec_exp2.item (0x7FFFFFF) then
				io.put_string ("Not great")
				io.put_new_line
			end

			p := l_spec_exp2.item_address (0x7FFFFFF)

			l_spec_exp2.put (l_exp2, 0x7FFFFFF)
			if l_exp2 /~ l_spec_exp2.item (0x7FFFFFF) then
				io.put_string ("Not great")
				io.put_new_line
			end

			l_spec_exp2.put_default (0x7FFFFFF)
			if l_exp2d /~ l_spec_exp2.item (0x7FFFFFF) then
				io.put_string ("Not great")
				io.put_new_line
			end

				-- Check various call to copy data between specials
			create l_spec_exp2_bis.make (0x7FFFFFF)
			create l_string.make_empty
			if
				not l_spec_exp2.standard_is_equal (l_spec_exp2_bis) or
				not l_spec_exp2.is_deep_equal (l_spec_exp2_bis)
			then
				io.put_string ("Not equal!!")
				io.put_new_line
			end

			l_spec_exp2.copy_data (l_spec_exp2_bis, 0x7FFFFF0, 0x7FFFFF0, 0xE)
			l_spec_exp2.move_data (0x0, 0x7FFFFF0, 0xE)
			l_spec_exp2.overlapping_move (0x7FFFFEF, 0x7FFFFF0, 0xE)
			l_spec_exp2.non_overlapping_move (0x7FFFFE0, 0x7FFFFF0, 0xE)
		end

end
