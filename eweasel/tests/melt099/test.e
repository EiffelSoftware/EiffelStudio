
class TEST

create
        make

feature
        make
                do
                        foo.do_nothing
                end

	foo: TUPLE [INTEGER, INTEGER]
		do
			Result := [one, two]
		end

	one: INTEGER
		do
			print ("1%N")
		end

	two: INTEGER
		do
			print ("2%N")
		end
end

