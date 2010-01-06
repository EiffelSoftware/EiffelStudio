class TEST
create
	make

feature

	make is
		local
			s: like Current
		do
			s := t
			if s /= Void then
				io.put_string ("Major Error here%N")
			end
		end

	t: like Current
		do
		end

end
