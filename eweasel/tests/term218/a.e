class A [G -> detachable ANY]

feature -- Test

	f (x: G)
		local
			y: TEST
		do
			io.put_string ("Test 1: ")
			print (if out ~ out then x else y end)
			io.put_new_line

			io.put_string ("Test 2:")
			across <<x, y>> as c loop
				io.put_character (' ')
				io.put_integer (c.target_index)
				io.put_character (':')
				print (c.item)
			end
			io.put_new_line
		end

end
