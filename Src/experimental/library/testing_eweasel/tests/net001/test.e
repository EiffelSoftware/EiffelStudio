class 
	TEST

create
	make

feature
	
	make is 
		local
			s: NETWORK_STREAM_SOCKET
			i: INTEGER
		do

			from
				i := 1
			until
				i = 100000
			loop
				create s.make
				s.dispose
				i := i + 1
			end
		end

end

