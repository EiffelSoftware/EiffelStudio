class C

inherit
	B
		redefine
			f1
		end

create

	make

feature {NONE} -- Creation

	make (value: BOOLEAN)
		do
			item := value
		end

feature

	f1 alias "$(OPERATOR)" (x: like Current): BOOLEAN is
		do
			Result := item $(OPERATOR) x.item
		end

end