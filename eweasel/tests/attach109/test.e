class TEST

create
	make

feature

	make
		local
			s: STRING
		do
			s :=
				if attached Current as c then
					c.out
				else
					out
				end
			s :=
				if not attached Current as c then
					out
				else
					c.out
				end
			s :=
				if attached Current as c then
					c.out
				elseif attached Current as x then
					x.out
				else
					out
				end
			s :=
				if not attached Current as c then
					out
				elseif not attached Current as x then
					out.out
				else
					(c = x).out
				end
		end

end