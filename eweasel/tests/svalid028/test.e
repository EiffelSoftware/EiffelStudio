
class TEST
inherit
	TEST1 [TEST2]

create
	make
feature

	make
		do
			create a
			a.try
			try
		end
	
	a: TEST1 [TEST2]

	
end
