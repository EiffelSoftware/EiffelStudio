note

	description:

		"Equality tester for AUT_FEATURE_OF_TYPE"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_FEATURE_OF_TYPE_EQUALITY_TESTER

inherit
	EQUALITY_TESTER [AUT_FEATURE_OF_TYPE]
		redefine
			test
		end

	KL_EQUALITY_TESTER [AUT_FEATURE_OF_TYPE]
		redefine
			test
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create new tester.
			-- `a_feature' of type `a_type'.
		do
		end

feature -- Status report

	test (v, u: detachable AUT_FEATURE_OF_TYPE): BOOLEAN
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := v.feature_ = u.feature_ and then
							v.type.same_type (u.type) and then
							v.type.is_equivalent (u.type) and then
							v.is_creator = u.is_creator

			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
