indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUICK_MELT_PROJECT_CMD

inherit
	EB_MELT_PROJECT_CMD
		redefine
			perform_compilation
--			name
		end

creation
	default_create

feature

	perform_compilation is
			-- The real compilation. (This is quick melting.)
		do
			license_display
			Eiffel_project.quick_melt
		end

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Quick_update
--		end

end -- class EB_QUICK_MELT_PROJECT_CMD
