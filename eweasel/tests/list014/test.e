class TEST
create
	make
feature
	make is
		local
			tw1, tw2, temp: TWO_WAY_LIST [STRING]
		do
			create tw1.make
			tw1.extend ("foo")
			tw1.extend ("bar")
			tw1.start
			tw1.forth

			create tw2.make
			tw2.extend ("foo1")
			tw2.extend ("bar1")

			temp := tw1.twin
			temp.merge_left (tw2)
			temp.merge_right (tw2)

			from
				temp.start
			until
				temp.after
			loop
				io.put_string (temp.item)
				io.put_new_line
				temp.forth
			end
		end

end
