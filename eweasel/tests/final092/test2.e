

class TEST2 [G -> TEST3 [ANY] create default_create end]
feature
	try
		do
			print ((create {G}).weasel); io.new_line
		end

end

