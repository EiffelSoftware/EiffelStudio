indexing
	description: "Couple representation of a define clause"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	COUPLE

creation
	make

feature -- Initialization

	make (a_name, a_value: STRING) is
		require
			a_name_exists: a_name /= Void and then a_name.count > 0
			a_value_not_void: a_value /= Void
		do
			set_name (a_name)
			set_value (a_value)
		ensure
			name_set: name.is_equal (a_name)
			value_set: value.is_equal (a_value)
		end

feature -- Access

	name: STRING
			-- Name.
       
	value: STRING
			-- Value.

feature -- Element change

	set_name (a_name: STRING) is
			-- Set `name_id' to `a_name'.
		require
			a_name_exists: a_name /= Void and then a_name.count > 0
		do
			name := clone (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end
	
	set_value (a_value: STRING) is
			-- Set `value' to `a_value'.
		require
			a_value_not_void: a_value /= Void
		do
			value := clone (a_value)
		ensure
			value_set: value.is_equal (a_value)
		end
        
end -- class COUPLE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
