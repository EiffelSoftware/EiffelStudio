note
	description: "Summary description for {B}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B

inherit
	A
	rename
		foo as bla
	end


feature

	foo: INTEGER
		do
			a2.foo
			bla
			b.a2.foo
			Result := b.foo
			Result := blu
		end

	a2: A
		do

		end

	b: B

	blu: INTEGER
		do

		end
end
