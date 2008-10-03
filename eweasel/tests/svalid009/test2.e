deferred class
	TEST2

feature

	list: LIST [TUPLE [a, b: INTEGER]]

	execute
        local
            l_list: like list
            i: INTEGER
        do
        	from
        		l_list.start
        	until
        		l_list.after
        	loop
				i := i + l_list.item.a
        		l_list.forth
        	end
		end

end
