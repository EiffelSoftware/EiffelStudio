note
	description: "Summary description for {XS_CALLBACK_STATE_WEBAPP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CALLBACK_STATE_WEBAPP

inherit
	XS_CALLBACK_STATE
	ERROR_SHARED_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization


feature -- Access


	tag: STRING = "webapp"


feature -- Document

	on_start
			-- <Precursor>
		do
		end

	on_finish
			-- <Precursor>
		do
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- <Precursor>
		do
			error_manager.set_last_error (create {XERROR_PARSE}.make ([a_message]), false)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- <Precursor>
		do
			error_manager.set_last_error (create {XERROR_PARSE}.make (["INSTRUCTIONS not yet implemented"]), False)
		end

	on_comment (a_content: STRING)
			-- <Precursor>
		do
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>

		do
			config_callback.webapps.put (create {XS_WEBAPP}.make_empty)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		do
			if a_local_part.is_equal ("name") then
				config_callback.webapps.item.set_name (a_value)
			elseif a_local_part.is_equal ("port") then
				config_callback.webapps.item.set_port (a_value.to_integer_32)
			else
				error_manager.set_last_error (create {XERROR_PARSE}.make (["Undefined attribute in <webapp>"]), False)
			end
		end

	on_start_tag_finish
			-- <Precursor>
		do
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>

		do
		end

feature -- Content

	on_content (a_content: STRING)
			-- <Precursor>
		do
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
