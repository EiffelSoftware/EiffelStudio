note
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
			assert_id_set,
			can_be_encapsulated,
			generation_class_id,
			has_code,
			new_deferred_anchor,
			new_rout_entry,
			set_assert_id_set,
			to_melt_in,
			to_generate_in,
			transfer_to,
			transfer_from
		end

feature {NONE} -- Initialization

	make
			-- Initialize an encapsulated feature.
		do
			set_is_require_else (True)
			set_is_ensure_then (True)
		end

feature -- Status report

	has_code: BOOLEAN
			-- <Precursor>
		do
			Result := has_combined_assertion
		end

feature -- Access

	can_be_encapsulated: BOOLEAN = True
			-- Current feature can be encapsulated (eg attribute or
			-- constant definition with a deferred routine)

	generate_in: INTEGER
			-- Class id where an equivalent feature has to be generated
			-- `0' means no need for an encapsulation

	generation_class_id: INTEGER
			-- Id of the class where the feature has to be generated in
		do
			Result := generate_in
			if Result = 0 then
				Result := written_in
			end
		end

	assert_id_set: ASSERT_ID_SET
			-- Assertions

feature -- Status

	to_melt_in (a_class: CLASS_C): BOOLEAN
			-- Has the current feature in class `a_class" ?
		do
			Result := to_generate_in (a_class)
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN
			-- Has the current feature in class `a_class" ?
		do
			Result := a_class.class_id = generate_in or else is_replicated_directly
		end

feature -- Undefinition

	new_deferred_anchor: DEF_FUNC_I
			-- <Precursor>
		do
			check False then end
		end

feature -- Element change

	set_assert_id_set (set: like assert_id_set)
			-- Assign `set' to `assert_id_set'.
		do
			assert_id_set := set
		end

	transfer_to (other: like Current)
			-- Transfer data from `Current' to `other'.
		do
			Precursor (other)
			other.set_assert_id_set (assert_id_set)
			if generate_in > 0 then
				other.set_generate_in (generate_in)
			end
		end

	transfer_from (other: like Current)
			-- Transfer data from `Current' to `other'.
		do
			Precursor (other)
			assert_id_set := other.assert_id_set
			if other.generate_in > 0 then
				set_generate_in (other.generate_in)
			end
		end

feature -- Setting

	set_generate_in (class_id: INTEGER)
			-- Assign `class_id' to `generate_in'.
		require
			valid_class_id: class_id > 0 or else (is_replicated_directly and then class_id = 0)
		do
			generate_in := class_id
		ensure
			generate_in_set: generate_in = class_id
		end

feature -- Final code generation

 	new_rout_entry (t: CLASS_TYPE; c: like {CLASS_C}.class_id): ROUT_ENTRY
			-- <Precursor>
		require else
			has_to_be_generated: generate_in > 0
		local
			old_written_in: like written_in
		do
			old_written_in := written_in
			if
				generate_in /= 0 and then
				(is_constant implies not byte_context.workbench_mode)
			then
					-- Assume the constant or variable attribute is written in and accessed on the class with ID `generate_in`.
					-- This is because real code generation happens in that class except when generating constants in workbench mode.
				written_in := generate_in
			end
			Result := Precursor (t, c)
				-- Restore original state.
			written_in := old_written_in
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
