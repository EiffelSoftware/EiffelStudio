indexing 
	description: "Common data used both by the GUI and the business logic"

class 
	WIZARD_SHARED_DATA

feature -- Access

	shared_wizard_environment: WIZARD_ENVIRONMENT is
			-- Data used to generate code
		do
			Result := Shared_environment_cell.item
		end

	Generated_iid_file_name: STRING is "$ecom_iid_temp.c"
			-- Midl generated iid file name
	
	Generated_header_file_name: STRING is "$ecom_header_temp.h"
			-- Midl generated header file name
	
	Generated_dlldata_file_name: STRING is "$ecom_data_temp.c"
			-- Midl generated dlldata file name

	Generated_ps_file_name: STRING is "$ecom_ps_temp.c"
			-- Midl generated proxy/stub file name

	Def_file_name: STRING is "$ecom.def"
			-- Path to definition file

feature -- Element Change

	set_shared_wizard_environment (an_environment: WIZARD_ENVIRONMENT) is
			-- Set `shared_wizard_environment' with `an_environment'.
		require
			non_void_environment: an_environment /= Void
		do
			Shared_environment_cell.replace (an_environment)
		ensure
			environment_set: shared_wizard_environment = an_environment
		end

feature {NONE} -- Implementation

	Shared_environment_cell: CELL [WIZARD_ENVIRONMENT] is
			-- Wizard environment shell
		once
			create Result.put (create {WIZARD_ENVIRONMENT}.make)
		end

end -- class SHARED_DATA
