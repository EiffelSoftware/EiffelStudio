note
	description: "[
		{XTL_AGENT_TAG_DESCRIPTION}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_AGENT_TAG_DESCRIPTION

inherit
	XTL_TAG_DESCRIPTION
		redefine
			set_attribute,
			has_argument
		end

create
	make_with_agent

feature -- Initialization

	make_with_agent (a_id: STRING; a_attribute_handler: PROCEDURE [ANY, TUPLE [STRING, STRING]])
		do
			make
			name := a_id
			attribute_handler := a_attribute_handler
			class_name := "XTAG_PAGE_NOOP_TAG"
		end
feature -- Access

	attribute_handler: PROCEDURE [ANY, TUPLE [STRING, STRING]]
			-- Handles attributes given to the {XP_TAG_ELEMENT}

	set_attribute (id: STRING; value: STRING)
			-- <Precursor>
		do
		end

	has_argument (a_name: STRING): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end
end
