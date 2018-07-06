class TEST

inherit
	A
		redefine
			parenthesis,
			this
		end

create

	make

feature {NONE} -- Creation

	make
		local
			a: ARRAY [BOOLEAN]
			t: like Current
		do
			t := Current
			a := <<>>
			parenthesis (<<>>)
			;(plus (<<>>)).do_nothing
			t.parenthesis (<<>>)
			(t).parenthesis (<<>>)
			;(Current.plus (<<>>)).do_nothing
			;(Current + <<>>).do_nothing
			;(Current [<<>>]).do_nothing
			t (<<>>)
			if attached default as x then x (<<>>) end
			separate create {separate TEST}.make as x do x (<<>>) end
			;(agent (x: TEST) do x (<<>>) end (Current)).do_nothing
			a.do_nothing
		end

feature

	plus alias "+" (other: ARRAY [BOOLEAN]): TEST
		do
			Result := Current
		end

	item alias "[]" (other: ARRAY [BOOLEAN]): TEST
		do
			Result := Current
		end

	parenthesis alias "()" (other: ARRAY [BOOLEAN])
		do
			Precursor (<<>>)
		end

	this: like Current
		do
			Precursor (<<>>)
			Result := Precursor
		end

end
