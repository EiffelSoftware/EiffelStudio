
deferred class GRAPH_ELEMENT 

inherit

	EB_HASHABLE
		export
			{NONE} all
		end;

feature 

	internal_name: STRING is 
		deferred 
		end;

	visual_name: STRING is 
		deferred 
		end;

	label: STRING is
		deferred
		end;

feature {NONE}

	hash_code: INTEGER is
		do
			Result := internal_name.hash_code
		end;
	
	same (other: like Current): BOOLEAN is
		do
			Result := (other = Current)
		end;

end
