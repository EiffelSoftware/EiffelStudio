
class TEST2
inherit
	TEST3 [STRING]
		redefine
			weasel
		end

create
	default_create
feature
		
	weasel: STRING
		do
			Result := precursor
		end
end
