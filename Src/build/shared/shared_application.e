
class SHARED_APPLICATION
	
feature 

	Shared_app_exit_element: EXIT_ELEMENT is
		once
			!!Result;
		end;

	Shared_app_graph: APP_GRAPH is
		once
			!!Result.make
		end;

end 
