class
	TEST

inherit
	SYSTEM_OBJECT

	MY_INTERFACE_2

create
	make

feature {NONE} -- Initialization

	make is
		do
			-- Will fail to execute under 6.0 because of a TypeLoadException as the synonyms of `get_xml_attribute_string' and `get_xml_attribute_string_2',
			-- common in implementing COM Call Wrapper .NET versioned interfaces.
			print ("Success%N")
		end

	get_xml_attribute_string, get_xml_attribute_string_2 (name: SYSTEM_STRING): SYSTEM_STRING is
		do
		end

	get_xml_attribute_string_string (name, ns: SYSTEM_STRING): SYSTEM_STRING is
		do
		end

end