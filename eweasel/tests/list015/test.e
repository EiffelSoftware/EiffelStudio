class TEST

create
	make
feature

	make
		do
			test_move
		end

	test_move
		local
			chain: CHAIN_IMP [INTEGER]
		do
			create chain.make

			chain.extend (1)
			chain.extend (2)
			chain.extend (3)
			chain.extend (4)

			from
				chain.go_i_th (0)
			until
				chain.after
			loop
				chain.move (1)
				if not chain.off then
					io.put_integer (chain.item_for_iteration)
					io.put_new_line
				end
			end

			from
			until
				chain.before
			loop
				chain.move (-1)
				if not chain.off then
					io.put_integer (chain.item_for_iteration)
					io.put_new_line
				end
			end

		end

end
