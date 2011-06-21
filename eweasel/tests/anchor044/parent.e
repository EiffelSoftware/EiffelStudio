
class PARENT [G -> TEST2 create default_create end]
feature
	try
		local
			x: like {G}.default
			y: like f.default
		do
			create x
			create y
			print (x.generating_type); io.new_line
			print (y.generating_type); io.new_line
		end

	f: G
		do
		end
	
end
