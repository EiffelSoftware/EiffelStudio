class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a, b: separate A
			r: REAL_64
		do
			create a.make (1)
			separate a as x do
				io.put_integer (x.item)
				io.put_character (':')
				io.put_integer (x.next)
				io.put_new_line
			end
			separate a as x do
				x.advance
			end
			separate a as x do
				io.put_integer (x.item)
				io.put_character (':')
				io.put_integer (x.next)
				io.put_new_line
			end
			separate a as x do
				r := x.real_value
			end
				-- Check that there are no deadlocks as soon as both processors get controlled together.
			create b.make (5)
			separate a as x, b as y do
				x.copy_from (y)
			end
			separate a as x, b as y do
					-- Because `b' is now controlled the next instruction has no effect and both processors should be still controlled.
				separate b as z do
					z.copy_from (x)
				end
			end
			separate a as x do
				io.put_integer (x.item)
				io.put_character (':')
				io.put_integer (x.next)
				io.put_new_line
			end
			separate a as x do
				x.advance
			end
			separate b as y do
				y.copy_from (a)
			end
			separate b as x do
				io.put_integer (x.item)
				io.put_character (':')
				io.put_integer (x.next)
				io.put_new_line
			end
		end

end
