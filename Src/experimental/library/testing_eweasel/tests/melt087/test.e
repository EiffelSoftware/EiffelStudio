
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
		local
			s: STRING
		do
			s := value
			print ("All done%N")
		end

	value: STRING
		require else
			good: True
		once
			Result := ""
		end

end

