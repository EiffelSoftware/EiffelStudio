indexing
	description: "Class containing shared structures used to import %
				% classes of the application in EiffelBuild."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	SHARED_CLASS_IMPORTER

feature

	class_list: ARRAYED_LIST [APPLICATION_CLASS] is
			-- List of known classes of the application.
		once
			create Result.make (0)
		end
		
	class_type_name: STRING is
		once
			create Result.make (0)
		end
		
	set_class_type_name (new_string: STRING) is
			--
		do
			class_type_name.append_string (new_string)
		end
		
	new_name: STRING is
			--
		do
			Result := "Argument" + acounter.out
			acounter := acounter + 1
		end
		
	acounter: INTEGER

end -- class SHARED_CLASS_IMPORTER
