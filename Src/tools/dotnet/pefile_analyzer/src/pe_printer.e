note
	description: "Summary description for {PE_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PRINTER

inherit
	PE_ITERATOR
		redefine
			visit_root,
			visit_tables,
			visit_table,
			visit_table_entry,
			visit_item,
			visit_string_heap,
			visit_user_string_heap,
			visit_guid_heap,
			visit_blob_heap
		end

create
	make

feature {NONE} -- Access

	make (o: APP_OUTPUT)
		do
			output := o
		end

	output: APP_OUTPUT

feature -- Visitor

	visit_root (o: PE_MD_ROOT)
		local
			i: INTEGER
		do
			output.put_string ("[Metadata Root] 0x"+short_hex_string (o.starting_address.to_hex_string)+"%N")
			output.indent
			output.put_string (" - signature: " + o.signature.to_string + "%N")
			output.put_string (" - major.minor: " + o.major_version.value.out
							+ "." + o.minor_version.value.out + "%N")
			output.put_string ({STRING_32} " - version: " + o.version.to_string + "%N")
			output.put_string (" - flags: " + o.flags.to_string + "%N")
			output.put_string (" - streams: " + o.streams_count.to_string + "%N")
			output.indent
			i := 0
			across
				o.streams as ic
			loop
				i := i + 1
--				output.put_string ("%T ")
				output.put_string (short_hex_string (ic.item.offset.declaration_address.to_hex_string) + ":")
				output.put_string ("["+ i.out+"]"
					+ " offset=" + ic.item.offset.to_string
					+ " size=" + ic.item.size.to_string
					+ " name=" + ic.item.name.to_string
					+ "%N")
			end
			output.exdent
			output.put_string (" - String heap("+o.metadata_string_head.size.out+"): 0x" + short_hex_string (o.metadata_string_head.address.to_hex_string) + "%N")
			output.put_string (" - UserString heap("+o.metadata_user_string_head.size.out+"): 0x" + short_hex_string (o.metadata_user_string_head.address.to_hex_string) + "%N")
			output.put_string (" - GUID heap("+o.metadata_guid_head.size.out+"): 0x" + short_hex_string (o.metadata_guid_head.address.to_hex_string) + "%N")
			output.put_string (" - Blob heap("+o.metadata_blob_head.size.out+"): 0x" + short_hex_string (o.metadata_blob_head.address.to_hex_string) + "%N")
			output.put_string (" - Metadata table: 0x" + short_hex_string (o.metadata_tables_address.to_hex_string) + "%N")

			output.exdent
			output.put_line_divider
			Precursor (o)
		end

	visit_tables (o: PE_MD_TABLES)
		local
			i,u: INTEGER
		do
			output.put_string ("[Metadata Tables] 0x"+short_hex_string (o.starting_address.to_hex_string)+"%N")
			output.put_string (" - major.minor: " + o.major_version.to_string + "." + o.minor_version.to_string + "%N")
			output.put_string (" - HeapSizes: " + o.heap_sizes.to_string + "%N")
			output.put_string (" - Valid : " + o.valid.to_binary_string + "%N")
			output.put_string (" - Sorted: " + o.sorted.to_binary_string + "%N")
			output.put_string (" - Counts: ")
			from
				i := o.tables.lower
				u := o.tables.upper
			until
				i > u
			loop
				if o.tables [i] /= Void then
					output.put_string (
						i.to_natural_8.to_hex_string + "."
						+ o.table_name (i.to_natural_32)
						+ "(" + o.tables_counts[i].out + ") ")
				end
				i := i + 1
			end
			output.put_new_line
			output.put_line_divider
			Precursor (o)
		end

	visit_table (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
		local
			i: INTEGER
		do
			output.put_string ("[Table " + o.tables.table_name (o.table_id)+ " " + o.table_id.to_natural_8.to_hex_string +"]("+ o.count.out +")"
								+ " 0x"+ short_hex_string (o.address.to_hex_string)
								+ "%N")
--			output.indent
			if
				not o.entries.is_empty  and then
				attached o.entries.first as e
			then
				output.put_string ("# Columns: " + e.description + "%N")
			end
			table_entry_index := 0
			Precursor (o)
--			output.exdent
			output.put_line_divider
			output.flush
		end

	table_entry_index: INTEGER

	visit_table_entry (o: PE_MD_TABLE_ENTRY)
		do
			table_entry_index := table_entry_index + 1
			output.put_string ("[0x" + o.token.to_hex_string + " #" + table_entry_index.out +"] ")
			output.put_string (o.to_string)
			output.put_new_line
			if o.has_error then
				across
					o.errors as err_ic
				loop
					output.put_string (" => ERROR: ")
					output.put_string (err_ic.item.to_string)
					output.put_new_line
				end
			end
			Precursor (o)
		end

	visit_item (o: PE_ITEM)
		do
			Precursor (o)
		end

	visit_string_heap (o: PE_STRING_HEAP)
		local
			i: INTEGER
			s: READABLE_STRING_32
			offset: NATURAL_32
			b: NATURAL_32
		do
			output.put_string ("[String Heap]("+o.count.out+") 0x"+ short_hex_string (o.address.to_hex_string) +" size="+ o.size.out + "%N")
			output.indent
			b := o.address
			i := 0
			across
				o.items as ic
			loop
				s := ic.item.value
				offset := ic.item.declaration_address - b
				output.put_string ("["+ i.out
						+ " 0x" + short_hex_string (ic.item.declaration_address.to_hex_string)
						+ " +" + short_hex_string (offset.to_hex_string)
						+ "] "
						+ " len=0x"+ short_hex_string (s.count.to_hex_string)
						+ " %""+ s +"%"%N")
				i := i + 1
			end

			Precursor (o)
			output.exdent
			output.put_line_divider
			output.flush
		end
	visit_user_string_heap (o: PE_USER_STRING_HEAP)
		local
			i: INTEGER
			s: READABLE_STRING_32
			offset, b: NATURAL_32
		do
			output.put_string ("[UserString Heap]("+o.count.out+") 0x"+ short_hex_string (o.address.to_hex_string) +" size="+ o.size.out +"%N")
			output.indent

			b := o.address

			i := 0
			across
				o.items as ic
			loop
				s := ic.item.string_32
				offset := ic.item.declaration_address - b
				output.put_string ("["+ i.out
						+ " 0x" + short_hex_string (ic.item.declaration_address.to_hex_string)
						+ " +" + short_hex_string (offset.to_hex_string)
						+ "] "
						+ " len=0x"+ short_hex_string (s.count.to_hex_string)
						+ " %""+ s +"%"%N")
				i := i + 1
			end
			Precursor (o)
			output.exdent
			output.flush
		end
	visit_guid_heap (o: PE_GUID_HEAP)
		local
			i: INTEGER
		do
			output.put_string ("[Guid Heap]("+o.count.out+") 0x"+ short_hex_string (o.address.to_hex_string) +" size="+ o.size.out +"%N")
			output.indent

			i := 0
			if attached o.item as str then
				output.put_string ("["+ i.out +"] %""+ str.value +"%"%N")
				i := i + 1
			end

			Precursor (o)
			output.exdent
			output.put_line_divider
			output.flush
		end
	visit_blob_heap (o: PE_BLOB_HEAP)
		local
			i: INTEGER
			s: READABLE_STRING_32
			offset, b: NATURAL_32
		do
			output.put_string ("[Blob Heap]("+o.count.out+") 0x"+ short_hex_string (o.address.to_hex_string) +" size="+ o.size.out +"%N")
			output.indent

			b := o.address

			i := 0
			across
				o.items as ic
			loop
				s := ic.item.dump
				offset := ic.item.declaration_address - b
				output.put_string ("["+ i.out
						+ " 0x" + short_hex_string (ic.item.declaration_address.to_hex_string)
						+ " +" + short_hex_string (offset.to_hex_string)
						+ "] "
						+ " size=0x"+ short_hex_string (ic.item.size.to_hex_string)
						+ " %""+ s +"%"%N")
				i := i + 1
			end
			Precursor (o)
			output.exdent
			output.put_line_divider
			output.flush
		end

feature -- Helpers		

	short_hex_string (s: READABLE_STRING_8): STRING_8
		local
			l_is_first: BOOLEAN
			i,n: INTEGER
		do
			create Result.make (s.count)
			l_is_first := True
			from
				i := 1
				n := s.count
			until
				i > n
			loop
				if s[i] = '0' and l_is_first then
						-- Ignore
				else
					l_is_first := False
					Result.extend (s[i])
				end
				i := i + 1
			end
			if Result.is_empty then
				Result.extend ('0')
			end
			i := Result.count \\ 2
			if i > 0 then
				Result.prepend (create {STRING_8}.make_filled ('0', i))
			end
		end

end
