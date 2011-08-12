class FOO

feature

	f
		local
			l_attr: like attr
		do
			create attr
			l_attr := attr
			if attached ([attr]) as l_tuple then
				print (l_tuple.generating_type.out)
				io.put_new_line
			end
			if attached ([l_attr]) as l_tuple then
				print (l_tuple.generating_type.out)
				io.put_new_line
			end
			t_attr := ([attr])
		end

	attr: detachable X
	t_attr: detachable TUPLE [uu: like attr]

end
