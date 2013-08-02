note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEMPLATE_CONTEXT

feature {NONE} -- Template context

	template_context: TEMPLATE_CONTEXT
		once
			create Result.make
		end

	template_custom_action_by_id (a_id: detachable STRING): detachable FUNCTION [ANY, TUPLE [STRING, STRING_TABLE [STRING]], STRING]
		do
			if a_id /= Void then
				Result := template_context.template_custom_actions.item (a_id)
			end
		end

	is_valid_template_custom_action_id (a_id: detachable STRING): BOOLEAN
		do
			Result := a_id /= Void and then template_context.template_custom_actions.has (a_id)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end -- class SHARED_TEMPLATE_CONTEXT
