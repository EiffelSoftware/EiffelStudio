class TEST

inherit
	THREAD
		rename
			make as thread_make
		end
	ARGUMENTS

create
	make,
	thread_make

feature
	make
		local
			i, nb: INTEGER
			l_root: TEST
			l_worker_thread: WORKER_THREAD
		do
			nb := argument (1).to_integer
			create l_worker_thread.make (agent f (nb))
			l_worker_thread.launch

			from
				i := 0
			until
				i = nb
			loop
				create l_root.thread_make
				l_root.launch
				i := i + 1
			end
		end

	execute
		do
			f (1)
		end

	f (nb: INTEGER)
		local
			i: INTEGER
		 do
			from
				i := 0
			until
				i = nb
			loop
				g
				i := i + 1
			end
		 end

	g do h end
	h do k end
	k do end

end
