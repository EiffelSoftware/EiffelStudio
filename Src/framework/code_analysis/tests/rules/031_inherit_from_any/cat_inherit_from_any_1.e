class
	CAT_INHERIT_FROM_ANY_1

inherit
	ANY
		undefine
			out
		end

feature {NONE} -- Test

	out: STRING
	do
		Result := "42"
	end

end
