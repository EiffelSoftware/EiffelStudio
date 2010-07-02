
class PARENT [G -> TEST2 create default_create end]
feature
	try
		do
			create x
			print (x.generating_type); io.new_line
		end
	
	x: like {G}.default
end
