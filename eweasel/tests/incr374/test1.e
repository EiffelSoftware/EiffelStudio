
class TEST1
inherit
	TEST2 [TEST4]
		redefine
			try
		end
feature

	try
		do
			precursor
		end
end
