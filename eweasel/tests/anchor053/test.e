
class TEST
inherit
	TEST1 [PARENT]
create
	make
feature
	make
		do
			create a
			a.try
			create b
			b.try
		end

	a: TEST1 [CHILD]

	b: TEST2 [CHILD]

end

