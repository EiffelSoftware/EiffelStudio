indexing
	description: "Constants for use with CLASS_FORMAT."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_FORMAT_CONSTANTS

feature -- Constants

	cf_Chart: INTEGER is unique
			-- Chart format. Textual descriptions of ancestors, constraints, etc.

	cf_Diagram: INTEGER is unique
			-- Diagram format. Graphical view.

	cf_Clickable: INTEGER is unique
			-- Clickable format.

	cf_Flat: INTEGER is unique
			-- Flat format.

	cf_Short: INTEGER is unique
			-- Short format.

	cf_Flatshort: INTEGER is unique
			-- Flat/short format.

feature -- Access

	all_class_formats: INTEGER_INTERVAL is
			-- `cf_Chart' |..| `cf_Flatshort'.
		do
			Result := cf_Chart |..| cf_Flatshort
		end

feature -- Contract support

	valid_class_format (i: INTEGER): BOOLEAN is
			-- Is `i' one of the cf_* values?
		do
			Result := all_class_formats.has (i)
		end

end -- class CLASS_FORMAT_CONSTANTS

