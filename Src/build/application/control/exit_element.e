
class EXIT_ELEMENT 

inherit

	GRAPH_ELEMENT
	
feature 

	visual_name: STRING is "exit";

	internal_name: STRING is "exit";

	label: STRING is
		do
			Result := "exit"
		end;

end
