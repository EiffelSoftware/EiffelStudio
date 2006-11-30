class TEST

inherit
	THREAD_CONTROL

create
	make

feature

	make is
			-- Run test.
		local
			a: A
			b: B
			c: C
			s: SEMAPHORE
		do
			create a.make (1)
			join_all
			create a.make (2)
			join_all
			create b.make (3)
			join_all
			create b.make (4)
			join_all
			create s.make (0)
			create c.make (6, true, s)
			create c.make (5, false, s)
			s.post
			s.post
			join_all
		end

end