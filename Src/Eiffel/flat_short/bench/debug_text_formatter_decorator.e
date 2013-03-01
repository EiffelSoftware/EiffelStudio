note
	description	: "Facilities to handle breakpoints adding in flat/short formats"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_TEXT_FORMATTER_DECORATOR

inherit
	FEAT_TEXT_FORMATTER_DECORATOR
		redefine
			put_breakable,
			emit_tabs,
			execute,
			initialize
		end

	TTY_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize (a_formatter: TEXT_FORMATTER)
			-- Initialize Current for bench.
		do
			Precursor (a_formatter)
			set_for_expression_meta
		end

feature -- Execution

	execute (a_target_feat: E_FEATURE)
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		local
			retried: BOOLEAN
		do
			if not retried then
				e_feature := a_target_feat
				Precursor {FEAT_TEXT_FORMATTER_DECORATOR} (a_target_feat)
				debug ("debugger")
					if not a_target_feat.is_debuggable then
						text_formatter.add ("Warning: you can not set breakpoint in this feature")
					end
				end
			else
				text_formatter.add (warning_messages.w_formatter_failed)
			end
		rescue
			retried := True
			retry
		end

feature {NONE}

	added_breakpoint: BOOLEAN
			-- Was a breakpoint added?

	put_breakable
			-- Create a breakable mark.
		do
			breakpoint_index := breakpoint_index + 1
			if attached e_feature as l_e_feat and then l_e_feat.is_debuggable then
				added_breakpoint := True
				text_formatter.process_breakpoint (l_e_feat, breakpoint_index)
			end
		end

	emit_tabs
			-- Add the good number of tabulations to the text.
		local
			l_meta: like meta_data
		do
				-- Remove meta (expression) temparorily,
				-- As we do not need it for indentations.
			l_meta := text_formatter.meta_data
			set_meta_data (Void)

			if added_breakpoint then
				added_breakpoint := False
			else
				text_formatter.process_padded
			end
			Precursor {FEAT_TEXT_FORMATTER_DECORATOR}

				-- Restore meta (expression).
			set_meta_data (l_meta)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
