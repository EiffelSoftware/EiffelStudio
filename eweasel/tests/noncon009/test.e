class TEST

inherit {NONE}
	PARENT_CLASS

create
	make

feature
	make
		local
			p: PARENT_CLASS
		do
			io.put_integer (f)
			io.put_integer (p.f)
			io.put_new_line
		end
end 
