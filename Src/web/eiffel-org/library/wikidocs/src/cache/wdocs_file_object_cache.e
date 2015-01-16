note
	description: "Summary description for {WDOCS_FILE_OBJECT_CACHE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FILE_OBJECT_CACHE [G -> ANY]

inherit
	WDOCS_FILE_CACHE [G]

	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Implementation

	file_to_item (f: FILE): detachable G
		local
			retried: BOOLEAN
			l_reader: SED_MEDIUM_READER_WRITER
			l_void: detachable G
		do
			if retried then
				Result := l_void
			else
				create l_reader.make_for_reading (f)
				if attached {G} retrieved (l_reader, True) as l_data then
					Result := l_data
				end
			end
		rescue
			retried := True
			retry
		end

	item_to_file (a_data: G; f: FILE)
		local
			l_writer: SED_MEDIUM_READER_WRITER
		do
			create l_writer.make_for_writing (f)
			basic_store (a_data, l_writer, True)
		end

end
