indexing
	description: "Encapsulation of IMetaDataDispenser"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DISPENSER

inherit
	COM_OBJECT
	
create
	make,
	make_by_pointer
	
feature {NONE} -- Initialization

	make is
			-- New instance of a IMetaDataDispenser.
		do
				-- Initialize COM.
			(create {CLI_COM}).initialize_com

			item := new_md_dispenser
		end

feature -- Definition

	emitter: MD_EMIT is
			-- Create new scope and returns an emitter.
		do
			create Result.make_by_pointer (c_define_scope_for_md_emit (item))
		end
		
feature {NONE} -- Implementation

	new_md_dispenser: POINTER is
			-- New instance of IMetaDataDispenser
		external
			"C use %"cli_writer.h%""
		end

	c_define_scope_for_md_emit (an_item: POINTER): POINTER is
			-- Call `DefineScope (CLSID_CorMetaDataRuntime, 0, IID_IMetaDataEmit, (IUnknown **) &imde)'.
		external
			"C use %"cli_writer.h%""
		end
		
end -- class MD_DISPENSER
