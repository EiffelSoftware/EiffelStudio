class TEST

create
	make

feature

	make is
		local
			l_a: ARRAY [BOX [INTEGER]]
		do
			if {PLATFORM}.is_dotnet then
				p (l_a.to_cil)
			end
		end


	p (a: NATIVE_ARRAY [ANY]) is
		do
		end

end
