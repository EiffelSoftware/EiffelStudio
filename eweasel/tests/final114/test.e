
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
			try
		end

	try
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
				     print (across list as d some d.item = 29 end); io.new_line
				     print (across list as c all c.item = 47 end); io.new_line
				     n := n + 1
				end
				k := k + 1
			end
		end

	list: ARRAYED_LIST [INTEGER]

end
