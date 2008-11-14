class TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l: LINKED_LIST [!TUPLE [a: !STRING; b: !PROCEDURE [ANY, TUPLE]]]
		do
			create l.make
			l.extend (["TOTO", agent do_nothing])
			print (l.first.generating_type)
			print ("%N")
		end

end
