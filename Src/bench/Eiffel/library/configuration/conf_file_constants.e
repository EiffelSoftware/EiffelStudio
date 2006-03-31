indexing
	description: "Constants for the file format."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_CONSTANTS

feature {NONE} -- Constants

	Header: STRING is "<?xml version=%"1.0%" encoding=%"ISO-8859-1%"?>%N"
	Namespace: STRING is "http://www.eiffel.com/developers/xml/configuration-1-0-0"
	Schema: STRING is
		once
			Result := Namespace +" http://www.eiffel.com/developers/xml/configuration-1-0-0.xsd"
		end

end
