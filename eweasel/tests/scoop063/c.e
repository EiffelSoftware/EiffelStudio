class C [G]

create
	make

feature {NONE} -- Creation

	make
		local
			a1: A [G, G, G]
			a2: A [separate G, G, G]
			a3: A [G, separate G, G]
			a4: A [separate G, separate G, G]
			a5: A [G, G, separate G]
			a6: A [separate G, G, separate G]
			a7: A [G, separate G, separate G]
			a8: A [separate G, separate G, separate G]
		do
			create a1
			create a2
			create a3
			create a4
			create a5
			create a6
			create a7
			create a8

			assert (attached {A [ANY, ANY, ANY]} a1)
			assert (not attached {A [ANY, ANY, ANY]} a2)
			assert (not attached {A [ANY, ANY, ANY]} a3)
			assert (not attached {A [ANY, ANY, ANY]} a4)
			assert (not attached {A [ANY, ANY, ANY]} a5)
			assert (not attached {A [ANY, ANY, ANY]} a6)
			assert (not attached {A [ANY, ANY, ANY]} a7)
			assert (not attached {A [ANY, ANY, ANY]} a8)

			assert (attached {A [separate ANY, ANY, ANY]} a1)
			assert (attached {A [separate ANY, ANY, ANY]} a2)
			assert (not attached {A [separate ANY, ANY, ANY]} a3)
			assert (not attached {A [separate ANY, ANY, ANY]} a4)
			assert (not attached {A [separate ANY, ANY, ANY]} a5)
			assert (not attached {A [separate ANY, ANY, ANY]} a6)
			assert (not attached {A [separate ANY, ANY, ANY]} a7)
			assert (not attached {A [separate ANY, ANY, ANY]} a8)

			assert (attached {A [ANY, separate ANY, ANY]} a1)
			assert (not attached {A [ANY, separate ANY, ANY]} a2)
			assert (attached {A [ANY, separate ANY, ANY]} a3)
			assert (not attached {A [ANY, separate ANY, ANY]} a4)
			assert (not attached {A [ANY, separate ANY, ANY]} a5)
			assert (not attached {A [ANY, separate ANY, ANY]} a6)
			assert (not attached {A [ANY, separate ANY, ANY]} a7)
			assert (not attached {A [ANY, separate ANY, ANY]} a8)

			assert (attached {A [separate ANY, separate ANY, ANY]} a1)
			assert (attached {A [separate ANY, separate ANY, ANY]} a2)
			assert (attached {A [separate ANY, separate ANY, ANY]} a3)
			assert (attached {A [separate ANY, separate ANY, ANY]} a4)
			assert (not attached {A [separate ANY, separate ANY, ANY]} a5)
			assert (not attached {A [separate ANY, separate ANY, ANY]} a6)
			assert (not attached {A [separate ANY, separate ANY, ANY]} a7)
			assert (not attached {A [separate ANY, separate ANY, ANY]} a8)

			assert (attached {A [ANY, ANY, separate ANY]} a1)
			assert (not attached {A [ANY, ANY, separate ANY]} a2)
			assert (not attached {A [ANY, ANY, separate ANY]} a3)
			assert (not attached {A [ANY, ANY, separate ANY]} a4)
			assert (attached {A [ANY, ANY, separate ANY]} a5)
			assert (not attached {A [ANY, ANY, separate ANY]} a6)
			assert (not attached {A [ANY, ANY, separate ANY]} a7)
			assert (not attached {A [ANY, ANY, separate ANY]} a8)

			assert (attached {A [separate ANY, ANY, separate ANY]} a1)
			assert (attached {A [separate ANY, ANY, separate ANY]} a2)
			assert (not attached {A [separate ANY, ANY, separate ANY]} a3)
			assert (not attached {A [separate ANY, ANY, separate ANY]} a4)
			assert (attached {A [separate ANY, ANY, separate ANY]} a5)
			assert (attached {A [separate ANY, ANY, separate ANY]} a6)
			assert (not attached {A [separate ANY, ANY, separate ANY]} a7)
			assert (not attached {A [separate ANY, ANY, separate ANY]} a8)

			assert (attached {A [ANY, separate ANY, separate ANY]} a1)
			assert (not attached {A [ANY, separate ANY, separate ANY]} a2)
			assert (attached {A [ANY, separate ANY, separate ANY]} a3)
			assert (not attached {A [ANY, separate ANY, separate ANY]} a4)
			assert (attached {A [ANY, separate ANY, separate ANY]} a5)
			assert (not attached {A [ANY, separate ANY, separate ANY]} a6)
			assert (attached {A [ANY, separate ANY, separate ANY]} a7)
			assert (not attached {A [ANY, separate ANY, separate ANY]} a8)

			assert (attached {A [separate ANY, separate ANY, separate ANY]} a1)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a2)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a3)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a4)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a5)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a6)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a7)
			assert (attached {A [separate ANY, separate ANY, separate ANY]} a8)
		end
		

	assert (b: BOOLEAN)
			-- Report whether test `i' is successful according to `b'.
		do
			if not b then
				io.put_string ("Test in class C #")
				io.put_integer (counter.item)
				io.put_string (": ")
				io.put_string ("FAILED")
				io.put_character ('.')
				io.put_new_line
			end
			counter.put (counter.item + 1)
		end

	counter: CELL [INTEGER]
		once
			create Result.put (1)
		end

end
