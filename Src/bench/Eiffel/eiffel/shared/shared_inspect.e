-- Shared instance of mulit-branch instruction controler

class SHARED_INSPECT
	
feature {NONE}

	Inspect_control: INSPECT_CONTROL is
			-- Controler of multi-branch instruction
		do
			Result := Inspect_controlers.first
		end;

	Inspect_controlers: LINKED_LIST [INSPECT_CONTROL] is
		once
			create Result.make;
		end;
end
