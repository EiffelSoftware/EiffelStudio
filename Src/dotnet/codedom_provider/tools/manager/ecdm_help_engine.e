indexing
	description: "Show HTML Help 1.0 help content"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_HELP_ENGINE

inherit
	EV_HELP_ENGINE

create
	make

feature -- Initialization

	make (a_url: STRING; a_parent: EV_WINFORM_CONTAINER) is
			-- Set `url' with `a_url'.
			-- Set `parent' with `a_parent'.
		require
			non_void_url: a_url /= Void
			valid_url: not a_url.is_empty
			non_void_parent: a_parent /= Void
			valid_parent: a_parent.item /= Void
		do
			url := a_url
			parent := a_parent
		ensure
			url_set: url = a_url
			parent_set: parent = a_parent
		end

feature -- Access

	url: STRING
			-- URL of HTML Help file

	parent: EV_WINFORM_CONTAINER
			-- URL of HTML Help file

feature -- Basic Operations

	show (a_help_context: ECDM_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			if not a_help_context.is_empty then
				feature {WINFORMS_HELP}.show_help (parent.item, url + "::/" + a_help_context)
			else
				feature {WINFORMS_HELP}.show_help (parent.item, url)
			end			
		end

end -- class ECDM_HELP_ENGINE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------