indexing
	description: "Component to let the user create queries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_QUERY_EDITOR

inherit
	EB_FEATURE_EDITOR
		redefine
			adapt
		end

feature -- Access

	type: STRING is
			-- Full type as string.
		do
			Result := type_selector.code
		end

feature -- Element change

	set_type (a_type: STRING) is
			-- Set content of `type_field' to `a_type'.
		do
			if a_type.is_empty then
				type_selector.selector.remove_text
			else
				type_selector.selector.set_text (a_type)
			end
		end

feature -- Status report

	expanded_needed: BOOLEAN
			-- Does return type have to be expanded?

feature {EB_QUERY_COMPOSITION_WIZARD} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True'.
		do
			expanded_needed := True
			type_selector.enable_expanded_needed
		ensure
			expanded_needed_set: expanded_needed
		end

feature -- Adaptation

	adapt (other: EB_FEATURE_EDITOR) is
			-- Set with `other'.
		local
			qe: EB_QUERY_EDITOR
		do
			Precursor (other)
			qe ?= other
			if qe /= Void then
				type_selector.set_from_other (qe.type_selector)
				if type_selector.expanded_needed then
					enable_expanded_needed
				end
			end
		end

feature {EB_FEATURE_EDITOR} -- Implementation

	type_selector: EB_TYPE_SELECTOR;

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

end -- class EB_QUERY_EDITOR
