--|---------------------------------------------------------------
--|      Copyright (C) 1994 Societe des Outils du Logiciel      -- 
--|            104 rue Castagnary 75015 Paris FRANCE            --
--|                     +33-(1)-45-32-58-80                     --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Nested queries example.";
	product: "EiffelStore";
	database: "Oracle";
	date: "$Date$";
	revision: "$Revision$";
	author: "Patrice Khawam"

class TEST_I inherit

	TEST

creation

	make

feature

	login_name: STRING is
			-- Database login
		once
			Result := "scott"
		end;
		
	password: STRING is
			-- Database password
		once
			Result := "tigger"
		end;

	select_string: STRING is
		once
			Result := 
			"select TABLE_NAME from ACCESSIBLE_TABLES"
		end

end -- class TEST_I
