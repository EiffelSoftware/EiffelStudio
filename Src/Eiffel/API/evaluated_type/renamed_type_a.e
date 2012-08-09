note
	description: "[
		Encapsulates a renaming of features together with a type.
		
		It is called renamed type because it carries extensions with it.
		The most prominent case where we use an instance of this class is the following:
		G -> {A rename f as f_of_a end, B rename f as f_of_b end}
		`A' together with its rename clause corresponds to one instance of this class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RENAMED_TYPE_A

inherit
	COMPILER_EXPORTER

create
	make

feature -- Initialization

	make (a_type: like type; a_renaming: like renaming)
			-- Initialize
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
			renaming := a_renaming
		ensure
			type_set: a_type = type
			renaming_set: renaming = a_renaming
		end

feature -- Access

	type: TYPE_A
			-- Type to which the renaming `renaming' is applied.

	renaming: RENAMING_A
			-- Renaming of features of type `type'.

feature -- Access

	base_class: CLASS_C
			-- Class associated to the current type.		
		do
			Result := type.base_class
		end

feature -- Setters

	set_type (a_type: like type)
			-- Set `type' to `a_type'
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Status

	has_associated_class: BOOLEAN
			-- Does current type have an associated class?
		do
			Result := type.has_associated_class
		end

	has_renaming: BOOLEAN
			-- Does current type have renamed features?
			-- This can occur in code like: "G -> A rename a as b end"
		do
			Result := renaming /= Void and then not renaming.is_empty
		end

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C)
			-- Append `Current' to `text'.
			-- `f' is used to retreive the generic type or argument name as string.
			-- This replaces the old "G#2" or "arg#1" texts in feature signature views.
			-- Actually used in FORMAL_A and LIKE_ARGUMENT.		
		do
			type.ext_append_to (a_text_formatter, c)
			if has_renaming then
				if has_associated_class then
					renaming.append_to_with_pebbles (a_text_formatter, base_class)
				else
					renaming.append_to (a_text_formatter)
				end
			end
		end

invariant
	type_not_void: type /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
