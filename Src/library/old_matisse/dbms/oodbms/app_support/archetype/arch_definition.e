indexing
	description: "ARCH_DEFINITION defines a simple template for archetype specific definitions."
	keywords:    "archetype, definition"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:   "See notice at end of class"

deferred class ARCH_DEFINITION

inherit
	APP_ENVIRONMENT

	ERROR_STATUS
	    rename
	        fail_reason as invalid_reason,
	        append_fail_reason as append_invalid_reason
	    end

feature {ARCHETYPE} -- Status
	is_valid:BOOLEAN is
		deferred
		ensure
		      Reason_given: not Result implies invalid_reason /= Void and then not invalid_reason.empty
		end

feature {ARCHETYPE} -- Initialisation
	create_prototypes is
		deferred
		end

	init_structures is
		deferred
		end

feature {ARCHETYPE} -- Output
	print_out is
		deferred
		end

feature {NONE} -- Implementation
	archetype:ARCHETYPE

feature {ARCHETYPE} -- Modification
	set_archetype(an_archetype:ARCHETYPE) is
		require
			Archetype_exists: an_archetype /= Void
		do
			archetype := an_archetype
		end

	rep_items:ARRAYED_LIST[REP_ITEM] is
		do
			Result := archetype.rep_items
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
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
