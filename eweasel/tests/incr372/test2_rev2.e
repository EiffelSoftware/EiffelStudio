
class TEST2 [G -> TEST3, H -> ANY create default_create end]

feature
	a: like {G}.default
	
	try
		do
			print ({G}.weasel); io.new_line
		end

end

