class B
inherit
	A
		redefine
			some_string
		end

feature
	some_string: STRING is
		do
			Result := Precursor {A}
		end

end

