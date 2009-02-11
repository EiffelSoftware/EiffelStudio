
class TEST3
inherit
	TEST2
		redefine
			set_s
		end
create
	default_create

feature
	set_s
		do
			s := hamster
		end
	
	hamster: STRING
		attribute
			Result := "Turkey"
		end

end
