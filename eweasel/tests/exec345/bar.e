class BAR
inherit
	FOO
		redefine
			attr
		end
feature

	attr: detachable Y

	g
		local
			t: like t_attr
			u: like attr
		do
			t := t_attr
			if t /= Void then
				u := t.uu
				if u /= Void then
					u.zzz
				end
			end
		end

end
