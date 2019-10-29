class A

feature

	x: detachable like Current

	a: NATURAL_8

	b: like a = 1

	c: like a.item = 2
	
	d: like {like a}.item = 3

	e: like {like a.item}.item = 4

	f: like b = 5

	g: like x.a = 6

	h: like {like x}.a = 7

end
