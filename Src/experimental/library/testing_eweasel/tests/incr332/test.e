
class TEST
inherit
	TEST1 [$TYPE]
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
		do
		end
	
end
