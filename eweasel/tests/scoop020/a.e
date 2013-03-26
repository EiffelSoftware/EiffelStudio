class A [G, H -> TEST]

create
	make

feature {NONE} -- Creation

	make (x: attached G; y: attached H)
		do
			g := x
			sg := x
			ag := x
			asg := x
			a := y
			sa := y
			h := y
			sh := y
			ah := y
			ash := y
		end

feature

	fg (x: G)
		do
			g   := x
			sg  := x
			ag  := x -- Error
			asg := x -- Error
			dg  := x
			dsg := x
			a   := x -- Error
			sa  := x -- Error
			da  := x -- Error
			dsa := x
		end

	fsg (x: separate G)
		do
			g   := x -- Error
			sg  := x
			ag  := x -- Error
			asg := x -- Error
			dg  := x -- Error
			dsg := x
			a   := x -- Error
			sa  := x -- Error
			da  := x -- Error
			dsa := x
		end

	fag (x: attached G)
		do
			g   := x
			sg  := x
			ag  := x
			asg := x
			dg  := x
			dsg := x
			a   := x -- Error
			sa  := x
			da  := x -- Error
			dsa := x
		end

	fasg (x: attached separate G)
		do
			g   := x -- Error
			sg  := x
			ag  := x -- Error
			asg := x
			dg  := x -- Error
			dsg := x
			a   := x -- Error
			sa  := x
			da  := x -- Error
			dsa := x
		end

	fdg (x: detachable G)
		do
			g   := x -- Error
			sg  := x -- Error
			ag  := x -- Error
			asg := x -- Error
			dg  := x
			dsg := x
			a   := x -- Error
			sa  := x -- Error
			da  := x -- Error
			dsa := x
		end

	fdsg (x: detachable separate G)
		do
			g   := x -- Error
			sg  := x -- Error
			ag  := x -- Error
			asg := x -- Error
			dg  := x -- Error
			dsg := x
			a   := x -- Error
			sa  := x -- Error
			da  := x -- Error
			dsa := x
		end

	fh (x: H)
		do
			h   := x
			sh  := x
			ah  := x
			ash := x
			dh  := x
			dsh := x
			a   := x
			sa  := x
			da  := x
			dsa := x
		end

	fsh (x: separate H)
		do
			h   := x -- Error
			sh  := x
			ah  := x -- Error
			ash := x
			dh  := x -- Error
			dsh := x
			a   := x -- Error
			sa  := x
			da  := x -- Error
			dsa := x
		end

	fah (x: attached H)
		do
			h   := x
			sh  := x
			ah  := x
			ash := x
			dh  := x
			dsh := x
			a   := x
			sa  := x
			da  := x
			dsa := x
		end

	fash (x: attached separate H)
		do
			h   := x -- Error
			sh  := x
			ah  := x -- Error
			ash := x
			dh  := x -- Error
			dsh := x
			a   := x -- Error
			sa  := x
			da  := x -- Error
			dsa := x
		end

	fdh (x: detachable H)
		do
			h   := x -- Error
			sh  := x -- Error
			ah  := x -- Error
			ash := x -- Error
			dh  := x
			dsh := x
			a   := x -- Error
			sa  := x -- Error
			da  := x
			dsa := x
		end

	fdsh (x: detachable separate H)
		do
			h   := x -- Error
			sh  := x -- Error
			ah  := x -- Error
			ash := x -- Error
			dh  := x -- Error
			dsh := x
			a   := x -- Error
			sa  := x -- Error
			da  := x -- Error
			dsa := x
		end

	f (x: G; y: separate G)
		do
		end

feature {NONE} -- Access

	g: G
	sg: separate G
	ag: attached G
	asg: attached separate G
	dg: detachable G
	dsg: detachable separate G
	
	a: ANY
	da: detachable ANY
	sa: separate ANY
	dsa: detachable separate ANY

	h: H
	sh: separate H
	ah: attached H
	ash: attached separate H
	dh: detachable H
	dsh: detachable separate H

end