class 
	RUNNER
inherit
	THREAD

create
	make

feature

	make (pm: PROXY [MUTEX]; i: INTEGER; n: INTEGER) is
		do
			proxy_mutex := pm
			id := i
			nb_loop := n
		end

feature

	proxy_mutex: PROXY [MUTEX]
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
				proxy_mutex.item.lock
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
				proxy_mutex.item.unlock
				cpt := cpt + 1
			end
		end

end  -- class RUNNER
