note
	description: "Summary description for {PE_MD_ROOT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MD_ROOT

inherit
	PE_VISITABLE

create
	make

feature -- Initialization

	make (pe: PE_FILE)
		local
			n: NATURAL_32
			o: ANY
			i: NATURAL_16
			n32, offset, sz: PE_NATURAL_32_ITEM
			s: READABLE_STRING_8
			str: PE_STRING_ITEM
			l_count: INTEGER
		do
			signature := pe.read_natural_32_item ("Signature")
			major_version := pe.read_natural_16_item ("MajorVersion")
			minor_version := pe.read_natural_16_item ("MinorVersion")
			reserved := pe.read_natural_32_item ("reserved")
			length := pe.read_natural_32_item ("Length")
			version := pe.read_null_ended_string_item ("Version")
--			n := version.size \\ 4
			n := pe.position.to_natural_32 \\ 4
--			if n > 0 then
				o := pe.read_bytes (4 - n)
--			end


			flags := pe.read_natural_16_item ("Flags")
			streams_count := pe.read_natural_16_item ("Streams")
			l_count := streams_count.value
			create streams.make (l_count)
			from
				i := 1
			until
				i > l_count
			loop
					-- Offset
				offset := pe.read_natural_32_item ("Offset")
					-- Size
				sz := pe.read_natural_32_item ("Size")
					-- Size
				str := pe.read_null_ended_string_item ("Name")
				streams[str.string_32] := [offset, sz, str]
--				n := str.size \\ 4
				n := pe.position.to_natural_32 \\ 4
--				if n > 0 then
					o := pe.read_bytes (4 - n)
--				end
				i := i +1
			end
		end

feature -- Access

	starting_address: NATURAL_32
		do
			Result := signature.declaration_address
		end

	metadata_string_head: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached streams ["#Strings"] as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_user_string_head: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached streams ["#US"] as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_guid_head: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached streams ["#GUID"] as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_blob_head: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached streams ["#Blob"] as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_tables_address: NATURAL_32
		do
			Result := starting_address
			if attached streams ["#~"] as tu then
				Result := Result + tu.offset
			end
		end

	metadata_tables (pe: PE_FILE): PE_MD_TABLES
		do
			Result := internal_metadata_tables
			if Result = Void then
				Result := pe.metadata_tables
				internal_metadata_tables := Result
			end
		end

feature -- Access		

	signature: PE_NATURAL_32_ITEM
	major_version,
	minor_version: PE_NATURAL_16_ITEM
	reserved: PE_NATURAL_32_ITEM
	length: PE_NATURAL_32_ITEM
	version: PE_STRING_ITEM
	flags: PE_NATURAL_16_ITEM
	streams_count: PE_NATURAL_16_ITEM

	streams: STRING_TABLE [TUPLE [offset, size: PE_NATURAL_32_ITEM; name: PE_STRING_ITEM]]

	internal_metadata_tables: detachable like metadata_tables

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_root (Current)
		end

end
