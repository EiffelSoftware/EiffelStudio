indexing
	description: "Compilation contextual infomation shared between consumer and compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_COMPILATION_CONTEXT

feature -- Access

	root_class_name: STRING
			-- Name of root class
			
	root_creation_routine_name: STRING
			-- Name of root creation routine

feature -- Element Settings

	set_root_class_name (a_name: like root_class_name) is
			-- Set `root_class_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			root_class_name := a_name
		ensure
			root_class_name_set: root_class_name = a_name
		end
		
	set_root_creation_routine_name (a_name: like root_creation_routine_name) is
			-- Set `root_class_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			root_creation_routine_name := a_name
		ensure
			root_creation_routine_name_set: root_creation_routine_name = a_name
		end
		
end -- class CODE_COMPILATION_CONTEXT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------