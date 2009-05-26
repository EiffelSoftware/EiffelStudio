
class TEST
inherit
	TEST2
		redefine
			make, value
		end

create
	make
feature
	make
		do
			create x.make
			precursor
			try
		end

	x: TEST2

	value: STRING
		attribute
			Result := "weasel"
		end
	
end
