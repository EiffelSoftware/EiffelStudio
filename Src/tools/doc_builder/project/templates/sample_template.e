indexing
	description: "Sample template"
	date: "$Date$"
	revision: "$Revision$"

class
	SAMPLE_TEMPLATE

inherit
	TEMPLATE
	
feature -- Access

	description: STRING is
			-- Description
		do
			Result := "A sample of a system including source code."
		end
		
	content: STRING is
			-- Content
		do
			create Result.make_empty
			Result.append ("<document title=%"(Enter title here...)%">%N%
				%%T<meta_data/>%N%
				%%T<paragraph>%N%
					%%T%T<paragraph>(Introductory remarks here...)</paragraph>%N%
					%%T%T<heading><size>2</size>Compiling</heading>%N%
					%%T%T<paragraph>(Compilation instructions here...)</paragraph>%N%
					%%T%T<heading><size>2</size>Running the Sample</heading>%N%
					%%T%T<paragraph>(How to use instructions here...)</paragraph>%N%
					%%T%T<heading><size>2</size>Under the Hood</heading>%N%
					%%T%T<paragraph>(Source code links, technical details, etc here...)</paragraph>%N%
				%%T</paragraph>%N%
				%</document>")
		end	

end -- class SAMPLE_TEMPLATE
