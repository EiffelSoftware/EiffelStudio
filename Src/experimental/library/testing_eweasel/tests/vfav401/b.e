class B

feature -- Access

	item: BOOLEAN

feature -- Functions with different number of arguments

	f1 alias "$(OPERATOR)" (x: like Current): BOOLEAN is
		do
			Result := item $(OPERATOR) x.item
		end

end