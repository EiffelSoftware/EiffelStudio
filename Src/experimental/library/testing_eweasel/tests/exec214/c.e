class C
inherit
	B
		redefine c, e end
feature
	c: B
	e: B assign set_e
end