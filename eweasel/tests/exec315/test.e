
class TEST

create
	make

feature

	make
		local
			t: TYPE [like Current]
			h, list: ARRAYED_LIST [TYPE [ANY]]
			count: INTEGER
		do
			t := {TEST}
			if t /= {TEST} then
				io.put_string ("Failure%N")
			end
			if t /= {TEST} then
				io.put_string ("Failure%N")
			end

			create h.make (10)
			h.extend ({LIST [ANY]})
			h.extend ({LIST [STRING]})
			h.extend ({LIST [INTEGER_8]})
			h.extend ({LIST [INTEGER_16]})
			h.extend ({LIST [INTEGER_32]})
			h.extend ({LIST [INTEGER_64]})
			h.extend ({LIST [NATURAL_8]})
			h.extend ({LIST [NATURAL_16]})
			h.extend ({LIST [NATURAL_32]})
			h.extend ({LIST [NATURAL_64]})
			h.extend ({LIST [POINTER]})
			h.extend ({LIST [REAL_32]})
			h.extend ({LIST [REAL_64]})
			h.extend ({LIST [CHARACTER_8]})
			h.extend ({LIST [CHARACTER_32]})

			h.extend ({LIST [ANY]})
			h.extend ({LIST [STRING]})
			h.extend ({LIST [INTEGER_8]})
			h.extend ({LIST [INTEGER_16]})
			h.extend ({LIST [INTEGER_32]})
			h.extend ({LIST [INTEGER_64]})
			h.extend ({LIST [NATURAL_8]})
			h.extend ({LIST [NATURAL_16]})
			h.extend ({LIST [NATURAL_32]})
			h.extend ({LIST [NATURAL_64]})
			h.extend ({LIST [POINTER]})
			h.extend ({LIST [REAL_32]})
			h.extend ({LIST [REAL_64]})
			h.extend ({LIST [CHARACTER_8]})
			h.extend ({LIST [CHARACTER_32]})


			from
				list := h.twin
				list.start
			until
				list.after
			loop
				from
					count := 0
					h.start
				until
					h.after
				loop
					if h.item = list.item then
						count := count + 1
					end
					h.forth
				end
				if count /= 2 then
					io.put_string ("Problem for " + list.item.out)
				end
				list.forth
			end
		end

end
