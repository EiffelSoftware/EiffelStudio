note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DEBUG_TEXT_FORMATTER_DECORATOR

inherit
	TEXT_FORMATTER_DECORATOR
		redefine
			put_breakable,
			emit_tabs,
			init_feature_context,
			init_uncompiled_feature_context
		end

create
	make, make_for_case

feature

	init_uncompiled_feature_context (a_source_class: CLASS_C; feature_as: FEATURE_AS)
			-- Initialize Current context to analyze
			-- uncompiled feature ast `feature_as'.
			-- This ast is not in the feature table (ie has
			-- not been compiled) but has been entered by
			-- the user.
		do
			Precursor {TEXT_FORMATTER_DECORATOR} (a_source_class, feature_as)
			e_feature := Void
			breakpoint_index := 0
		end

	init_feature_context (source, target: FEATURE_I;
				feature_as: FEATURE_AS)
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		do
			Precursor {TEXT_FORMATTER_DECORATOR} (source, target, feature_as)
			e_feature := source.api_feature (source.written_in)
			breakpoint_index := 0
		end

feature {NONE}

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable
			-- Create a breakable mark.
		do
			breakpoint_index := breakpoint_index + 1
			if
				e_feature /= Void and then
				e_feature.is_debuggable
			then
				added_breakpoint := True
				text_formatter.process_breakpoint (e_feature, breakpoint_index)
			end
		end

	emit_tabs
			-- Add the good number of tabulations to the text.
		do
			if added_breakpoint then
				added_breakpoint := false
			else
				text_formatter.process_padded
			end
			Precursor {TEXT_FORMATTER_DECORATOR}
		end

note
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

end -- class CLASS_DEBUG_TEXT_FORMATTER_DECORATOR
