note
	description: "Error with a once creation procedure."

class ONCE_CREATION_ERROR

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			help_file_name
		end

create
	make

feature {NONE} -- Creation

	make (r: like reason; f: FEATURE_I; c: CLASS_C; l: LOCATION_AS)
			-- Create error object for a creation procedure `f` of a once class `c` at location `l`.
		require
			is_valid_reason (r)
			attached f
			attached c
			attached l
		do
			set_class (c)
			set_feature (f)
			set_location (l)
			reason := r
		ensure
			reason = r
			e_feature ~ f.e_feature
			class_c = c
		end

feature -- Error properties

	code: STRING = "VKCC"
			-- Error code.

	help_file_name: STRING_8 = "once_creation_procedure_error"
			-- Help file name.

feature -- Access

	reason: NATURAL_8
			-- Reason of the error.

	is_valid_reason (r: like reason): BOOLEAN
			-- Is `r` a valid reason of a once class creation procedure error?
		do
			Result := (<<reason_inherited, reason_non_once, reason_object_relative>>).has (r)
		end

	reason_inherited: NATURAL_8 = 1
			-- Reason of the error: inherited creation procedure.

	reason_non_once: NATURAL_8 = 2
			-- Reason of the error: non-once creation procedure.

	reason_object_relative: NATURAL_8 = 3
			-- Reason of the error: object-relative creation procedure.

feature -- Output

	build_explain (f: TEXT_FORMATTER)
			-- <Precursor>
		do
			Precursor (f)
			f.add (inspect reason
				when reason_inherited then
					locale.translation_in_context ("Reason: the creation procedure in a once class should be immediate (not inherited).", "compiler.error")
				when reason_non_once then
					locale.translation_in_context ("Reason: the creation procedure in a once class should be a once procedure.", "compiler.error")
				when reason_object_relative then
					locale.translation_in_context ("Reason: the creation procedure in a once class should not be object-relative (should not have an %"OBJECT%" once key).", "compiler.error")
				end)
			f.add_new_line
		end

invariant
	is_valid_reason (reason)

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
