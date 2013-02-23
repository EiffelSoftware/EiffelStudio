class TEST

create
	make

feature

	make
		do
		end

feature

	test_array: ARRAYED_LIST [INTEGER]
			-- Test for compiler non-error.
		attribute
		ensure
			not_empty: not Result.is_empty
		end

end
