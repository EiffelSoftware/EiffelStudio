class 
	RUNNER
inherit
	THREAD

create
	make

feature

	make (m: MUTEX; i: INTEGER; n: INTEGER) is
		do
			mutex := m
			id := i
			nb_loop := n
		end

feature

	mutex: MUTEX
	id, nb_loop: INTEGER

	execute is
		local
			i, cpt: INTEGER
		do
			from
				cpt := 1
			until
				cpt > nb_loop
			loop
				mutex.lock
				from 
					io.putstring("|")
					i := 0
				until
					i > cpt
				loop
					io.putstring("-")
					i := i + 1
				end
				io.putint(id)
				io.putstring("%N")
				mutex.unlock
				cpt := cpt + 1
			end
		end

end  -- class RUNNER
