note
	description: "[
		Qualifiers is a generic class that holds all the 'tags' you would see on various objects in
		the assembly file.   Where possible things are handled impicitly for example 'nested'
		will automatically be added when a class is nested in another class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	QUALIFIERS

create
	make,
	make_with_flags,
	make_from_other

feature {NONE} -- Initialization

	make
		do
			flags := 0
		end

	make_with_flags (a_flags: INTEGER)
		do
			flags := a_flags
		ensure
			flags_set: flags = a_flags
		end

	make_from_other (other: QUALIFIERS)
		do
			flags := other.flags
		ensure
			falgs_set: flags = other.flags
		end

feature -- Access

	flags: INTEGER;

	after_flags : INTEGER
		do
			Result := {QUALIFIERS_ENUM}.preservesig | {QUALIFIERS_ENUM}.cil | {QUALIFIERS_ENUM}.managed | {QUALIFIERS_ENUM}.runtime
		ensure
			instance_free: class
		end


feature -- Change Element

	set_flags (a_flag: INTEGER)
			-- Set `flags` with `a_flag`.
		do
			flags := a_flag
		end


feature -- Static features

	qualifier_names: ARRAYED_LIST [STRING]
			-- TODO check if this is a good way to represent and
			-- equivalent static field in C++
			-- see QUALIFIERS class.
		once
			create Result.make_from_array (<<
										  	"public",
                                             "private",
                                             "static",
                                             "instance",
                                             "explicit",
                                             "ansi",
                                             "sealed",
                                             "enum",
                                             "value",
                                             "sequential",
                                             "auto",
                                             "literal",
                                             "hidebysig",
                                             "preservesig",
                                             "specialname",
                                             "rtspecialname",
                                             "cil",
                                             "managed",
                                             "runtime",
                                             "",
                                             "virtual",
                                             "newslot",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             "",
                                             ""
			>>)
		ensure
			instance_free: class
		end

	reverse_name_prefix (a_rv: STRING_32; a_parent: detachable DATA_CONTAINER; a_pos: INTEGER; a_type: BOOLEAN): INTEGER
		local
			pos: INTEGER
		do
			pos := a_pos
			if attached a_parent as l_parent then
				pos := reverse_name_prefix (a_rv, l_parent.parent, pos, a_type)
				if pos /= 0 then
					a_rv.append (l_parent.name)
					if attached {CLS_CLASS} l_parent and then
						(attached l_parent.parent or else
						not attached {CLS_CLASS}l_parent.parent)
					then
						if a_type then
							a_rv.append ("%/0xf8/")
						else
							a_rv.append ("/")
						end
					else
						a_rv.append (".")
					end
				elseif attached {ASSEMBLY_DEF} l_parent as l_parent_assembly then
					if l_parent_assembly.is_external then
						a_rv.append ("[")
						a_rv.append (l_parent_assembly.name)
						a_rv.append ("]")
					end
				end
				pos := pos + 1
				Result := pos
			end
		ensure
			instance_free: class
		end

	name_prefix (a_parent: detachable DATA_CONTAINER; a_type: BOOLEAN): STRING_32
		local
			pos: INTEGER
		do
			create Result.make_empty
			if attached a_parent then
				pos := 0
				pos := reverse_name_prefix (Result, a_parent, pos, a_type)
			end
		ensure
			instance_free: class
		end

	name (a_root: STRING_32; a_parent: detachable DATA_CONTAINER; a_type: BOOLEAN): STRING_32
		do
			Result := name_prefix (a_parent, a_type)
			if not Result.is_empty then
				Result := Result.substring (1, Result.count - 1)
			end
			if not a_root.empty then
				if not Result.is_empty then
					Result.append ("::")
				end
				Result.append_character(''')
				Result.append(a_root)
				Result.append_character(''')
			end
		ensure
			instance_free: class
		end

feature -- Output

	il_src_dump_before_flags (a_file: FILE_STREAM)
		local
			n: INTEGER
		do
			n := after_flags.bit_not & flags
			across 0 |..| 31 as i loop
					if n & (1 |<< i) /= 0 then
					a_file.put_string (" ")
					a_file.put_string (qualifier_names[i+1])
				end
			end
		end

	il_src_dump_after_flags (a_file: FILE_STREAM)
		local
			n: INTEGER
		do
			n := after_flags & flags
			across 0 |..| 31 as i loop
					if n & (1 |<< i) /= 0 then
					a_file.put_string (" ")
					a_file.put_string (qualifier_names[i+1])
				end
			end
		end
end
