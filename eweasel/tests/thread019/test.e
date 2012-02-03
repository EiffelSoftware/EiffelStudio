class TEST

inherit
	THREAD
		rename
			make as thread_make
		end
	MEMORY
	ARGUMENTS

create
	make,
	thread_make

feature
	make
		local
			i, nb: INTEGER
			l_root: TEST
		do
			from
				i := 0
				nb := argument (1).to_integer
			until
				i = nb
			loop
				create l_root.thread_make
				l_root.launch
				l_root.join
				i := i + 1
			end
		end

	execute
		do
			collect
		end

end
