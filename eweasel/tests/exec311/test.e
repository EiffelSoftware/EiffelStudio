class TEST
create
	make
feature
	make is
		local
			s: STRING
		do
			create s.make_from_string ("Test")
			s.append_integer (5)
		end

end
