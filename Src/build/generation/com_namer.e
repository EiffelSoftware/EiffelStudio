
class COM_NAMER 



	
feature {NONE}

	namer: LOCAL_NAMER is
		once
			!!Result.make ("com");
		end

end
