
class TEST
inherit
	TEST1 [INTEGER]
		redefine
			try
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
			print (a ~ False); io.new_line
			print (a ~ '%U'); io.new_line
			print (a ~ default_pointer); io.new_line
		end

end
