class
   SIMPLE_LOAD_ACTION
   
inherit
   ACTION
      redefine
	 execute
      end

creation
   make
   
feature
   make (a_selection: DB_SELECTION) is
      do
	 selection := a_selection
      end

   execute is
      do
	 -- Store the result of selection in data_2 previously specified
	 selection.cursor_to_object
      end
   
feature -- attribute
   selection: DB_SELECTION

end
