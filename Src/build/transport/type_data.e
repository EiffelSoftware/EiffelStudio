indexing
	description: "Abtract data representing an context type, %
				%which may be transported."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class TYPE_DATA

inherit
	PND_DATA

feature -- Status report

 	type: CONTEXT_TYPE [CONTEXT] is
 			-- Context type 
 		deferred
 		end

	help_file_name: STRING is
			-- Help file name for data type
		do
			Result := type.eiffel_type
		end

end -- class TYPE_DATA

