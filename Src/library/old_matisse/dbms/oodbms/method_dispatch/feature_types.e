indexing
	description: "Feature type definitions for method dispatch"
	version:     "%%I%%"
	date:        "%%D%%"
	source:      "%%P%%"
	keywords:    "feature type"
	copyright:   "See notice at end of class"

class FEATURE_TYPES

feature -- Access
	Procedure:INTEGER is 0
	Function_reference:INTEGER is 1
	Function_boolean:INTEGER is 2
	Function_character:INTEGER is 3
	Function_integer:INTEGER is 4
	Function_real:INTEGER is 5
	Function_double:INTEGER is 6
	Function_pointer:INTEGER is 7
	Function_bit:INTEGER is 8
	Field_reference:INTEGER is 9

feature -- Status
	is_valid_feature_type(n:INTEGER):BOOLEAN is
		do
			Result := n >= Procedure and n <= Field_reference
		end

end


--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

