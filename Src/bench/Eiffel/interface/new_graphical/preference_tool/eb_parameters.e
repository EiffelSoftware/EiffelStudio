indexing
	description: "Abstract notion of a list of parameters"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_PARAMETERS

inherit
	EB_CONSTANTS

feature -- Initialization

	make is
			-- Initialize
		do
			-- Your instructions here
		end

feature -- Access

	users: LINKED_LIST [RESOURCE_USER] is
		deferred
		end

	add_user (a_user: RESOURCE_USER) is
		deferred
		end

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]] is
		deferred
		end

	add_modified_resource (a_modified_resource: CELL2 [RESOURCE, RESOURCE]) is
		deferred
		end

	update is
		deferred
		end

end -- class EB_PARAMETERS
