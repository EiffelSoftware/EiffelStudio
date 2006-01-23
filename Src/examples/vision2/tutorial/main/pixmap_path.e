indexing
	description: "A class for the tutorial example that%
			%gives a path for the bitmaps."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PIXMAP_PATH

feature -- Access

	pixmap_path (name: STRING): STRING is
			-- Return the full name of the given pixmap of EiffelBench.
		local
			env: EXECUTION_ENVIRONMENT
		do
			create env
			Result := env.get ("ISE_EIFFEL")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("bench")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("bitmaps")
			Result.append_character (Operating_environment.directory_separator)
			Result.append (pixmap_extension)
			Result.append_character (Operating_environment.directory_separator)
			Result.append (name)
			Result.append (".")
			Result.append (pixmap_extension)
		end

feature {NONE} -- Implementation

	pixmap_extension: STRING is
		local
			platform: EV_TOOLKIT
		once
			create platform
			if platform.name.is_equal ("WEL") then
				Result := "bmp"
			else
				Result := "xpm"
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PIXMAP_PATH

