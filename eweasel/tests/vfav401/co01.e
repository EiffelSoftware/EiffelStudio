class C

create

	make

feature {NONE} -- Creation

	make (value: BOOLEAN)
		do
			item := value
		end

feature

	item: BOOLEAN

	f alias "$(OPERATOR)" (x: like Current): BOOLEAN is
		do
			Result := item $(OPERATOR) x.item
		end

end