
class TEST
create
        make

feature
	make
		do
			try1
			try2
		end

	try1
		once
			print ("Ermine"); io.new_line
		end

	try2
		once
			{TEST1}.weasel
		end

end

