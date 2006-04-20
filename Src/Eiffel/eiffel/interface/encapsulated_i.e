indexing
	description: "Abstract representation of a feature that can be encapsulated"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCAPSULATED_I

inherit
	FEATURE_I
		redefine
			can_be_encapsulated, generation_class_id,
			to_melt_in, to_generate_in, transfer_to
		end

feature {NONE} -- Initialization

	make is
			-- Initialize an encapsulated feature.
		do
			set_is_require_else (True)
			set_is_ensure_then (True)
		end

feature -- Access

	can_be_encapsulated: BOOLEAN is True
			-- Current feature can be encapsulated (eg attribute or
			-- constantn definition with a deferred routine)

	generate_in: INTEGER
			-- Class id where an equivalent feature has to be generated
			-- `0' means no need for an encapsulation

	generation_class_id: INTEGER is
			-- Id of the class where the feature has to be generated in
		do
			if generate_in /= 0 then
				Result := generate_in
			else
				Result := written_in
			end
		end

feature -- Status

	to_melt_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := to_generate_in (a_class)
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := a_class.class_id = generate_in
		end

feature -- Element change

	transfer_to (other: like Current) is
			-- Transfer data from `Current' to `other'.
		do
			Precursor {FEATURE_I} (other)
			if generate_in > 0 then
				other.set_generate_in (generate_in)
			end
		end

feature -- Setting

	set_generate_in (class_id: INTEGER) is
			-- Assign `class_id' to `generate_in'.
		require
			valid_class_id: class_id > 0
		do
			generate_in := class_id
		ensure
			generate_in_set: generate_in = class_id
		end

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

end -- class ENCAPSULATED_I
