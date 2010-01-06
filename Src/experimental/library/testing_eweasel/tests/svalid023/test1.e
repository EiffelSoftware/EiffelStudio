class TEST1
feature

	g
		local
			l_a: detachable A
			l_target: like a
		do
			create l_target
			l_target.f (l_a)
		end

	a: detachable A

end
