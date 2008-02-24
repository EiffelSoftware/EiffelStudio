class TEST

create
	make

feature
	make is
		local
			ti: TEST1 [INTEGER]
			ts: TEST1 [STRING]
			tc: TEST1 [CHARACTER]
		do
			print (agent f (True))
			print (agent ti.f (5))
			print (agent ts.f ("ST"))
			print (agent tc.f ('c'))
		end

	f( b: like g) is
		do
		end

	g: BOOLEAN

end
