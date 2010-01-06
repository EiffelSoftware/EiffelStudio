class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			l_t1: TEST1 [?STRING]
		do
			create {TEST2 [?STRING]} l_t1.make
			l_t1.test_formals (Void, Void, Void)
			l_t1.test_formals ("", "", "")
			l_t1.test_anchors_1 (Void, "", Void)
			l_t1.test_anchors_2 (Void, "", Void)

			create {TEST2 [!STRING]} l_t1.make
			l_t1.test_formals (Void, Void, Void)
			l_t1.test_formals ("", "", "")
		end

end
