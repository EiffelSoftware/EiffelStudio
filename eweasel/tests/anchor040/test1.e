
class TEST1 [G -> ANY create default_create end]
feature

	try
		do
			create x
			print (x.generating_type); io.new_line
		end

	x: G

end
