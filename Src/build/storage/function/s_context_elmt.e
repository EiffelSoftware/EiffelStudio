

class S_CONTEXT_ELMT  

inherit

	STORAGE_INFO
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (other: CONTEXT) is
		do
			identifier := other.identifier;	
		end;

	
feature {NONE}

	identifier: INTEGER;

	
feature 

	context: CONTEXT is
		do
			Result := context_table.item (identifier);
		end;
			
end
