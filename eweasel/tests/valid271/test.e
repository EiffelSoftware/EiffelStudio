class TEST
create
	make
feature
	
	make
		local
			s: TEST1 [STRING]
			f: TEST1 [RAW_FILE]
		do
			create s.make
			create f.make
		end

end
