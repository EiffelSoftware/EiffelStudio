indexing
	description: "Empty file template with no content"
	date: "$Date$"
	revision: "$Revision$"

class
	EMPTY_TEMPLATE

inherit
	TEMPLATE
	
feature -- Access

	description: STRING is
			-- Description
		do
			Result := "An empty document."
		end
		
	content: STRING is
			-- Content
		do
			create Result.make_empty
			Result.append ("<document title=%"(Enter title here..)%">%N%
			%%T<meta_data/>%N%
			%%T<paragraph>(Enter content here...)</paragraph>%N%
			%</document>")
		end	

end -- class EMPTY_TEMPLATE
