
class TEST1 [G -> STRING rename count as substring end create make end]
feature
	make
		do
			create x.make (0)
			print (x.substring); io.new_line
		end

	x: G
end
