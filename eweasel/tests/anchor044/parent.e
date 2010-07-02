
class PARENT [G -> TEST2 create default_create end]
feature
	try
		local
			x: like {G}.default
		do
			create x
			print (x.generating_type); io.new_line
		end
	
end
