indexing
	description	: "Names for buttons, labels, ..."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	INTERFACE_NAMES

feature -- Labels names

	l_Library_name: STRING is			"Library Name"
	l_Done: STRING is					"Done"
	l_Compilable_libraries: STRING is	"Available libraries:"
	l_Libraries_to_compile: STRING is	"Libraries to precompile:"
	l_Yes: STRING is 					"Yes"
	l_No: STRING is 					"No"
	
feature -- Buttons names

	b_Add_all: STRING is				"Add all ->"
	b_Add: STRING is 					"Add ->"
	b_Remove_all: STRING is				"<- Remove all"
	b_Remove: STRING is					"<- Remove"
	b_Add_your_own_library: STRING is	"Add your own library..."

end -- class INTERFACE_NAMES
