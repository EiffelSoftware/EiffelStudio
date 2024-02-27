note
	description: "[
			Parameters used by CMS_HOOK_CLEANUP subscribers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HOOK_CLEANUP_CONTEXT

inherit
	CMS_HOOK_CONTEXT_WITH_LOG
		rename
			make as make_context
		end
create
	make

feature {NONE} -- Initialization

	make (a_params: like parameters)
		do
			parameters := a_params
			make_context
		end

feature -- Access

	parameters: detachable STRING_TABLE [READABLE_STRING_GENERAL]
			-- Location of export folder.	

	parameter (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_GENERAL
		do
			if attached parameters as params then
				Result := params[n]
			end
		end

invariant

note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
