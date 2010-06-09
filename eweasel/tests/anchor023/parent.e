
class PARENT [G -> ANY create default_create end]

feature
	
	try
		do
			create w
			print (w.generating_type); io.new_line
		end

	x: G

	z: like x

	w: like {PARENT [DOUBLE]}.z

end
