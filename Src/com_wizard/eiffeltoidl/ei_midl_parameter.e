indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_PARAMETER

inherit
	EI_PARAMETER
		redefine
			make,
			code
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_SPECIAL_SYMBOLS
		export
			{NONE} all
		end


create
	make

feature {NONE} -- Initialization

	make (l_name, l_type: STRING) is
			-- Initialize object.
		do
			Precursor (l_name, l_type)
			flag := Paramflag_fin
		end

feature -- Access

	flag: INTEGER
			-- Parameter flag.
			-- See {ECOM_PARAM_FLAGS} for value

feature -- Element change

	set_flag (l_flag: INTEGER) is
			-- Set 'flag' to 'l_flag'.
		do
			flag := l_flag
		ensure
			value_set: flag = l_flag
		end

feature -- Output

	code: STRING is
			-- Code output
		do
			if is_paramflag_fin (flag) then
				Result := "[in]"
			else
				Result := "[in, out]"
			end

			Result.append (type)
			Result.append (" ")
			Result.append (name)
		end

end -- class EI_MIDL_PARAMETER
