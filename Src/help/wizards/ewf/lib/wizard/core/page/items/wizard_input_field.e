note
	description: "Summary description for {WIZARD_INPUT_FIELD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INPUT_FIELD

inherit
	WIZARD_PAGE_ITEM

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_8)
			-- Create field identified by `a_id'.
		do
			id := a_id
		end

feature -- Access

	id: READABLE_STRING_8

	validation: detachable PROCEDURE [WIZARD_PAGE]

feature -- Validation

	validate (a_page: WIZARD_PAGE)
		do
			if attached validation as act then
				act.call ([a_page])
			end
		end

feature -- Conversion

	data: detachable ANY
		deferred
		end

	text: STRING_32
		deferred
		end

feature -- Element change

	set_text (t: detachable READABLE_STRING_GENERAL)
		deferred
		end

	set_data (d: like data)
		deferred
		end

	set_validation (act: like validation)
		do
			validation := act
		end

end
