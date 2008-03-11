
class MY_STRING
inherit
	STRING
		redefine
			has, extend
		end

create
	make, make_from_string

feature
	has (c: CHARACTER): BOOLEAN
		do
			Result := Precursor (c)
		end

	extend (c: CHARACTER)
		do
			Precursor (c)
		end

end
