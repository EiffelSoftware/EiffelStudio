indexing
	description: "Root class"

class 
	GENERATOR
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end

feature -- Access

	eiffel_generator: EIFFEL_CODE_GENERATOR
		indexing
			description: "Eiffel generator"
		end
	
	eiffel_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML
		indexing
			description: "Eiffel generator from Xml"
		end
	
	xml_generator: XML_CODE_GENERATOR
		indexing
			description: "Xml generator"
		end
			
end -- class GENERATOR
