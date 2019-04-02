class AA

create

	make

feature

	make
		local
			cc2: CC2
			zz1: ZZ1
			zz3: ZZ3
		do
			create cc2
			create zz1
			create zz3
			f (zz1)
			f (zz3)
			f (cc2.x.zz)
		end

	f (z1: ZZ1)
		do
			print (z1.foo)
		end

end
