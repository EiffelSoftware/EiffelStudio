
class TEST
inherit
	TEST1
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
		$ROUTINE_MARK
			print ("Weasel%N")
		end

end
