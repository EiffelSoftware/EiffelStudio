indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyProcessorAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYPROCESSORATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_processor_attribute

feature {NONE} -- Initialization

	frozen make_assembly_processor_attribute (processor2: INTEGER) is
			-- Valid values for `processor2' are:
			-- INTEL_386 = 386
			-- INTEL_486 = 486
			-- INTEL_PENTIUM = 586
			-- MIPS_R4000 = 4000
			-- ALPHA_21064 = 21064
			-- PPC_601 = 601
			-- PPC_603 = 603
			-- PPC_604 = 604
			-- PPC_620 = 620
			-- HITACHI_SH3 = 10003
			-- HITACHI_SH3E = 10004
			-- HITACHI_SH4 = 10005
			-- MOTOROLA_821 = 821
			-- SHx_SH3 = 103
			-- SHx_SH4 = 104
			-- STRONGARM = 2577
			-- ARM720 = 1824
			-- ARM820 = 2080
			-- ARM920 = 2336
			-- ARM_7TDMI = 70001
		require
			valid_processor_id: processor2 = 386 or processor2 = 486 or processor2 = 586 or processor2 = 4000 or processor2 = 21064 or processor2 = 601 or processor2 = 603 or processor2 = 604 or processor2 = 620 or processor2 = 10003 or processor2 = 10004 or processor2 = 10005 or processor2 = 821 or processor2 = 103 or processor2 = 104 or processor2 = 2577 or processor2 = 1824 or processor2 = 2080 or processor2 = 2336 or processor2 = 70001
		external
			"IL creator signature (enum System.Configuration.Assemblies.ProcessorID) use System.Reflection.AssemblyProcessorAttribute"
		end

feature -- Access

	frozen get_processor: INTEGER is
		external
			"IL signature (): System.UInt32 use System.Reflection.AssemblyProcessorAttribute"
		alias
			"get_Processor"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYPROCESSORATTRIBUTE
