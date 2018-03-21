note
	description: "[
			Objects that provide access to constants, possibly loaded from a files.
			Each constant is generated into two features: both a query and a storage
			feature. For example, for a STRING constant named `my_string', the following
			features are generated: my_string: STRING and my_string_cell: CELL [STRING].
			`my_string' simply returns the current item of `my_string_cell'. By seperating
			the constant access in this way, it is possible to change the constant's value
			by either redefining `my_string' in descendent classes or simply performing
			my_string_cell.put ("new_string") as required.
			If you are loading the constants from a file and you wish to reload a different set
			of constants for your interface (e.g. for multi-language support), you may perform
			this in the following way:
			
			set_file_name ("my_constants_file.text")
			reload_constants_from_file
			
			and then for each generated widget, call `set_all_attributes_using_constants' to reset
			the newly loaded constants into the attribute settings of each widget that relies on constants.
			
			Note that if you wish your constants file to be loaded from a specific location,
			you may redefine `initialize_constants' to handle the loading of the file from
			an alternative location.
			
			Note that if you have selected to load constants from a file, and the file cannot
			be loaded, you will get a precondition violation when attempting to access one
			of the constants that should have been loaded. Therefore, you must ensure that either the
			file is accessible or you do not specify to load from a file.
		]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSTANTS_IMP

feature -- Access

	border_width: INTEGER
			-- `Result' is INTEGER constant named `border_width'.
		do
			Result := border_width_cell.item
		end

	border_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `border_width'.
		once
			create Result.put (5)
		end

	cxcxcc: STRING_32
			-- `Result' is STRING_32 constant named `cxcxcc'.
		do
			Result := cxcxcc_cell.item
		end

	cxcxcc_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `cxcxcc'.
		once
			create Result.put ("cccc")
		end

	button_width: INTEGER
			-- `Result' is INTEGER constant named `button_width'.
		do
			Result := button_width_cell.item
		end

	button_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `button_width'.
		once
			create Result.put (80)
		end

	padding_width: INTEGER
			-- `Result' is INTEGER constant named `padding_width'.
		do
			Result := padding_width_cell.item
		end

	padding_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `padding_width'.
		once
			create Result.put (2)
		end

end
