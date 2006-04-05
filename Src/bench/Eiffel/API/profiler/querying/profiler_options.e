indexing
	description: "Output options as specified by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PROFILER_OPTIONS

feature -- Status setting

	set_output_names (names: ARRAY [STRING]) is
			-- Set `output_names' to `names'.
		do	
			output_names := names
		end

	set_filenames (names: ARRAY [STRING]) is
			-- Set `filenames' to `names'.
		do
			filenames := names
		end

	set_language_names (names: ARRAY [STRING]) is
			-- Set `language_names' to `names'.
		do
			language_names := names
		end

feature -- Status report

	output_names: ARRAY [STRING]
			-- The names of the columns to display

	filenames: ARRAY [STRING]
			-- The names of the files to be taken into account

	language_names: ARRAY [STRING]
			-- The languages to be taken into account

	image: STRING is
			-- Options as a string value
		local
			idx: INTEGER
		do
			create Result.make (0)

				--| Get the filenames
			from
				idx := 1
				Result.append ("%NFilenames:%N----------%N")
			until
				idx > filenames.count
			loop
				Result.append (filenames @ idx)
				Result.append ("%N")
				idx := idx + 1
			end

				--| Get the language names
			from
				idx := 1
				Result.append ("%NLanguages:%N----------%N")
			until
				idx > language_names.count
			loop
				Result.append (language_names @ idx)
				Result.append ("%N")
				idx := idx + 1
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class PROFILER_OPTIONS
