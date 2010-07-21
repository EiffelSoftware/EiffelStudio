
class TEST
 
create
    make
 
feature
 
    make
		local
			b: BOOLEAN
		do
			b := False
			print (b.hash_code); io.new_line
			b := True
			print (b.hash_code); io.new_line
		end

end
