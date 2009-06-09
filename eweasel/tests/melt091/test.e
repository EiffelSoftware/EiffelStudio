class TEST

create
	make


feature

	make
		local
			s: STRING
			a: ROUTINE [ANY, TUPLE]
		do
			s := "$VALUE"
			s := once "$VALUE"
			a := agent print
		end
	
end
