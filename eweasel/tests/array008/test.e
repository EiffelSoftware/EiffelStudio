class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: ARRAY2 [detachable STRING]
			b: ARRAY2 [detachable ANY]
			i, j: INTEGER
		do
				-- Check proper initialization
			create a.make (2, 3)
			a.initialize ("1")
			print_matrix (a)

			a.wipe_out
			print_matrix (a)

				-- Check proper resizing
			create a.make_filled ("1", 1, 1)
			print_matrix (a)
			a.resize_with_default ("2", 2, 2)
			print_matrix (a)
			a.resize_with_default ("3", 2, 5)
			print_matrix (a)
			a.resize_with_default ("4", 5, 5)
			print_matrix (a)
			a.resize_with_default ("5", 8, 8)
			print_matrix (a)
			a.resize_with_default ("6", 9, 5)
			print_matrix (a)
			a.resize_with_default ("7", 5, 9)
			print_matrix (a)

				-- Check proper replacement
				-- diagonal 1
			from
				i := 1
			until
				i > 9
			loop
				a.put (i.out, i, i)
				i := i + 1
			end
			print_matrix (a)

				-- diagonal 2
			from
				i := 1
				j := 9
			until
				i > 9
			loop
				a.put (i.out, i, j)
				j := j - 1
				i := i + 1
			end
			print_matrix (a)

				-- Horizontal
			from
				i := 1
			until
				i > 9
			loop
				a.put (i.out, 3, i)
				i := i + 1
			end
			print_matrix (a)

				-- Vertical
			from
				i := 1
			until
				i > 9
			loop
				a.put (i.out, i, 5)
				i := i + 1
			end
			print_matrix (a)


				-- Check that force works properly
			create b.make (4, 8)
			b.force (8, 6, 3)
		end

	print_matrix (a: ARRAY2 [STRING]) 
		local
			i, j, k, n: INTEGER
		do
			io.put_string ("Matrix [" + a.height.out + ", " + a.width.out + "]%N")
			from
				i := 1
				k := a.width
				n := a.height
			until
				i > n
			loop
				from
					j := 1
				until
					j > k
				loop
					io.put_string (a.item (i, j))
					if j /= k then
						io.put_character (' ')
					end
					j := j + 1
				end
				io.put_new_line
				i := i + 1
			end
			io.put_new_line
		end

end
