indexing
	description: "File names constants"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_FILE_NAMES

feature -- Access

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

	Clib_name: STRING is "ecom"
			-- Libray file name

	Generated_files_file_name: STRING is "generated.txt"
			-- File including list of generated files

end -- class WIZARD_SHARED_FILE_NAMES

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
