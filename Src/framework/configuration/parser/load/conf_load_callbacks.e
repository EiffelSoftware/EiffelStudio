indexing
	description: "The callbacks that react on the xml parsing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_CALLBACKS

inherit
	XM_CALLBACKS_NULL
		redefine
			on_error
		end

	CONF_FILE_CONSTANTS

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Status

	is_unknown_version: BOOLEAN
			-- Is the file of an unknown version?

	is_error: BOOLEAN
			-- Was there an error during the parsing?

	is_warning: BOOLEAN
			-- Was there a warning during the parsing?

	is_invalid_xml: BOOLEAN
			-- Is the file not even valid xml?

	last_error: CONF_ERROR_PARSE
			-- The last error message from the parser.

	last_warning: ARRAYED_LIST [CONF_ERROR_PARSE]
			-- The last warning messages from the parser.

feature -- Callbacks

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			is_invalid_xml := True
			set_parse_error_message (a_message)
		end

feature -- Setting

	set_internal_error is
			-- When an error occur during parsing which is not caught by our callback.
		local
			l_error: CONF_ERROR_PARSE
		do
			create l_error
			l_error.set_message ({CONF_INTERFACE_NAMES}.e_internal_parse_error)
			is_error := True
			last_error := l_error
		end

feature {NONE} -- Implementation

	check_uuid (a_value: STRING): BOOLEAN is
			-- Check that `a_value' is a valid uuid.
		require
			a_value_not_void: a_value /= Void
		local
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if not a_value.is_empty then
				create l_regexp.make
				l_regexp.compile ("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
				l_regexp.match (a_value)
				if l_regexp.has_matched then
					Result := True
				else
					set_error (create {CONF_ERROR_UUID})
				end
			else
				set_error (create {CONF_ERROR_UUID})
			end
		ensure
			No_error_implies_Result: not is_error implies Result
		end

	check_version (a_value: STRING) is
			-- Check that `a_value' is the correct version.
		do
			if a_value = Void then
					-- no version
				set_error (create {CONF_ERROR_VERSION})
			elseif a_value.is_equal (namespace_1_0_0) then
					-- 5.7 release
					-- this is fully compatible with the current version
					-- so we don't have to do anything special
			elseif a_value.is_equal (latest_namespace) then
					-- current version
			else
					-- unknown version
					-- we try to be forward compatible to a certain degree
				is_unknown_version := True
			end
		end

	set_error (an_error: CONF_ERROR_PARSE) is
			-- Set `an_error'.
		require
			an_error_ok: an_error /= Void
		do
			is_error := True
			last_error := an_error
			raise ("Parse error")
		end

	set_warning (an_error: CONF_ERROR_PARSE) is
			-- Set `an_error' as a warning.
		require
			an_error_ok: an_error /= Void
		do
			is_warning := True
			if last_warning = Void then
				create last_warning.make (1)
			end
			last_warning.force (an_error)
		end

	set_parse_error_message (a_message: STRING) is
			-- We have a parse error with a message.
		local
			l_error: CONF_ERROR_PARSE
		do
			create l_error
			l_error.set_message (a_message)
			is_error := True
			last_error := l_error
			raise ("Parse error")
		end

	set_parse_warning_message (a_message: STRING) is
			-- We have a parse warning with a message.
		local
			l_error: CONF_ERROR_PARSE
		do
			create l_error
			l_error.set_message (a_message)
			is_warning := True
			if last_warning = Void then
				create last_warning.make (1)
			end
			last_warning.force (l_error)
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
end
