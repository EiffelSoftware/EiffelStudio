note
	description: "[
		A collection of actual code templates for a given code template definition.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TEMPLATE_COLLECTION

inherit
	CODE_COLLECTION [CODE_TEMPLATE]

create
	make

feature -- Query

	applicable_item: detachable CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template for the version of the compiler.
			--
			-- `Result': A code template with no version; Otherwise Void if not applicable template was located.
		do
			Result := applicable_item_with_version ((create {SYSTEM_CONSTANTS}).compiler_version_number.version)
			if not attached Result then
				Result := applicable_default_item
			end
		end

	applicable_default_item: detachable CODE_TEMPLATE
			-- Attempts to retreive the default (unversioned) code template.
			--
			-- `Result': A code template with no version; Otherwise Void if not applicable template was located.
		local
			l_cursor: DS_BILINEAR_CURSOR [CODE_TEMPLATE]
		do
			l_cursor := items.new_cursor
			from l_cursor.start until l_cursor.after loop
				if attached l_cursor.item as l_template then
					if not attached {CODE_VERSIONED_TEMPLATE} l_template then
							-- Template is not versioned, so take the first non-versioned
						Result := l_template
						l_cursor.go_after
					else
						l_cursor.forth
					end
				end
			end
			check gobo_memory_leak: l_cursor.off end
		ensure
			result_is_unversioned: not attached {CODE_VERSIONED_TEMPLATE} Result
		end

	applicable_item_with_version (a_version: STRING_32): detachable CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template, given a string version.
			--
			-- `a_version': Version to find the most applicable template with.
			-- `Result': A code template that best matches the supplied [minimum] version; Otherwise Void if not applicable template was located.
		require
			a_version_attached: attached a_version
			not_a_version_is_empty: not a_version.is_empty
		local
			l_version: CODE_VERSION
		do
			l_version := (create {CODE_FORMAT_UTILITIES}).parse_version (a_version, code_factory)
			Result := applicable_item_with_code_version (l_version)
		end

	applicable_item_with_code_version (a_version: CODE_VERSION): detachable CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template, given a version.
			--
			-- `a_version': Version to find the most applicable template with.
			-- `Result': A code template that best matches the supplied [minimum] version; Otherwise Void if not applicable template was located.
		require
			a_version_attached: attached a_version
			not_a_version_is_default: a_version /~ (create {CODE_NUMERIC_VERSION}.make (0, 0, 0, 0))
		local
			l_templates: like items
			l_versioned_templates: DS_ARRAYED_LIST [CODE_VERSIONED_TEMPLATE]
			l_versioned_template: detachable CODE_VERSIONED_TEMPLATE
			l_unversioned_template: detachable CODE_TEMPLATE
			l_cursor: DS_BILINEAR_CURSOR [CODE_TEMPLATE]
		do
			l_templates := items
			if not l_templates.is_empty then
				if l_templates.count = 1 then
						-- There's only one template
					Result := l_templates.first
					if attached {CODE_VERSIONED_TEMPLATE} Result as l_template and then not l_template.is_compatible_with (a_version) then
							-- The template is not usable, so unset it.
						Result := Void
					end
				else
						-- Find most applicable templates
					create l_versioned_templates.make_default
						-- Compile a list of versioned templates
					l_cursor := l_templates.new_cursor
					from l_cursor.start until l_cursor.after loop
						if attached {CODE_VERSIONED_TEMPLATE} l_cursor.item as l_template then
							l_versioned_templates.force_last (l_template)
						else
								-- Keep the unversioned template, incase there are no versioned ones
								-- or a incompatable version.
							l_unversioned_template := l_cursor.item
						end
						l_cursor.forth
					end
					check gobo_memory_leak: l_cursor.off end

					across l_versioned_templates as t loop
						if
							attached t as l_next_template and then
							l_next_template.is_compatible_with (a_version) and then
							(not attached l_versioned_template or else l_next_template.version > l_versioned_template.version)
						then
							l_versioned_template := l_next_template
						end
					end

						-- Set result with a versioned template, if set.
					Result := l_versioned_template

					if not attached Result then
							-- No versioned template was matched, use a non-versioned template if available.
						Result := l_unversioned_template
					end
				end
			end
		end

feature -- Visitor

	process (a_visitor: CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_template_collection (Current)
		end

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
