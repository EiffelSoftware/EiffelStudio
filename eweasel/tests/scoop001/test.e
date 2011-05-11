class TEST

create
       make

feature {NONE} -- Creation

        make
		local
			a: separate A
		do
			create a.make (1)
			show (a)
			advance (a)
			show (a)
			wait (a)
			(create {EXCEPTIONS}).die (0)
		end

feature -- Output

	show (a: separate A)
		do
			io.put_integer (a.item)
			io.put_character (':')
			io.put_integer (a.next)
			io.put_new_line
		end

feature -- Modification

	advance (a: separate A)
		do
			a.advance
		end

feature -- Waiting

	wait (a: separate A)
		local
			r: REAL_64
		do
			r := a.real_value
		end

end
