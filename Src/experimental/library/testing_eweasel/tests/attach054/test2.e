
class TEST2
inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature
        default_create
                do
			s := "Hamster"
                end

	to_string: STRING
		once
			Result := to_string
		end
	
	s: STRING

end
