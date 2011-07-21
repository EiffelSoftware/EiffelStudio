class TEST

inherit
	THREAD
	MEMORY
	ARGUMENTS

create
	make,
	default_create

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
				create l_root
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
