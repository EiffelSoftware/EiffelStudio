indexing 
	description: "Assembly prefix factory"
	date: "$$"
	revision: "$$"

class
	ECDP_ASSEMBLY_PREFIX_FACTORY

inherit
	ECDP_SHARED_DATA

create 
	default_create

feature -- Access

	assembly_prefix (a_full_assembly_name: STRING): STRING is
			-- Prefix for assembly with full name `a_full_assembly_name'
		require
			non_void_full_assembly_name: a_full_assembly_name /= Void
			valid_full_assembly_name: not a_full_assembly_name.is_empty
		do
			Result := Predefined_assembly_prefix.item (a_full_assembly_name)
			if Result = Void then
				create Result.make_empty
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation		

	predefined_assembly_prefix: HASH_TABLE [STRING, STRING] is
			-- List of predefined prefix classified per assembly name.
		once
			create Result.make (16)
			Result.put ("", "mscorlib")
			Result.put ("SYSTEM_DLL_", "System")
			Result.put ("XML_", "System.Xml")
			Result.put ("DRAWING_", "System.Drawing")
			Result.put ("WINFORMS_", "System.Windows.Forms")
			Result.put ("", "Accessibility")
			Result.put ("", "System.Runtime.Serialization.Formatters.Soap")
			Result.put ("DATA_", "System.Data")
			Result.put ("", "System.EnterpriseServices")
			Result.put ("WEB_", "System.Web")
			Result.put ("WEB_", "System.Web.RegularExpressions")
			Result.put ("", "Microsoft.VisualC")
			Result.put ("", "System.DirectoryServices")
			Result.put ("", "System.Runtime.Remoting")
			Result.put ("", "cscompmgd")
			Result.put ("WEB_", "System.Web.Services")
		ensure
			non_void_predefined_assembly_prefix: Result /= Void
		end	

end -- Class ECDP_ASSEMBLY_PREFIX_MANAGER