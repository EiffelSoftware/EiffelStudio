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

class ACTION_2_I inherit

	ACTION_2
		redefine
			execute
		end

creation
        
	make

feature

        execute is
		local
			tuple: DB_TUPLE
			column_name: STRING
		do
			!! tuple.copy (selection.cursor)
			column_name ?= tuple.item (1)
			if column_name /= Void then
				io.putstring (column_name)
				io.new_line
			end
		end

end -- class ACTION_2_I
