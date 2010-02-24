class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			l_t1: TEST1 [detachable C]
			l_t2: TEST1 [attached C]
			l_t3: TEST1 [detachable A [detachable ANY]]
			l_t4: TEST1 [detachable A [attached ANY]]
			l_t5: TEST1 [attached A [detachable ANY]]
			l_t6: TEST1 [attached A [attached ANY]]
		do
			create l_t1.make (False)
			create l_t2.make (True)
			create l_t3.make (False)
			create l_t4.make (False)
			create l_t5.make (True)
			create l_t6.make (True)
		end

end
