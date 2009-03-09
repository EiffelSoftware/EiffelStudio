note
	description: "Base implementation for all errors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR_ERROR_INFO

feature {NONE} -- Initialization

	make (a_context: like context)
			-- Initializes an error.
			--
			-- `a_context': Any optional contextual information.
		require
			not_a_context_is_empty: a_context /= Void implies not a_context.is_empty
		do
			context := a_context
		ensure
			context_set: context = a_context
		end

feature -- Access

	code: STRING
			-- Error code.
		do
			Result := generating_type
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	description: STRING
			-- Error description.
		local
			l_context: like context
		do
			if internal_description = Void then
				if has_context then
					l_context := context
					check l_context_attached: l_context /= Void end
					Result := string_formatter.format (dollar_description, l_context)
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

	context: detachable TUPLE
			-- Error context, if any.

feature {NONE} -- Access

	dollar_description: STRING
			-- Dollar encoded description. ${n} are replaced by array indicies.
			-- See {STRING_FORMATTER}
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	is_fatal: BOOLEAN
			-- Is error fatal.
		do
			Result := True
		end

	has_context: BOOLEAN
			-- Does error have a context information?
		do
			Result := (attached context as l_context) and then not l_context.is_empty
		ensure
			not_context_is_empty: Result implies ((attached context as l_context) and then not l_context.is_empty)
		end

feature {NONE} -- Helpers

	string_formatter: STRING_FORMATTER
			-- Formatter used to expand `dollar_description'
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_description: STRING
			-- Cached version of `description'.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class {ERROR_ERROR_INFO}
