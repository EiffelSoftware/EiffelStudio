indexing
	description: "[
		Objects that validate class names.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS_NAME_VALIDATOR

inherit
	ES_VALIDATOR

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

feature -- Validation

	validate_class_name (a_class_name: !STRING)
			-- Is name a valid name for an Eiffel class?
			--
			-- `a_class_name': Name to be validated.
		do
			reset
			if a_class_name.is_empty then
				set_error (e_empty_class_name)
			elseif not is_valid_class_name (a_class_name) then
				set_formatted_error (e_invalid_class_name, [a_class_name])
			end
		end

	validate_new_class_name (a_class_name: !STRING; a_project: !E_PROJECT)
			-- Is name a valid name for a new Eiffel class?
			--
			-- `a_class_name': Name for new Eiffel class.
			-- `a_project': Project in which new class will be created.
		local
			l_uni: UNIVERSE_I
		do
			validate_class_name (a_class_name)
			if is_valid then
				l_uni := a_project.universe
				if not l_uni.classes_with_name (a_class_name.as_upper).is_empty then
					set_formatted_error (e_class_already_exists, [a_class_name])
				end
			end
		end

feature {NONE} -- Internationalization

	e_empty_class_name: STRING = "Eiffel class names can not be empty."
	e_invalid_class_name: STRING = "$1 is not a valid Eiffel class name."
	e_class_already_exists: STRING = "An Eiffel class with the name $1 already exists."


;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
