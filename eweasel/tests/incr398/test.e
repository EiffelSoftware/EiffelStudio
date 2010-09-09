
class TEST
inherit
	TEST2 [DOUBLE]
create
	make
feature
	make
		do
			print (a.b); io.new_line
		end

end
