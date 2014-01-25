note
	description: "Summary description for {LINKAGE_TYPES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class
	LINKAGE_TYPES

feature

	external_linkage: INTEGER_32 = 0
	available_externally_linkage: INTEGER_32 = 1
	link_once_any_linkage: INTEGER_32 = 2
	link_once_odr_linkage: INTEGER_32 = 3
	weak_any_linkage: INTEGER_32 = 4
	weak_odr_linkage: INTEGER_32 = 5
	appending_linkage: INTEGER_32 = 6
	internal_linkage: INTEGER_32 = 7
	private_linkage: INTEGER_32 = 8
	linker_private_linkage: INTEGER_32 = 9
	dll_import_linkage: INTEGER_32 = 10
	dll_export_linkage: INTEGER_32 = 11
	external_weak_linkage: INTEGER_32 = 12
	common_linkage: INTEGER_32 = 13
end
