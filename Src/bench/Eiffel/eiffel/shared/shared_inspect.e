-- Shared instance of mulit-branch instruction controler

class SHARED_INSPECT
	
feature {NONE}

	Inspect_control: INSPECT_CONTROL is
			-- Controler of multi-branch instruction
		once
			!!Result.make
		end;

end
