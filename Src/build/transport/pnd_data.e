indexing
	description: "Abtract data which may be transported."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class PND_DATA

inherit

	HELPABLE	

feature -- Access

	label: STRING is
			-- Text representing current data
		deferred
		ensure
			valid_label_result: Result /= Void
		end

	comment: STRING is
			-- Description of current data
		do
			create Result.make (0)
		end

	symbol: EV_PIXMAP is
			-- Picture symbol representing
			-- current data
		deferred
		end

end -- class PND_DATA

