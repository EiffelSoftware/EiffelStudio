indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A

feature
	f is
		do
			c := Current
			print (c.s)
		ensure
			equal ((agent c.s).item ([]), "hello")
		end

	c: like Current
	s: STRING is
		do
			Result := "hello"
		end

end
