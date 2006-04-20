indexing
	description: "Object that represents a feature item from a resultset of a certain EQL query"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE

inherit
	EQL_CALLER
		rename
			data as e_feature
		redefine
			is_feature_scope
		end

	EQL_FEATURE_CELL
		undefine
			is_equal
		end

create
	make_with_feature

feature -- Status reporting

	is_feature_scope: BOOLEAN is True
			-- Does current single scope represent a feature scope?

	associated_class: CLASS_C is
			-- Compiled class associated with current
		do
			Result := e_feature.associated_class
		ensure then
			good_result: Result = e_feature.associated_class
		end

	written_class: CLASS_C is
			-- Written in class of current
		do
			Result := e_feature.written_class
		ensure
			result_set: Result = e_feature.written_class
		end

	name: STRING is
			-- Name of current feature
		do
			Result := e_feature.name
		end

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		do
			create Result.make_with_feature (e_feature)
		end

invariant
	e_feature_not_void: e_feature /= Void
	associated_class_not_void: associated_class /= Void

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
