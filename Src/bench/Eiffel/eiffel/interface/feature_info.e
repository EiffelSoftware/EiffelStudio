indexing
	description: "Set of information used to represent information about%N%
		%a FEATURE_I object in a CLASS_INTERFACE."
	date: "$Date$"
	revision: "$Revision$"
	FIXME: "Make this class expanded when expanded are correctly done"

class
	FEATURE_INFO
	
inherit
	HASHABLE
		rename
			hash_code as feature_name_id
		redefine
			is_equal
		end
		
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; cl: CLASS_C) is
			-- Create a new instance of FEATURE_INFO based on `f' extracted from
			-- FEATURE_TABLE of class `cl'. 
		require
			f_not_void: f /= Void
			cl_not_void: cl /= Void
		do
			is_in_interface := True
			private_make (f, cl)
		ensure
			feature_name_id_set: feature_name_id = f.feature_name_id
		end

	private_make (f: FEATURE_I; cl: CLASS_C) is
			-- Create a new instance of FEATURE_INFO based on `f' extracted from
			-- FEATURE_TABLE of class `cl'. 
		require
			f_not_void: f /= Void
			cl_not_void: cl /= Void
		do
			feature_name_id := f.feature_name_id
			is_code_generated := f.to_implement_in (cl) or f.is_attribute
			if not is_code_generated then
				code_location_id := f.written_in
				feature_id := System.class_of_id (code_location_id).
					feature_table.item_id (f.original_name_id).feature_id
			else
				code_location_id := f.written_in
				feature_id := f.feature_id
			end
		ensure
			feature_name_id_set: feature_name_id = f.feature_name_id
		end

feature -- Access

	feature_name_id: INTEGER
			-- Feature name id in NAMES_HEAP.

	feature_id: INTEGER
			-- Feature ID in context of written class of current feature.
			-- Used only for renaming or covariant implicit redefinition

	code_location_id: INTEGER
			-- Class ID where current feature is actually defined.
			-- Used only for renaming or covariant implicit redefinition
			
	is_in_interface: BOOLEAN
			-- Has current feature to be generated in CLASS_INTERFACE.

	is_code_generated: BOOLEAN
			-- Does current feature need its code to be generated? If not,
			-- a dummy feature is generated that calls appropriate routine,
			-- ie routine where code is defined.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := feature_name_id = other.feature_name_id
		end

invariant
	feature_name_id_positive: feature_name_id > 0
	
end -- class FEATURE_INFO
