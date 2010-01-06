
class TEST2 [G -> {TEST rename default_create as default_weasel end, TEST} create default_create end]
 
feature
	try
		do
			create a
			print (a.value (3)); io.new_line
		end
 
 	a: G
end