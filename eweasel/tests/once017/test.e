
class TEST
create
	make
feature
	make
		local
			tried: BOOLEAN
		do
			if not tried then
				create b
				print (b.to_val1); io.new_line
			end
		rescue
			tried := True
			retry
		end

	b: TEST2

end
