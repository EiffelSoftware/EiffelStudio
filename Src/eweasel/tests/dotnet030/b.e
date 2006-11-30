class B 
inherit A

create make
feature
	make is
		do
			print ("Agents output: " + f.item ([]))
			io.new_line
		end


end
