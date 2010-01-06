class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t: !TUPLE [a: !STRING; b: !PROCEDURE [ANY, TUPLE]]
		do
			t := ["TOTO", agent do_nothing]
			print (t.generating_type)
			print ("%N")
		end

end
