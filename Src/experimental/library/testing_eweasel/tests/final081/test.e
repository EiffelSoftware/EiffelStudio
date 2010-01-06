
class TEST
inherit
	TEST2
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

	value: INTEGER = 47
	
end
