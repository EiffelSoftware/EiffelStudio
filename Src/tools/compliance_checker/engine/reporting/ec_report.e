indexing
	description: "[
		A checked report root node.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_REPORT

inherit
	EC_REPORT_BASE

create
	make
	
feature {NONE} -- Initialization

	make (a_assembly: like assembly) is
			-- Create an initialize a report for `a_assembly'.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			assembly := a_assembly
			create internal_checked_types.make (0)
		ensure
			assembly_set: assembly = a_assembly
		end
		
feature -- Access

	assembly: ASSEMBLY
			-- Assembly report was generated for
			
	types: DYNAMIC_LIST [EC_REPORT_TYPE] is
			-- List of checked report types.
		require
			not_is_being_build: not is_being_built
		do
			Result := internal_checked_types
		end
		
feature -- Access {EC_REPORT_BASE}

	report: EC_REPORT is
			-- Report associated with report entity.
		do
			Result := Current
		end
		
	parent: EC_REPORT_BASE is
			-- Parent report entity of current entity.
		do
			-- There is no parent!
		end
		
feature -- Query

	is_being_built: BOOLEAN 
			-- Is report currently being built?

feature {EC_REPORT_BUILDER} -- Status Setting

	set_is_being_built (a_building: like is_being_built) is
			-- Sets `is_being_build' with `a_building'
		do
			is_being_built := a_building
		ensure
			is_being_built_set: is_being_built = a_building
		end
	
feature {EC_REPORT_BUILDER} -- Basic Operations

	add_type_report (a_report: EC_REPORT_TYPE) is
			-- Adds `a_report' to report
		require
			a_report_not_void: a_report /= Void
			not_already_added: not types.has (a_report)
			is_being_build: is_being_built
		do
			internal_checked_types.extend (a_report)
		ensure
			types_has_report: types.has (a_report)
		end
		
feature {EC_REPORT_BUILDER} -- Removal
		
	wipe_out is
			-- Clears report
		do
			internal_checked_types.wipe_out
		ensure
			internal_checked_types_is_empty: internal_checked_types.is_empty
		end
		
feature {NONE} -- Internal Cached Information

	internal_checked_types: ARRAYED_LIST [EC_REPORT_TYPE]
			-- Internal mutable list of report types
		
invariant
	aassembly_not_void: assembly /= Void
	internal_checked_types_not_void: internal_checked_types /= Void
	
end -- class EC_REPORT
