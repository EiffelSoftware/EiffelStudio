class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			l_ispec: SPECIAL [INTEGER_32]
			l_aspec: SPECIAL [ANY]
		do
			create l_ispec.make_filled (0, 10)
			l_aspec ?= l_ispec
			if l_aspec = Void then
				io.put_string ("NOT OK%N")
			end
		end

end
