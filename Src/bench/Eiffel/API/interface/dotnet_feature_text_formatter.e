indexing
	description: "Formats .NET feature text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2002/07/23"
	revision: "$Revision 1.0$"

class
	DOTNET_FEATURE_TEXT_FORMATTER

inherit
	E_TEXT_FORMATTER

feature -- Properties

	is_flat: BOOLEAN is True
			-- Is the format doing a flat?

feature -- Execution

	format (a_feature: E_FEATURE; c: CONSUMED_TYPE; a_formatter: TEXT_FORMATTER) is
			-- Format text for .NET `a_feature'.
		require
			valid_feature: a_feature /= Void
		do
			internal_format (new_format_context (a_feature, c, a_formatter))
		end

	format_short (a_feature: E_FEATURE; c: CONSUMED_TYPE; a_formatter: TEXT_FORMATTER) is
			-- Format text for .NET `a_feature'.
		require
			valid_feature: a_feature /= Void
		local
			f: DOTNET_FEAT_TEXT_FORMATTER_DECORATOR
		do
			f := new_format_context (a_feature, c, a_formatter)
			f.set_use_dotnet_name_only
			internal_format (f)
		end

feature {NONE} -- Implementation

	new_format_context (a_feature: E_FEATURE; c: CONSUMED_TYPE;  a_formatter: TEXT_FORMATTER): DOTNET_FEAT_TEXT_FORMATTER_DECORATOR is
			-- Create a new formatting context
		require
			valid_feature: a_feature /= Void
		do
			create Result.make (a_feature, c, a_formatter)
			if is_clickable then
				Result.set_in_bench_mode
			end
		end

	internal_format (f: DOTNET_FEAT_TEXT_FORMATTER_DECORATOR) is
			-- Text formatting implementation.
		do
			f.execute
			error := f.execution_error
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

end -- class DOTNET_FEATURE_TEXT_FORMATTER
