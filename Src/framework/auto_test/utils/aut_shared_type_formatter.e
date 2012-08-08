note
	description: "Type formatter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_SHARED_TYPE_FORMATTER

feature -- Access

	type_name (a_type: TYPE_A; a_feature: FEATURE_I): STRING
			-- Name of `a_type'.
			-- `a_feature' is used to resolve anchored type.
		require
			a_type_attached: a_type /= Void
		local
			l_type_formatter: AUT_TYPE_A_TEXT_FORMATTER
		do
			l_type_formatter := type_formatter
			l_type_formatter.wipe_type_name
			type_output_strategy.process (a_type, l_type_formatter, a_type.base_class, a_feature)
			Result := l_type_formatter.type_name.twin
		ensure
			result_attached: Result /= Void
		end

	type_name_with_context (a_type: TYPE_A; a_context_class: CLASS_C; a_context_feature: FEATURE_I): STRING
			-- Name of `a_type' in context `a_context_class' and `a_context_feature'
		require
			a_type_attached: a_type /= Void
			a_context_class_attached: a_context_class /= Void
		local
			l_type_formatter: AUT_TYPE_A_TEXT_FORMATTER
		do
			l_type_formatter := type_formatter
			l_type_formatter.wipe_type_name
			type_output_strategy.process (a_type, l_type_formatter, a_context_class, a_context_feature)
			Result := l_type_formatter.type_name.twin
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	type_output_strategy: AUT_AST_TYPE_OUTPUT_STRATEGY
			-- Output strategy for type
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	type_formatter: AUT_TYPE_A_TEXT_FORMATTER
			-- Type formatter
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
