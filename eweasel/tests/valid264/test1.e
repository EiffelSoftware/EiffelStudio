
class TEST1 [G -> TEST2 rename weasel as stoat alias "#" end create default_create end]
feature
	try
		local
			x: G
		do
			create x
			io.put_integer (# x); io.new_line
		end
	
end
