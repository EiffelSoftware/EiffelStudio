indexing
	description: "Root class"
	external_name: "ISE.Reflection.Generator"

class 
	GENERATOR
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
		end

feature -- Access

	eiffel_generator: EIFFEL_CODE_GENERATOR
			-- Eiffel generator
		indexing
			external_name: "EiffelGenerator"
		end
	
	eiffel_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML
			-- Eiffel generator from Xml
		indexing
			external_name: "EiffelGeneratorFromXml"
		end
	
	xml_generator: XML_CODE_GENERATOR
			-- Xml generator
		indexing
			external_name: "XmlGenerator"
		end
			
end -- class GENERATOR