
class
	TEST

create
	make

feature

	make is
		local
			s: ARRAY [STRING]
		do
			s := ({ARRAY [STRING]} 'w');
			if s /= Void then
				print (s.count)
				io.new_line
			end
		end

end
