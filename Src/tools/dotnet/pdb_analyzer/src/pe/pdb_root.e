note
	description: "Summary description for {PE_MD_ROOT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_ROOT

inherit
	PE_VISITABLE

create
	make

feature -- Initialization

	make (pe: PDB_FILE)
		local
			n: NATURAL_32
			o: PE_BYTES_ITEM
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
--				o := pe.read_bytes (4 - n)
				o := pe.read_bytes_item ("align-4", 4 - n, pe.position.to_natural_32)
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
				record_stream ([offset, sz, str], str.string_32)
--				n := str.size \\ 4
				n := pe.position.to_natural_32 \\ 4
--				if n > 0 then
--					o := pe.read_bytes (4 - n)
					o := pe.read_bytes_item ("align-4", 4 - n, pe.position.to_natural_32)
--				end
				i := i +1
			end
		end

feature -- Access

	starting_address: NATURAL_32
		do
			Result := signature.declaration_address
		end

	metadata_pdb_heap: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached stream_info ("#Pdb") as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_string_heap: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached stream_info ("#Strings") as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_user_string_heap: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached stream_info ("#US") as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_guid_heap: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached stream_info ("#GUID") as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_blob_heap: TUPLE [address: NATURAL_32; size: NATURAL_32]
		local
			a, sz: NATURAL_32
		do
			a := starting_address
			if attached stream_info ("#Blob") as tu then
				a := a + tu.offset
				sz := tu.size.value
			end
			Result := [a, sz]
		end

	metadata_tables_address: NATURAL_32
		local
			d: like stream_info
		do
			Result := starting_address
			d := stream_info ("#~")
			if d = Void then
				d := stream_info ("#-") -- TODO: check why this occurs?
			end
			if d /= Void then
				Result := Result + d.offset
			end
		end

	metadata_tables (pe: PDB_FILE): PDB_MD_TABLES
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

	streams: STRING_TABLE [attached like stream_info]

	record_stream (d: attached like stream_info; n: READABLE_STRING_GENERAL)
		do
			if n.ends_with ("%U") then
				streams [n.substring (1, n.count - 1)] := d
			else
				streams [n] := d
			end
		end

	stream_info (n: READABLE_STRING_GENERAL): detachable TUPLE [offset, size: PE_NATURAL_32_ITEM; name: PE_STRING_ITEM]
		do
			Result := streams [n]
		end

	internal_metadata_tables: detachable like metadata_tables

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_root (Current)
		end

end
