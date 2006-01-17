indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DEBUG_CONTEXT

inherit
	FORMAT_CONTEXT
		redefine
			put_breakable, 
			emit_tabs,
			init_feature_context,
			init_uncompiled_feature_context
		end

create
	make, make_for_case

feature

	init_uncompiled_feature_context (source_class: CLASS_C; feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- uncompiled feature ast `feature_as'.
			-- This ast is not in the feature table (ie has
			-- not been compiled) but has been entered by
			-- the user.
		do
			Precursor {FORMAT_CONTEXT} (source_class, feature_as)
			current_e_feature := Void
			breakpoint_index := 1
		end

	init_feature_context (source, target: FEATURE_I; 
				feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		do
			Precursor {FORMAT_CONTEXT} (source, target, feature_as)
			current_e_feature := source.api_feature (source.written_in)
			breakpoint_index := 1
		end

feature {NONE}

	current_e_feature: E_FEATURE
			-- current e_feature of the context.

	breakpoint_index: INTEGER
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
			-- Create a breakable mark.
		local
			bp: BREAKPOINT_ITEM
		do
			if
				current_e_feature /= Void and then
				current_e_feature.is_debuggable
			then
				create bp.make (current_e_feature, breakpoint_index)
				added_breakpoint := True
				text.add (bp)
			end
			breakpoint_index := breakpoint_index + 1
		end

	emit_tabs is
			-- Add the good number of tabulations to the text.
		do
			if added_breakpoint then
				added_breakpoint := false
			else
				text.add (ti_padded_debug_mark)
			end
			Precursor {FORMAT_CONTEXT}
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CLASS_DEBUG_CONTEXT
