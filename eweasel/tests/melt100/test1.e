
class TEST1 [G -> HASHABLE create default_create end]
feature
	try
		local
			b: HASHABLE
	       do
			create {G} b
			print (b.generating_type); io.new_line
	       end

end

