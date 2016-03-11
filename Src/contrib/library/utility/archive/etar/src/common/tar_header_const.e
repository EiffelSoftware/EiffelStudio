note
	description: "[
			Header related constants used by tar
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TAR_HEADER_CONST

feature -- ustar field offsets and lengths (bytes)

	name_offset: 		INTEGER 	=   0			-- filename field offset.
	name_length: 		INTEGER 	= 100 			-- filename field length.
	name_pax_key:		STRING_8 	= "path" 		-- filename pax extended header key.

	mode_offset: 		INTEGER 	= 100 			-- mode field offset.
	mode_length: 		INTEGER 	=   8 			-- mode field length.

	uid_offset: 		INTEGER 	= 108 			-- user-id field offset.
	uid_length: 		INTEGER 	=   8 			-- user-id field length.
	uid_pax_key:		STRING_8	= "uid"			-- user-id pax extended header key.

	gid_offset: 		INTEGER 	= 116 			-- group-id field offset.
	gid_length: 		INTEGER 	=   8 			-- group-id field length.
	gid_pax_key:		STRING_8	= "gid"			-- group-id pax extended header key.

	size_offset: 		INTEGER 	= 124 			-- filesize field offset.
	size_length: 		INTEGER 	=  12 			-- filesize field length.
	size_pax_key:		STRING_8 	= "size"		-- filesize pax extended header key.

	mtime_offset: 		INTEGER 	= 136 			-- last modified field offset.
	mtime_length: 		INTEGER 	=  12 			-- last modified field length.
	mtime_pax_key:		STRING_8	= "mtime"		-- last modified pax extended header key.

	chksum_offset: 		INTEGER 	= 148 			-- checksum field offset.
	chksum_length: 		INTEGER 	=   8 			-- checksum field length.

	typeflag_offset: 	INTEGER		= 156			-- typeflag field offset.
	typeflag_length: 	INTEGER 	=   1 			-- typeflag field length.

	linkname_offset: 	INTEGER 	= 157 			-- linkname (pointee of link) field offset.
	linkname_length: 	INTEGER 	= 100 			-- linkname (pointee of link) field length.
	linkname_pax_key:	STRING_8	= "linkpath"	-- linkname (pointee of link) pax extended header key.

	magic_offset: 		INTEGER 	= 257			-- magic field offset.
	magic_length: 		INTEGER 	=   6 			-- magic field length.

	version_offset: 	INTEGER 	= 263 			-- version field offset.
	version_length: 	INTEGER 	=   2 			-- version field length.

	uname_offset: 		INTEGER 	= 265 			-- username field offset.
	uname_length: 		INTEGER 	=  32 			-- username field length.
	uname_pax_key:		STRING_8	= "uname"		-- username pax extended header key.

	gname_offset: 		INTEGER 	= 297 			-- groupname field offset.
	gname_length: 		INTEGER 	=  32 			-- groupname field length.
	gname_pax_key:		STRING_8	= "gname"		-- groupname pax extended header key.

	devmajor_offset: 	INTEGER 	= 329 			-- device major field offset.
	devmajor_length: 	INTEGER 	=   8 			-- device major field length.

	devminor_offset: 	INTEGER 	= 337 			-- device minor field offset.
	devminor_length: 	INTEGER 	=   8 			-- device minor field length.

	prefix_offset: 		INTEGER 	= 345 			-- filename prefix field offset.
	prefix_length: 		INTEGER 	= 155 			-- filename prefix field length.

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
