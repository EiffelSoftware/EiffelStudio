-- Some constants for register creation

class TYPE_I_CONST 

	
feature {NONE}

	Ref_type: REFERENCE_I is
			-- Reference type description
		once
			!!Result;
		end;

	Int_type: LONG_I is
			-- Integer type description
		once
			!!Result;
		end;

end
