indexing
	description: "Actions for EXT_STORABLE objects."
	keywords:    "metaschema odb object database"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class ES_ACTIONS

feature -- Access
	Es_default:INTEGER is 0
	Es_store:INTEGER is 101
	Es_retrieve:INTEGER is 102
	Es_delete:INTEGER is 103

feature -- Status
	is_valid_action(i:INTEGER):BOOLEAN is
		do
			Result := i = Es_default or else i >= Es_store and i <= Es_delete
		end
end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

