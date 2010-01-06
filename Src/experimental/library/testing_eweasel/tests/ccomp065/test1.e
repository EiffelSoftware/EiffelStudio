
class TEST1 [G -> {NUMERIC rename identity as weasel end, ANY rename out as out alias "+" end }]
create
	make

feature {NONE}

	make is
		local
			s: STRING
		do
			s := +x
			s := +x
--			print (+x)
--			print (y.out)
		end

	x: G

	y: DOUBLE


end
