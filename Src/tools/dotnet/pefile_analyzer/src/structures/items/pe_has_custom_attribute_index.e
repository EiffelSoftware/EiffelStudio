class
	PE_HAS_CUSTOM_ATTRIBUTE_INDEX

inherit
	PE_STRUCTURE_TAG_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_has_custom_attribute_index (label, Current)
		end

feature -- Constants

	methoddef: NATURAL_32 = 0
	field: NATURAL_32 = 1
	typeref: NATURAL_32 = 2
	typedef: NATURAL_32 = 3
	param: NATURAL_32 = 4
	interfaceimpl: NATURAL_32 = 5
	memberref: NATURAL_32 = 6
	module: NATURAL_32 = 7
	permission: NATURAL_32 = 8
	property: NATURAL_32 = 9
	event: NATURAL_32 = 10
	standalonesig: NATURAL_32 = 11
	moduleref: NATURAL_32 = 12
	typespec: NATURAL_32 = 13
	assembly: NATURAL_32 = 14
	assemblyref: NATURAL_32 = 15
	file: NATURAL_32 = 16
	exportedtype: NATURAL_32 = 17
	manifestresource: NATURAL_32 = 18
	genericparam: NATURAL_32 = 19
	genericparamconstraint: NATURAL_32 = 20
	methodspec: NATURAL_32 = 21

	tagbit: INTEGER = 5

end
