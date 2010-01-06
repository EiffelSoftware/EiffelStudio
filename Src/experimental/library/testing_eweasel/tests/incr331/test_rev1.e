
class TEST
inherit
	TEST1 [DOUBLE]
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

	value: DOUBLE
		external "C inline"
		alias "13.0"
		end
	
end
