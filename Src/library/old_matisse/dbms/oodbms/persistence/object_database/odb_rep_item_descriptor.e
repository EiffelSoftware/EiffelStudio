indexing
	description: ""
	keywords:    "odb"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

deferred class ODB_REP_ITEM_DESCRIPTOR

inherit
	ODB_CLASS_DESCRIPTOR

feature -- Initialisation
	make(a_name:STRING) is
		do
		end

feature -- Template

feature -- Access
	database_name:STRING
		-- name of object database (within client/server system). Same name as system if
		-- this concept not supported

	rep_client_name:STRING
		-- name of REP_CLIENT to access objects of this class.  Same as the class name
		-- except where subtypes are served by supertype REP_CLIENT

feature -- Modification

feature -- Status

feature -- Status Setting

feature -- Comparison

feature -- Conversion

feature -- Factory
	create_item: like item_prototype is
		do
			Result := deep_clone(item_prototype)
		end

feature {NONE} -- Implementation
	item_prototype:REP_ITEM

invariant

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

