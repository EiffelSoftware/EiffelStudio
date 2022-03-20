class A

feature

	f (a: like g)
		local
			x: like a
		do
			x := a
		end

	g: detachable TEST
		do
		end

end
