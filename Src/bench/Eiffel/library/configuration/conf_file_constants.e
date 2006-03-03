indexing
	description: "Constants for the file format."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_CONSTANTS

feature {NONE} -- Constants

	Header: STRING is "<?xml version=%"1.0%" encoding=%"ISO-8859-1%"?>%N"
	Namespace: STRING is "http://www.eiffel.com/xml/configuration-1-0-0"
	Schema: STRING is "http://www.eiffel.com/xml/configuration-1-0-0 http://www.ise/~patrickr/Public/configuration-1-0-0.xsd"

end
