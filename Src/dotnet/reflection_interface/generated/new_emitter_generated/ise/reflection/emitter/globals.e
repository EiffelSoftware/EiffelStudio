indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Globals"

external class
	GLOBALS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Globals"
		end

feature {NONE} -- Implementation

	frozen family (type: TYPE): ARRAY_LIST is
		external
			"IL static signature (System.Type): System.Collections.ArrayList use Globals"
		alias
			"Family"
		end

end -- class GLOBALS
