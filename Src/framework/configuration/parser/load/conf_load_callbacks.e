note
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
			on_error,
			on_finish,
			on_start
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

	current_namespace: detachable STRING
			-- Current namespace

feature -- Callbacks

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			is_invalid_xml := True
			set_parse_error_message (a_message)
		end

	on_start, on_finish
			-- <Precursor>
		do
				-- Reset namespace information.
			current_namespace := Void
		end

feature -- Setting

	set_internal_error
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

	check_uuid (a_value: STRING): BOOLEAN
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
			no_error_implies_result: not is_error implies Result
		end

	check_version (a_value: STRING)
			-- Check that `a_value' is the correct version.
		local
			namespace: like current_namespace
		do
			namespace := current_namespace
			if a_value = Void then
					-- No namespace is specified.
				set_error (create {CONF_ERROR_VERSION})
			elseif namespace = Void then
					-- This is a top-level element, its namespace will be used for processing
					-- of the complete configuration file.
				if a_value.is_equal (namespace_1_0_0) then
						-- 5.7 release
						-- this is fully compatible with the current version
						-- so we don't have to do anything special
					namespace := namespace_1_0_0
				elseif a_value.is_equal (namespace_1_2_0) then namespace := namespace_1_2_0
				elseif a_value.is_equal (namespace_1_3_0) then namespace := namespace_1_3_0
				elseif a_value.is_equal (namespace_1_4_0) then namespace := namespace_1_4_0
				elseif a_value.is_equal (namespace_1_5_0) then namespace := namespace_1_5_0
				elseif a_value.is_equal (namespace_1_6_0) then namespace := namespace_1_6_0
				elseif a_value.is_equal (latest_namespace) then namespace := latest_namespace
						-- current version
				else
						-- unknown version
						-- we try to be forward compatible to a certain degree
					is_unknown_version := True
					namespace := a_value
				end
					-- Record the current namespace for future use.
				current_namespace := namespace
			elseif namespace /~ a_value then
					-- Nested element has some different namespace.
					-- Instead of reporting an error it's possible to skip the elements from a
					-- different namespace.
					-- The XML schema should be adjusted to allow this.
				set_error (create {CONF_ERROR_VERSION})
			end
		end

	set_error (an_error: CONF_ERROR_PARSE)
			-- Set `an_error'.
		require
			an_error_ok: an_error /= Void
		local
			l_conf_exception: CONF_EXCEPTION
		do
			is_error := True
			last_error := an_error
			create l_conf_exception
			l_conf_exception.set_message ("Parse error")
			l_conf_exception.raise
		end

	set_warning (an_error: CONF_ERROR_PARSE)
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

	set_parse_error_message (a_message: STRING)
			-- We have a parse error with a message.
		local
			l_error: CONF_ERROR_PARSE
			l_conf_exception: CONF_EXCEPTION
		do
			create l_error
			l_error.set_message (a_message)
			is_error := True
			last_error := l_error
			create l_conf_exception
			l_conf_exception.set_message ("Parse error")
			l_conf_exception.raise
		end

	set_parse_warning_message (a_message: STRING)
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

note
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
end
