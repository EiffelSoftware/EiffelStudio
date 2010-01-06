class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			l: LIST [INTEGER]
			i: INTEGER
		do
			from i := 1 until i > 2 loop
				inspect
					i
				when 1 then
					create {LINKED_LIST [INTEGER]} l.make
				when 2 then
					create {ARRAYED_LIST [INTEGER]} l.make (5)
				end
				l.extend (1)
				l.extend (2)
				l.extend (3)
				from l.start until l.after loop
					l.replace (l.item + 1)
					Io.put_integer (l.item)
					Io.put_new_line
					l.forth
				end
				i := i + 1
			end
		end

end -- class TEST
