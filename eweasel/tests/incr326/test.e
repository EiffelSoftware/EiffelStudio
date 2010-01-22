note
	version: $VERSION

class TEST

create
	make

feature
	make
		local
			t: TEST1
		do
			create t.make
		end

end
