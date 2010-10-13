class TEST

create
	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
		local
			count: INTEGER
			l_thread_1, l_thread_2: WORKER_THREAD
		do
			count := args.item (1).to_integer
			create l_thread_1.make (agent generate_collections (count))
			create l_thread_2.make (agent check_catcalls (2 * count))
			l_thread_1.launch
			l_thread_2.launch
			l_thread_1.join
			l_thread_2.join
		end

	check_catcalls (n: INTEGER)
		local
			b: BOOLEAN
			i: INTEGER
		do
			from
				i := 0
			until
				i > n
			loop
				b := f ("s")
				i := i + 1
			end
		end

	f (s: STRING): BOOLEAN
		do
		end

	generate_collections (n: INTEGER)
		local
			i: INTEGER
			mem: MEMORY
		do
			from
				create mem
				i := 0
			until
				i > n
			loop
				mem.collect
				mem.full_collect
				i := i + 1
			end
		end

end
