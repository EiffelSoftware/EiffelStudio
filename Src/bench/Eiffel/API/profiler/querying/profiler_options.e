indexing
	description: "Output options as specified by the user."
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

end -- class PROFILER_OPTIONS
