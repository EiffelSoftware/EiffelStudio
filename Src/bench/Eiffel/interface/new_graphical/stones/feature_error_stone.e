indexing
	description: 
		"Stone for a feature that has a error"
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURE_ERROR_STONE

inherit
	FEATURE_STONE
		rename
			make as feat_make
		redefine
			line_number
		end

creation
	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; a_pos: INTEGER) is
			-- Initialize stone with `a_feature' and error position `a_pos.
		do
			feat_make (a_feature)
			error_position := a_pos
		end

feature -- Access

	error_position: INTEGER
			-- Character position of error in `e_feature'.

	line_number: INTEGER is
			-- Line number of error 
		local
			file: RAW_FILE
			start_line_pos: INTEGER
		do
			create file.make (file_name)
			if file.is_readable then
				file.open_read
				from
				until
					file.position > error_position + 1 or else file.end_of_file
				loop
					start_line_pos := file.position
					Result := Result + 1
					file.readline
				end
				file.close
			end
		end

end -- class FEATURE_ERROR_STONE
