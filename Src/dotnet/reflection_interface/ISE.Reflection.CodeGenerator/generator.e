indexing
	description: "Root class"
	external_name: "ISE.Reflection.Generator"

class 
	GENERATOR
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do
		end

feature -- Access

	eiffel_generator: EIFFEL_CODE_GENERATOR
		indexing
			description: "Eiffel generator"
			external_name: "EiffelGenerator"
		end
	
	eiffel_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML
		indexing
			description: "Eiffel generator from Xml"
			external_name: "EiffelGeneratorFromXml"
		end
	
	xml_generator: XML_CODE_GENERATOR
		indexing
			description: "Xml generator"
			external_name: "XmlGenerator"
		end
			
end -- class GENERATOR