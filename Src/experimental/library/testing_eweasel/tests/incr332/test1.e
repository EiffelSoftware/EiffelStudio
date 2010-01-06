
class TEST1 [G -> $TYPE]
inherit
	TEST2
		redefine
			value
		end
feature

	value: G
		do
		end
	
	try
		do
			print ((agent {like Current}.value).item ([Current])); io.new_line
		end

end
