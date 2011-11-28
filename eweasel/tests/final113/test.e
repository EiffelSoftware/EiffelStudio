
class TEST
inherit
	TEST1
		redefine
			value
		end

create
       make
feature

	make
		do
			try
		end

	value: ANY
		attribute 
			Result := "Hamster"
		end
end

