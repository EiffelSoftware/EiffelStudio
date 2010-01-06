class 
	TEST

inherit
	PLATFORM

create
	make
feature
	
	make is 
		local
			p: POINTER
			s: STRING
		do
			p := p + 0x7FFFFFFF
			p := p + 0x7FFFFFFF
			p := p + 0x7FFFFFFF
			p := p + 0x7FFFFFFF
			s := p.out
			if pointer_bytes = 4 then
				io.put_boolean (s.is_equal ("0xFFFFFFFC"))
			else
				io.put_boolean (s.is_equal ("0x1FFFFFFFC"))
			end
			io.new_line
		end;

end

