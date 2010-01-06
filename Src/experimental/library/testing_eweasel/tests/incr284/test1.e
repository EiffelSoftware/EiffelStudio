
class TEST1 [G -> TEST2 [STRING] create default_create end]
create
	default_create
feature
	try
		do
			create x.default_create
			print (x.out); io.new_line
			print (x.generator); io.new_line
			print (x.generating_type); io.new_line
		end

	x: G
end
