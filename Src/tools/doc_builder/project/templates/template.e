indexing
	description: "Abstraction of template."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEMPLATE
		
feature -- Access

	name: STRING
			-- Template name

	description: STRING is
			-- Description
		deferred
		end
		
	content: STRING is
			-- Content
		deferred
		end

end -- class TEMPLATE
