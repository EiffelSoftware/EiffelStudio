
class TEST
inherit
	TEST1
		redefine
			try
		end
	
	TEST2
		undefine
			is_valid
		redefine
			try
		end

create
       make
feature

	make
		do
			(create {TEST3}).try
		end

	try
		do
		end

end

