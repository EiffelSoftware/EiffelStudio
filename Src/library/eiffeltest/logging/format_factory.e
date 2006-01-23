indexing
	description:
		"Singleton instance of format factory"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	FORMAT_FACTORY

feature {NONE} -- Initialization

	format_factory: HASHED_PROTOTYPE_FACTORY [LOG_OUTPUT_FORMAT] is
			-- Format factory singleton
		local
			f: LOG_OUTPUT_FORMAT
		once
			create Result.make
			Result.enable_cloning
			create {TEXT_LOG} f
			Result.extend (f, "ascii")
		ensure
			not_empty: Result /= Void and then not Result.is_empty
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




end -- class FORMAT_FACTORY

