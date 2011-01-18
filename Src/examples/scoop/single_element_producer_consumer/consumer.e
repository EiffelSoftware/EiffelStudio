class CONSUMER

create
	make

feature

	prod: separate PRODUCER

 	make (a_p: separate PRODUCER)
		do
			prod := a_p
		end

	run
		do
			from
			until
				False
			loop
				take (prod)
			end
		end

feature {NONE}
	
	take (a_p: separate PRODUCER)
		require
			producer_ready: a_p.has_something
		local
			i: INTEGER
		do
			i := a_p.get_something
			io.put_string ("Consumed: " + i.out + "%N")
		end

end
