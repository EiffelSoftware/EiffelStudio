class SHARED_INSTANTIATOR

inherit

	SHARED_WORKBENCH
	
feature {NONE}

	Instantiator: INSTANTIATOR is
			-- Generic tool
		once
			Result := System.instantiator;
		end;

end
