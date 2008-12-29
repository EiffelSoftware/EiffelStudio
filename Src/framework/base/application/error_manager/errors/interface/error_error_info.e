note
	description: "Base implementation for all errors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR_ERROR_INFO

feature {NONE} -- Initialization

	make_with_context (a_cxt: like context)
			-- Initialize error with context `a_cxt'
		require
			a_cxt_attached: a_cxt /= Void
			not_a_cxt_is_empty: not a_cxt.is_empty
		do
			context := a_cxt
		ensure
			context_set: context = a_cxt
		end

feature -- Access

	description: STRING
			-- Error description
		do
			if internal_description = Void then
				if has_context then
					Result := string_formatter.format (dollar_description, context)
				else
					Result := dollar_description
				end
				internal_description := Result
			end
			Result := internal_description
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	code: STRING
			-- Error code
		do
			Result := generating_type
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	context: TUPLE
			-- Error context

	has_context: BOOLEAN
			-- Does error have a context?
		do
			Result := context /= Void and then not context.is_empty
		end

	is_fatal: BOOLEAN
			-- Is error fatal
		once
			Result := True
		end

	error_level_tag: STRING
			-- Error level description
		do
			if is_fatal then
				Result := "fatal error"
			else
				Result := "error"
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	string_formatter: STRING_FORMATTER
			-- Formatter used to expand `dollar_description'
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	internal_description: STRING
			-- cached description

	dollar_description: STRING
			-- Dollar encoded description. ${n} are replaced by array indicies.
			-- See {STRING_FORMATTER}
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

invariant
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty
	code_attached: code /= Void
	not_code_is_empty: not code.is_empty
	has_context_correct: has_context implies (context /= Void and then not context.is_empty)

note
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

end -- class {ERROR_ERROR_INFO}
