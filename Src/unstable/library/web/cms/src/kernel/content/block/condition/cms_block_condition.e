note
	description: "Condition for block to be displayed."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_BLOCK_CONDITION

feature -- Access

	description: READABLE_STRING_32
		deferred
		end

feature -- Evaluation

	satisfied_for_response (res: CMS_RESPONSE): BOOLEAN
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
