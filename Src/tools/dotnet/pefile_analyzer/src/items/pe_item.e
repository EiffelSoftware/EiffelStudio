note
	description: "Summary description for {PE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_ITEM

inherit
	PE_VISITABLE

	DEBUG_OUTPUT

--create
--	make

feature {NONE} -- Initialization

	make (a_decl_address, a_start, a_end: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			declaration_address := a_decl_address
			value_begin_address := a_start
			value_end_address := a_end
			pointer := mp
			label := lab
		end

	make_from_item (a_item: PE_ITEM)
		do
				-- Use carefully !!!
				-- WARNING: update the caller class to get the value if needed.!!!
			make (a_item.declaration_address, a_item.value_begin_address, a_item.value_end_address, a_item.pointer, a_item.label)
		end

feature -- Access

	declaration_address: NATURAL_32
	value_begin_address,
	value_end_address: NATURAL_32

	pointer: MANAGED_POINTER

	label: READABLE_STRING_8

	size: NATURAL_32
		do
			Result := value_end_address - value_begin_address
		end

feature -- Access

	associated_structure: detachable PE_STRUCTURE_ITEM

feature -- Element change

	set_associated_structure (i: like associated_structure)
		do
			associated_structure := i
		end

feature -- Error		

	error: detachable PE_ERROR

	has_error: BOOLEAN
		do
			Result := error /= Void
		end

feature -- Info

	info: detachable PE_ITEM_INFO

	set_info (inf: detachable PE_ITEM_INFO)
		do
			info := inf
		end

feature -- Element change

	report_error (err: PE_ERROR)
		do
			error := err
		ensure
			has_error
		end

feature -- Conversion

	to_string: STRING_32
		deferred
--			create Result.make (0)
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
		do
--			Result := {STRING_32} "[" + value_begin_address.to_hex_string + ".." + value_end_address.to_hex_string + "] "
			Result := label.to_string_32 + {STRING_32} "[" + value_begin_address.to_hex_string + "]"
				+ " " + to_string
				+ " /" + dump + "/"

			if attached error as err then
				Result := Result + " <!ERROR=" + err.to_string + "!>"
			end
		end

	dump: STRING_8
		local
			i,n: INTEGER
			mp: MANAGED_POINTER
		do
			mp := pointer
			from
				i := 0
				n := size.to_integer_32
				create Result.make (n * 3)
			until
				i >= n
			loop
				if not Result.is_empty then
					Result.append_character ('-')
				end
				Result.append (mp.read_natural_8 (i).to_hex_string)
				i := i + 1
			end
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_item (Current)
		end

end
