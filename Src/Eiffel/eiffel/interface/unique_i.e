note
	description: "Representation of a unique constant"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UNIQUE_I

inherit
	CONSTANT_I
		redefine
			is_unique, is_once, is_object_relative_once, check_types, equiv, value,
			replicated, unselected, new_api_feature, selected
		end

create
	make

feature

	value: INTEGER_CONSTANT
			-- Value of the constant in the class
			-- [Note that this value is processed during second pass by
			-- feature `feature_unit' of class INHERIT_TABLE.]

	is_unique: BOOLEAN = True
			-- Is the current feature a unique one ?

	is_once: BOOLEAN = False
			-- Is the constant (implemented like) a once function?

	is_object_relative_once: BOOLEAN = False
			-- Is current feature a once per object feature?

	equiv (other: FEATURE_I): BOOLEAN
			-- Is `other' equivalent to Current ?
		local
			other_unique: UNIQUE_I
		do
			other_unique ?= other;
			if other_unique /= Void then
				Result := basic_equiv (other_unique)
					and then value.is_equivalent (other_unique.value)
			end;
			if Not Result then
				System.current_class.insert_changed_feature (feature_name_id)
			end
		end

	same_value (other: FEATURE_I): BOOLEAN
		require
			other /= Void
			other.is_unique
		local
			other_unique: UNIQUE_I
		do
			other_unique ?= other
			Result := value.is_equal (other_unique.value)
		end

	check_types (feat_tbl: FEATURE_TABLE)
			-- Check Result
		local
			vqui: VQUI
		do
			old_check_types (feat_tbl)
			if
				feat_tbl.associated_class = written_class
				and then not type.actual_type.is_integer
			then
					-- Type of unique constant is not INTEGER
				create vqui
				vqui.set_class (written_class)
				vqui.set_feature_name (feature_name)
				vqui.set_type (type)
				Error_handler.insert_error (vqui)
			end
		end

	replicated (in: INTEGER): FEATURE_I
			-- Replication
		local
			rep: R_UNIQUE_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			rep.set_access_in (in)
			Result := rep
		end

	selected: UNIQUE_I
			-- <Precursor>
		do
			create Result.make
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I
			-- Unselected feature
		local
			unselect: D_UNIQUE_I
		do
			create unselect.make
			transfer_to (unselect)
			unselect.set_access_in (in)
			Result := unselect
		end

feature {NONE} -- Implementation

	new_api_feature: E_UNIQUE
			-- API feature creation
		do
			create Result.make (feature_name_id, alias_name, has_convert_mark, feature_id)
			Result.set_type (type, assigner_name)
			Result.set_value (value.string_value)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
