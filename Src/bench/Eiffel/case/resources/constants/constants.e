indexing

	description: 
		"Constant classes used in EiffelCase.";
	date: "$Date$";
	revision: "$Revision$"

class CONSTANTS

feature -- Properties

	Environment: EC_ENVIRONMENT is
			-- EiffelCase environment information
		once
			!! Result
		end

	Filter_keys: SHARED_FILTER_CONST is
			-- Filter keys found in `.fil' files
		once
			!! Result
		end

	Pixmaps: PIXMAPS is
			-- Pixmap constants
		once
			!! Result
		end

	Resources: RESOURCES is
			-- Fonts and colors used for graphic views
		once
			!! Result.initialize
		end

	Stone_types: EC_STONE_TYPES is
			-- Stone types 
		once
			!! Result
		end

	Widget_names: WIDGET_NAMES is
			-- Constant strings for Widgets
		once
			!! Result
		end

	Project_id : INTEGER is 4000

	Class_id : INTEGER is 2


end -- class CONSTANTS
