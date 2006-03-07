indexing
	description: "Show HTML Help 1.0 help content"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_HELP_ENGINE

inherit
	EV_HELP_ENGINE

	CODE_DOM_PATH
		export
			{NONE} all
		end

feature -- Basic Operations

	show (a_help_context: CODE_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			if not a_help_context.is_empty then
				{WINFORMS_HELP}.show_help (parent, Documentation_path, Documentation_path + "::/" + a_help_context)
			else
				{WINFORMS_HELP}.show_help (parent, Documentation_path)
			end			
		end

feature {NONE} -- Implementation

	parent: WINFORMS_CONTROL is
			-- Dummy windows form control used to parent the Help dialog
		once
			create Result.make_from_text ("")
		end

end -- class CODE_HELP_ENGINE

--+--------------------------------------------------------------------
--| CodeDom Tools Library
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------