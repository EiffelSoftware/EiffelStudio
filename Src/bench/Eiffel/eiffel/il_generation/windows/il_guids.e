indexing
	description: "Predefined GUIDs"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_GUIDS

feature -- Access

	language_guid: COM_GUID is
			-- Language guid used to identify our language when debugging.
		once
			create Result.make (0x6805C61E, 0x8195, 0x490C,
				<<0x87, 0xEE, 0xA7, 0x13, 0x30, 0x1A, 0x67, 0x0C>>)
		ensure
			language_guid_not_void: language_guid /= Void
		end

	vendor_guid: COM_GUID is
			-- Vendor guid used to identify us when debugging.
		once
			create Result.make (0xB68AF30E, 0x9424, 0x485F,
				<<0x82, 0x64, 0xD4, 0xA7, 0x26, 0xC1, 0x62, 0xE7>>)
		ensure
			vendor_guid_not_void: vendor_guid /= Void
		end

	document_type_guid: COM_GUID is
			-- Document type guid.
		once
			create Result.make_empty
		ensure
			document_type_guid_not_void: document_type_guid /= Void
		end

end -- class IL_GUIDS
