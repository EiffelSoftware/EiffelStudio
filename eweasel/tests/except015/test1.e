class TEST1
inherit	
	EXCEPTIONS
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
			raise ("weasels");
		end
	
	wimp: INTEGER;
end
