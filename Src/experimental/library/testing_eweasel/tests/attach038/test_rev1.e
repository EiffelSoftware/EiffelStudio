
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
			if attached {TEST} (attached {ANY} Current as x) as X then
				print (x); io.new_line
			end
		end

end
