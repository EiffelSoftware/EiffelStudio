class
	ASSEMBLY_INFORMATION_THREAD

inherit
	THREAD

create
	make

feature -- Initialization

	make (an_assembly: CONSUMED_ASSEMBLY) is
			-- 
		require
			non_void_an_assembly: an_assembly /= Void
		do
			assembly := an_assembly
		ensure
			assembly_set: assembly = an_assembly
		end
		
feature -- Access

	assembly: CONSUMED_ASSEMBLY
			-- Assembly on witch we want informations.

feature -- Implementation

	assembly_path: STRING is "C:\WINNT\Microsoft.NET\Framework\v1.0.3705\"

	execute is
			-- define the deferred feature from THREAD.
		local
			l_assembly_info: ASSEMBLY_INFORMATION
		do
			create l_assembly_info.make (assembly_path + assembly.name + ".xml")
			if l_assembly_info /= Void then
				(create {CACHE}).assemblies_informations.put (l_assembly_info, assembly.out)
			end
		end
		
invariant
	non_void_assembly: assembly /= VOid
	
end -- class ASSEMBLY_INFORMATION_THREAD
