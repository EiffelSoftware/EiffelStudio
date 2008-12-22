
class TEST

create
	make
feature
	
	make
		local
			val, entry: TEST2
		do
			val := entry.deep_twin
			print (val.a); io.new_line
			print (val.b); io.new_line
			print (val.c); io.new_line
			print (val.d); io.new_line
			print (val.e); io.new_line
			print (val.f); io.new_line
			print (val.g); io.new_line
		end

end
