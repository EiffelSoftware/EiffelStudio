--|---------------------------------------------------------------
--|      Copyright (C) 1994 Societe des Outils du Logiciel      -- 
--|            104 rue Castagnary 75015 Paris FRANCE            --
--|                     +33-(1)-45-32-58-80                     --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Nested queries example.";
	product: "EiffelStore";
	database: "Sybase";
	date: "$Date$";
	revision: "$Revision$";
	author: "Patrice Khawam"

class TEST_I inherit

	TEST

creation

	make

feature

	select_string: STRING is
		once
			Result := "select name, id from sysobjects"
		end

end -- class TEST_I
