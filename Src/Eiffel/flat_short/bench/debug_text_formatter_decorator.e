indexing
	description	: "Facilities to handle breakpoints adding in flat/short formats"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class DEBUG_TEXT_FORMATTER_DECORATOR

inherit
	FEAT_TEXT_FORMATTER_DECORATOR
		redefine
			put_breakable,
			emit_tabs,
			execute
		end

create
	make

feature -- Execution

	execute (a_target_feat: E_FEATURE) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		local
			retried: BOOLEAN
		do
			if not retried then
				e_feature := a_target_feat
				Precursor {FEAT_TEXT_FORMATTER_DECORATOR} (a_target_feat)
			else
				text_formatter.add_string ("No text could be generated.")
				text_formatter.add_new_line
				text_formatter.add_string ("Please make sure the system is correctly compiled.")
			end
		rescue
			retried := True
			retry
		end

feature {NONE}

	e_feature: E_FEATURE
			-- current e_feature of the context.

	breakpoint_index: INTEGER
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
			-- Create a breakable mark.
		do
			breakpoint_index := breakpoint_index + 1
			if e_feature /= Void and then e_feature.is_debuggable then
				added_breakpoint := True
				text_formatter.process_breakpoint (e_feature, breakpoint_index)
			end
		end

	emit_tabs is
			-- Add the good number of tabulations to the text.
		do
			if added_breakpoint then
				added_breakpoint := false
			else
				text_formatter.process_padded
			end
			Precursor {FEAT_TEXT_FORMATTER_DECORATOR}
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end	 -- class DEBUG_TEXT_FORMATTER_DECORATOR
