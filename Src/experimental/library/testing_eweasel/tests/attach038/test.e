
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
			if attached {ANY} Current as X then
				if attached {TEST} Current as x then
					print (x.n); io.new_line
				end
			end
		end

	n: INTEGER
end
