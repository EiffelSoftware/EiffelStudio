
class TEST
inherit
	TEST1 [INTEGER]
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

	value: INTEGER
		external "C inline"
		alias "47"
		end
	
end
