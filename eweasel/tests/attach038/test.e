
class TEST
create
	make

feature {NONE}

	make
		do
			try
		end

feature

	try
		do
			if {X: ANY} Current then
				if {x: TEST} Current then
					print (x.n); io.new_line
				end
			end
		end

	n: INTEGER
end
