
class TEST4 [G -> $(CONSTRAINT)]
inherit
	TEST1 [TEST2]
		redefine
			try
		end
feature

	try
		do
			precursor
		end
end
