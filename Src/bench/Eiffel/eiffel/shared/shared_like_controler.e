-- Shared instance of anchored types controller

class SHARED_LIKE_CONTROLER
	
feature {NONE}

	Like_control: LIKE_CONTROLER is
		once
			create Result.make;
		end;

end
