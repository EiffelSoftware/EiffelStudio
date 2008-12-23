
class TEST
create
	make

feature

	make
		do
			try
		end

feature

	try
		do
			if {X: TEST} {x: ANY} Current then
				print (x); io.new_line
			end
		end

end
