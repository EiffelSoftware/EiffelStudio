class TEST

create

	make

feature

	make
		local
			a: A [attached ANY]
			x: attached ANY
		do
			create a
			x := a.f
			if x = Void then
				io.output.put_string ("x = Void%N")
			end
		end

end
