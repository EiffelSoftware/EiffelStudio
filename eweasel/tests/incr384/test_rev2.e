
class TEST
inherit
	TEST1 [INTEGER]
		redefine
			try, weasel
		end
create
	make
feature
	
	make
		do
			try
		end

	try
		do
			precursor
		end

	weasel (a: INTEGER b: INTEGER)
		do
			print (a.out + " " + b.out + "%N")
		end
	
end
