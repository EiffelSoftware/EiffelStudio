note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEMPLATE_CONTEXT

feature -- Template context

	template_context: TEMPLATE_CONTEXT
		once
			create Result.make
		end

feature {NONE} -- Template context helper

	template_custom_action_by_id (a_id: detachable STRING): detachable TEMPLATE_CUSTOM_ACTION
		do
			if a_id /= Void then
				Result := template_context.template_custom_action_by_id (a_id)
			end
		end

	is_valid_template_custom_action_id (a_id: detachable STRING): BOOLEAN
		do
			Result := a_id /= Void and then
						template_context.is_valid_template_custom_action_id (a_id)
		end

note
	copyright: "2011-2016, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end -- class SHARED_TEMPLATE_CONTEXT
