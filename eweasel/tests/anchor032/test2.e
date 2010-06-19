
class TEST2 [G -> TEST3]
feature
	try
		do
			create x
			print (x.generating_type); io.new_line
			print (x.n); io.new_line
			create {like {G}.weasel} x
			print (x.generating_type); io.new_line
			print (x.n); io.new_line
		end
	
	x: like {G}.weasel
	
end
