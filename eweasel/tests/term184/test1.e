
class TEST1 [G -> ANY rename default_create as weasel end create weasel end]
feature
	try
		local
			x: G
		do
			create x.weasel
		     	print (x.generating_type); io.new_line
		end

end

