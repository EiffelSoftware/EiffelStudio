
class TEST
inherit
	TEST2
		redefine
			try
		end

create
	make

feature

	make
		do
			try
		end

	try
		do
			precursor
		end

end
