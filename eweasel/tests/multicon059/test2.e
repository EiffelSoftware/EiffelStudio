
class TEST2 [G -> {TEST3 rename default_create as hamster end, H, TEST4 rename weasel as stoat, default_create as turkey end} create default_create end, H]
feature
	try
		do
			print ((create {G}).weasel); io.new_line
		end

end

