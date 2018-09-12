
class TEST
create
	make
feature
	make
		do
			create list.make (5)
			list.extend (47)
			list.extend (29)
			list.extend (13)
			try_as
			try_is
		end

	try_as
		local
			k, n: INTEGER
		do
			from
				k := 1
			until
				k > 2
			loop
				from 
				     n := 1 
				until n > 3 loop
				     print (across list as d some d.item = 29 end)
				     io.put_new_line
				     print (across list as c all c.item = 47 end)
				     io.put_new_line
				     n := n + 1
				end
				k := k + 1
			end
		end

	try_is
		local
			k, n: INTEGER
		do
			from
				k := 1
			until
				k > 2
			loop
				from 
				     n := 1 
				until n > 3 loop
				     print (across list is d some d = 29 end)
				     io.put_new_line
				     print (across list is c all c = 47 end)
				     io.put_new_line
				     n := n + 1
				end
				k := k + 1
			end
		end

	list: ARRAYED_LIST [INTEGER]

end
