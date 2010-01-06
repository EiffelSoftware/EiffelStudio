class C

inherit
	B
		rename
			f1 as f alias "$(OPERATOR)"
		end

create

	make

feature {NONE} -- Creation

	make (value: BOOLEAN)
		do
			item := value
		end

end