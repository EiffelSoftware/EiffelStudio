-- Internface for unique feature

class UNIQUE_I 

inherit
	CONSTANT_I
		redefine
			is_unique, check_types, equiv, value, 
			replicated, unselected, new_api_feature
		end
	
feature 

	value: INT_VALUE_I
			-- Value of the constant in the class
			-- [Note that this value is processed during second pass by
			-- feature `feature_unit' of class INHERIT_TABLE.]

	is_unique: BOOLEAN is True
			-- Is the current feature a unique one ?

	equiv (other: FEATURE_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
		local
			other_unique: UNIQUE_I
		do
			other_unique ?= other;
			if other_unique /= Void then
				Result := basic_equiv (other_unique)
					and then value.int_val = other_unique.value.int_val
			end;
			if Not Result then
				System.current_class.insert_changed_feature (feature_name_id)
			end
		end

	same_value (other: FEATURE_I): BOOLEAN is
		require
			other /= Void
			other.is_unique
		local
			other_unique: UNIQUE_I
		do
			other_unique ?= other
			Result := value.int_val = other_unique.value.int_val
		end

	check_types (feat_tbl: FEATURE_TABLE) is
			-- Check Result
		local
			actual_type: TYPE_A
			vqui: VQUI
		do
			old_check_types (feat_tbl)

			actual_type := type.actual_type
			if
				feat_tbl.associated_class = written_class
				and then not actual_type.is_integer
			then
					-- Type of unique constant is not INTEGER
				!! vqui
				vqui.set_class (written_class)
				vqui.set_feature_name (feature_name)
				vqui.set_type (actual_type)
				Error_handler.insert_error (vqui)
			end
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_UNIQUE_I
		do
			!!rep
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_UNIQUE_I
		do
			!!unselect
			transfer_to (unselect)
			unselect.set_access_in (in)
			Result := unselect
		end

feature {NONE} -- Implementation

	new_api_feature: E_UNIQUE is
			-- API feature creation
		local
			t: TYPE_A
		do
			t ?= type
			!! Result.make (feature_name, feature_id)
			if t = Void then
				t := type.actual_type
			end
			Result.set_type (t)
			Result.set_value (value.string_value)
		end

end
