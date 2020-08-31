class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t: attached TUPLE [a: attached STRING; b: attached PROCEDURE]
		do
			t := ["TOTO", agent do_nothing]
			print (t.generating_type)
			print ("%N")
		end

end
