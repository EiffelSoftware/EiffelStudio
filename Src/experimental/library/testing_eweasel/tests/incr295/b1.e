class
	B

inherit
	A
		rename g as g1
		redefine g1
		select g1
		end

	A
		rename f as f1 -- This should raise a VMCS warning if f is not replicated.
		select f1
		end

create
	make

feature
	make
		do
			f
			f1
		end

feature

	g1: STRING do Result := "g1%N" end

end
