indexing
	description: "Collection, where each element must be unique." 
	class_type: Interface
	external_name: "ISE.Base.Set"

deferred class 
	SET [G] 

inherit
	COLLECTION [G]

feature -- Measurement

	count: INTEGER is
		indexing
			description: "Number of items"
		deferred
		end

end -- class SET



