class TEST

inherit
	MEMORY

create
	make

feature

	make is
		local
			l_spec_exp, l_spec_exp_bis: SPECIAL [EXP]
			l_spec_exp2, l_spec_exp2_bis: SPECIAL [EXP2]
			l_exp, l_expd: EXP
			l_exp2, l_exp2d: EXP2
			p: POINTER
			l_string: STRING
		do
			collection_off

				-- Check that special of expanded initialization works.
				-- The line below will create a SPECIAL which is about 6GB in workbench because
				-- we have the header, but only 4GB in finalized mode.
			create l_spec_exp.make (0x8000000)
			create l_string.make_empty

				-- Check that insertion and access in a special of expanded works.
			l_exp.set (0xFFF, 0x0, 0x1, 0xF0F0F0F0)

			if l_expd /~ l_spec_exp.item (0x7FFFFFF) then
				io.put_string ("Not OK - 13%N")
			end

			p := l_spec_exp.item_address (0x7FFFFFF)

			l_spec_exp.put (l_exp, 0x7FFFFFF)
			if l_exp /~ l_spec_exp.item (0x7FFFFFF) then
				io.put_string ("Not OK - 14%N")
			end

			l_spec_exp.put_default (0x7FFFFFF)
			if l_expd /~ l_spec_exp.item (0x7FFFFFF) then
				io.put_string ("Not OK - 15%N")
			end

				-- Check various call to copy data between specials
			create l_spec_exp_bis.make (0x7FFFFFF)
			create l_string.make_empty
			if
				not l_spec_exp.standard_is_equal (l_spec_exp_bis) or
				not l_spec_exp.is_deep_equal (l_spec_exp_bis)
			then
				io.put_string ("Not equal - 2%N")
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
				io.put_string ("Not OK - 16%N")
			end

			p := l_spec_exp2.item_address (0x7FFFFFF)

			l_spec_exp2.put (l_exp2, 0x7FFFFFF)
			if l_exp2 /~ l_spec_exp2.item (0x7FFFFFF) then
				io.put_string ("Not OK - 17%N")
			end

			l_spec_exp2.put_default (0x7FFFFFF)
			if l_exp2d /~ l_spec_exp2.item (0x7FFFFFF) then
				io.put_string ("Not OK - 18%N")
			end

				-- Check various call to copy data between specials
			create l_spec_exp2_bis.make (0x7FFFFFF)
			create l_string.make_empty
			if
				not l_spec_exp2.standard_is_equal (l_spec_exp2_bis) or
				not l_spec_exp2.is_deep_equal (l_spec_exp2_bis)
			then
				io.put_string ("Not equal - 3%N")
			end

			l_spec_exp2.copy_data (l_spec_exp2_bis, 0x7FFFFF0, 0x7FFFFF0, 0xE)
			l_spec_exp2.move_data (0x0, 0x7FFFFF0, 0xE)
			l_spec_exp2.overlapping_move (0x7FFFFEF, 0x7FFFFF0, 0xE)
			l_spec_exp2.non_overlapping_move (0x7FFFFE0, 0x7FFFFF0, 0xE)
		end

end
