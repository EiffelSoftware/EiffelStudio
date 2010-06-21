
class TEST2 [G -> ANY create default_create end]
feature

	try
		do
			create y
			print (y.generating_type); io.new_line
		end

	y: G

end
