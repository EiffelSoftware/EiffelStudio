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
			!! Result.make (0)
		end

end -- class SHARED_CLASS_IMPORTER
