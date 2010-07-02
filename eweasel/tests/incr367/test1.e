
class TEST1 [H -> TEST2 create default_create end]
feature
	try
		local
			x: like a
		do
			create x
			print (x.generating_type); io.new_line
		end
	
	a: like c

	c: H

end
