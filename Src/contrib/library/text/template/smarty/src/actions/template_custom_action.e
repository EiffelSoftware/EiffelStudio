note
	description: "Summary description for {TEMPLATE_CUSTOM_ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEMPLATE_CUSTOM_ACTION

feature -- Execution

	item (a_text: STRING; a_params: STRING_TABLE [STRING]; a_struct_action: TEMPLATE_STRUCTURE_ACTION): detachable ANY
		deferred
		end

note
	copyright: "2011-2016, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
