indexing
	description: "Information about feature recently added to system"
	date: "$Date$"
	revision: "$Revision$"

deferred class MELTED_INFO 

inherit
	HASHABLE
		rename
			hash_code as body_index
		redefine
			is_equal
		end
		
	SHARED_EXEC_TABLE
		undefine
			is_equal
		end

	SHARED_EXTERNALS
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (f: FEATURE_I; associated_class: CLASS_C) is
			-- Initialization
		require
			feature_not_void: f /= Void
			class_not_void: associated_class /= Void
		local
			attr: ATTRIBUTE_I
		do
			body_index := f.body_index
			pattern_id := f.pattern_id
			attr ?= f
			if attr /= Void then
				written_in := attr.generate_in
			else
				written_in := f.written_in
			end
			result_type := f.type.actual_type.type_i
		end

feature -- Update

	update_execution_unit (class_type: CLASS_TYPE) is
			-- Update execution unit. 
		local
			exec_unit: EXECUTION_UNIT
		do
			exec_unit := execution_unit (class_type)
		end

	melt (class_type: CLASS_TYPE; feat_tbl: FEATURE_TABLE) is
			-- Melt the feature
		local
			exec_unit: EXECUTION_UNIT
		do
			exec_unit := execution_unit (class_type)
			associated_feature (feat_tbl).melt (exec_unit)
		end

feature -- Access

	body_index: INTEGER
			-- Body index of feature to melt.
	
	pattern_id: INTEGER
			-- Pattern id of feature to mel.
	
	written_in: INTEGER
			-- Class where current feature is to mel.
	
	result_type: TYPE_I
			-- Return type of current feature to melt.

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := body_index = other.body_index
		end

feature {NONE} -- Implementation

	execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Execution unit for Current. 
		require
			class_type_not_void: class_type /= Void
		local
			external_unit: EXT_EXECUTION_UNIT
			info: EXTERNAL_INFO
		do
				-- Evaluation of execution unit
			Result := internal_execution_unit (class_type)

				-- Update Execution_table with new routine information
			Execution_table.update_with (Result)

				-- Get the updated EXECUTION_UNIT
			Result := Execution_table.last_unit

				-- Update the external table
			if Result.is_external then
				external_unit ?= Result
				check
					not System.il_generation implies Externals.has (external_unit.external_name_id)
				end
				info := Externals.item (external_unit.external_name_id)
				if info /= Void then
						-- Not Void means it is a C externals.
					info.set_execution_unit (external_unit)
				end
			end
		end

	internal_execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Create new EXECUTION_UNIT corresponding to Current type.
		require
			class_type_not_void: class_type /= Void
		deferred
		end

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		require
			good_argument: feat_tbl /= Void
		deferred
		ensure
			Result_exists: Result /= Void
		end

end
