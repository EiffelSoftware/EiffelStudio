indexing

	description:

		"Selects"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2002, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class GEANT_SELECT

create

	make

feature {NONE} -- Initialization

	make is
			-- Initialize 'select'.
		do
		end

feature -- Status report

	is_executable: BOOLEAN is
			-- Can element be executed?
		do
			Result := name /= Void and then name.count > 0
		ensure
			name_not_void: Result implies name /= Void
			name_not_empty: Result implies name.count > 0
		end

feature -- Access

	name: STRING
			-- Name of target to be selected

feature -- Setting

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

end
