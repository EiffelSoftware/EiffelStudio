indexing

	description: 
		"Formats feature text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_TEXT_FORMATTER

inherit

	E_TEXT_FORMATTER

feature -- Properties

	is_flat: BOOLEAN is True;
			-- Is the format doing a flat? 

feature -- Execution

	format (a_feature: E_FEATURE; display_breakpoint: BOOLEAN) is
			-- Format text for eiffel `a_feature' and take
			-- into consideration renaming.
		require
			valid_feature: a_feature /= Void
		do
			internal_format (new_format_context (display_breakpoint, a_feature), a_feature)
		end

	format_short (a_feature: E_FEATURE; display_breakpoint: BOOLEAN) is
			-- Format text for eiffel `a_feature' and take
			-- into consideration renaming.
			--| Display short format (contracts only), used by ENViSioN!
		require
			valid_feature: a_feature /= Void
		local
			f: FORMAT_FEAT_CONTEXT
		do
			f := new_format_context (display_breakpoint, a_feature)
			f.set_is_short
			internal_format (f, a_feature)
		end

	simple_format_debuggable (a_feature: E_FEATURE) is
			-- Do a simple format for eiffel `a_feature' 
			-- which doesn't only formats the text and doesn't
			-- take into consideration renaming.
		require
			valid_feature: a_feature /= Void
		local
			f: SIMPLE_DEBUG_CONTEXT
		do
			create f.make (a_feature);
			text := f.text;
			error := f.execution_error
		end;

feature {NONE} -- Implementation

	new_format_context (display_breakpoint: BOOLEAN; a_feature: E_FEATURE): FORMAT_FEAT_CONTEXT is
			-- Context used by both `format' and `short_format'
		do
			if display_breakpoint then
				create {DEBUG_CONTEXT} Result.make (a_feature.associated_class);
			else
				create Result.make (a_feature.associated_class);
			end
		end

	internal_format (a_context: FORMAT_FEAT_CONTEXT; a_feature: E_FEATURE) is
			-- Format implementation
		require
			valid_feature: a_feature /= Void
		do
			if is_clickable then
				a_context.set_in_bench_mode
			end;
			a_context.execute (a_feature);
			text := a_context.text;
			error := a_context.execution_error
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

end -- class FEATURE_TEXT_FORMATTER
