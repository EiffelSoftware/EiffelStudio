--|---------------------------------------------------------------
--|      Copyright (C) 1994 Societe des Outils du Logiciel      -- 
--|            104 rue Castagnary 75015 Paris FRANCE            --
--|                     +33-(1)-45-32-58-80                     --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Nested queries example."
	product: "EiffelStore"
	database: "Sybase"
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class ACTION_1_I inherit

	ACTION_1

creation
        
	make

feature

	process_row is
		local
			my_action: ACTION_2_I
			new_selection: DB_SELECTION
			tuple: DB_TUPLE
			table_name: STRING
			table_id: INTEGER_REF
		do      
			!! tuple.copy (selection.cursor)
			!! table_id
			table_name ?= tuple.item (1)
			table_id ?= tuple.item (2)
			if table_name /= Void and table_id /= Void then
				io.putstring ("-- Column(s) for table ") 
				io.putstring (table_name)
				io.new_line
				!! new_selection.make
				!! my_action.make (new_selection)
				new_selection.set_action (my_action)
				new_selection.set_map_name (table_id, "table_id")
				new_selection.query (select_string)
				new_selection.load_result
				new_selection.unset_map_name ("table_id")
			end
		end

	select_string: STRING is
		once
			Result := 
			"select name from syscolumns where id = :table_id"
		end

end -- class ACTION_1_I
