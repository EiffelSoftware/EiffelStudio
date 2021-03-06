note
	description: "Representation for TYPE [G] class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CLASS_C

inherit
	EIFFEL_CLASS_C
		redefine
			check_validity, new_type, is_type, is_freeze_required_on_melt
		end

	SPECIAL_CONST
		export
			{NONE} all
		end

create
	make

feature -- Status report

	is_type: BOOLEAN = True
			-- Is class TYPE?

	is_freeze_required_on_melt (a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
				-- All builtins of TYPE don't need to be frozen, they are handled in byte code too.
			Result := (a_feature.is_external and not a_feature.extension.is_built_in) or else
				visible_level.is_visible (a_feature, class_id)
		end

feature -- Typing

	new_type (data: CL_TYPE_A): TYPE_CLASS_TYPE
			-- New class type for class TYPE
		do
			create Result.make (data)
				-- Unlike the parent version, each time a new TYPE derivation
				-- is added we do not need to freeze since the built-in implementation
				-- we have will be correct for any expanded generic derivation of TYPE.
				-- The generic derivation for references will be frozen since ANY is always
				-- C generated and thus TYPE [ANY].
			if already_compiled then
					-- Melt all the code written in the associated class of the new class type
				melt_all
			end
		end

feature -- Validity

	check_validity
			-- Check validity of class TYPE
		local
			special_error: SPECIAL_ERROR
		do
				-- First check if current class has one formal generic parameter
			if (generics = Void) or else generics.count /= 1 then
				create special_error.make (array_case_1, Current)
				Error_handler.insert_error (special_error)
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
