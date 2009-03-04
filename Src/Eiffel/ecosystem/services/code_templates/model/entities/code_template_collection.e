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
	CODE_COLLECTION [attached CODE_TEMPLATE]

create
	make

feature -- Query

	applicable_item: detachable CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template for the version of the compiler.
			--
			-- `Result': A code template with no version; Otherwise Void if not applicable template was located.
		local
			l_version: attached STRING_32
		do
			create l_version.make_from_string ((create {SYSTEM_CONSTANTS}).compiler_version_number.version)
			Result := applicable_item_with_version (l_version)
			if Result = Void then
				Result := applicable_default_item
			end
		end

	applicable_default_item: detachable CODE_TEMPLATE
			-- Attempts to retreive the default (unversioned) code template.
			--
			-- `Result': A code template with no version; Otherwise Void if not applicable template was located.
		local
			l_template: CODE_TEMPLATE
			l_versioned_template: CODE_VERSIONED_TEMPLATE
		do
			if attached {attached DS_BILINEAR_CURSOR [attached CODE_TEMPLATE]} items.new_cursor as l_templates then
				from l_templates.start until l_templates.after loop
					l_template := l_templates.item
					l_versioned_template ?= l_template
					if l_versioned_template = Void then
							-- Template is not versioned, so take the first non-versioned
						Result := l_template
						l_templates.go_after
					else
						l_templates.forth
					end
				end
				check gobo_cursor_cleaned_up: l_templates.off end
			end
		ensure
			result_is_unversioned: not attached {CODE_VERSIONED_TEMPLATE} Result as e1
		end

	applicable_item_with_version (a_version: attached STRING_32): detachable CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template, given a string version.
			--
			-- `a_version': Version to find the most applicable template with.
			-- `Result': A code template that best matches the supplied [minimum] version; Otherwise Void if not applicable template was located.
		require
			not_a_version_is_empty: not a_version.is_empty
		local
			l_version: attached CODE_VERSION
		do
			l_version := (create {CODE_FORMAT_UTILITIES}).parse_version (a_version, create {CODE_FACTORY})
			Result := applicable_item_with_code_version (l_version)
		end

	applicable_item_with_code_version (a_version: attached CODE_VERSION): detachable CODE_TEMPLATE
			-- Attempts to retreive the most applicable code template, given a version.
			--
			-- `a_version': Version to find the most applicable template with.
			-- `Result': A code template that best matches the supplied [minimum] version; Otherwise Void if not applicable template was located.
		require
			not_a_version_is_default: not a_version.is_equal (create {CODE_NUMERIC_VERSION}.make (0, 0, 0, 0))
		local
			l_templates: like items
			l_template: attached CODE_TEMPLATE
			l_versioned_templates: attached DS_ARRAYED_LIST [attached CODE_VERSIONED_TEMPLATE]
			l_ver_template: CODE_VERSIONED_TEMPLATE
			l_next_ver_template: attached CODE_VERSIONED_TEMPLATE
			l_cursor: DS_BILINEAR_CURSOR [attached CODE_TEMPLATE]
		do
			l_templates := items
			if not l_templates.is_empty then
				if l_templates.count = 1 then
						-- There's only one template
					Result := l_templates.first
					if attached {CODE_VERSIONED_TEMPLATE} Result as l_vt1 and then not l_vt1.is_compatible_with (a_version) then
							-- The template is not usable, so unset it.
						Result := Void
					end
				else
						-- Find most applicable templates
					create l_versioned_templates.make_default
					l_cursor := l_templates.new_cursor
					if l_cursor /= Void then
							-- Compile a list of versioned templates
						from l_cursor.start until l_cursor.after loop
							if attached {CODE_VERSIONED_TEMPLATE} l_cursor.item as l_vt2 then
								l_versioned_templates.force_last (l_vt2)
							else
									-- Keep the unversioned template, incase there are no versioned ones
									-- or a incompatable version.
								l_template := l_cursor.item
							end
							l_cursor.forth
						end

						if not l_versioned_templates.is_empty then
							from l_versioned_templates.start until l_versioned_templates.after loop
								l_next_ver_template := l_versioned_templates.item_for_iteration
								if l_next_ver_template.is_compatible_with (a_version) then
									if l_ver_template = Void or else l_next_ver_template.version > l_ver_template.version then
										l_ver_template := l_next_ver_template
									end
								end
								l_versioned_templates.forth
							end

								-- Set last found version
							Result := l_ver_template
						end

						if Result = Void then
								-- No versioned template was matched, use a non-versioned template if available.
							Result := l_template
						end
					end
				end
			end
		end

feature -- Visitor

	process (a_visitor: attached CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_template_collection (Current)
		end

;note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
