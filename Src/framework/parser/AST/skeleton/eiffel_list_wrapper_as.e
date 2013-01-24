note
	description: "Wrapper of an EIFFEL_LIST object, used by roundtrip"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_LIST_WRAPPER_AS [ G -> detachable EIFFEL_LIST [AST_EIFFEL]]

feature -- Content

	meaningful_content: detachable G
			-- Meaningful `content'.
			-- If `content' is not void and content is not empty,
			-- `meaningful_content' is attached to `content', otherwise Void.
		local
			default_content: detachable G
		do
			Result := content
			if Result /= Void and then Result.is_empty then
				Result := default_content
			end
		ensure
			good_result: valid_meaningful_content (Result)
		end

	content: G
			-- Wrapped EIFFEL_LIST

feature -- Status reporting

	valid_meaningful_content (a_meaningful_content: like meaningful_content): BOOLEAN
			-- Is `a_meaningful_content' valid?
		do
			if attached content as l_content and then not l_content.is_empty then
				Result := a_meaningful_content = content
			else
				Result := a_meaningful_content = Void
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
