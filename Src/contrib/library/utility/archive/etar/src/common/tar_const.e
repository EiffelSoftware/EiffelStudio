note
	description: "[
			Constants used by tar
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TAR_CONST

inherit
	TAR_HEADER_CONST

feature -- Mode/Permission masks

	setuid_mask: NATURAL_16 = 0c04000 -- Setuid bitmask.

	setgid_mask: NATURAL_16 = 0c02000 -- Setgid bitmask.

	uread_mask: NATURAL_16 = 0c00400 -- User readable bitmask.

	uwrite_mask: NATURAL_16 = 0c00200 -- User writable bitmask.

	uexec_mask: NATURAL_16 = 0c00100 -- User executable bitmask.

	gread_mask: NATURAL_16 = 0c00040 -- Group readable bitmask.

	gwrite_mask: NATURAL_16 = 0c00020 -- Group writable bitmask.

	gexec_mask: NATURAL_16 = 0c00010 -- Group executable bitmask.

	oread_mask: NATURAL_16 = 0c00004 -- Other readable bitmask.

	owrite_mask: NATURAL_16 = 0c00002 -- Other writable bitmask.

	oexec_mask: NATURAL_16 = 0c00001 -- Other executable bitmask.

feature -- Typeflags

	tar_typeflag_regular_file:		CHARACTER_8 = '0' -- Typeflag for regular files.

	tar_typeflag_regular_file_old:	CHARACTER_8 = '%U' -- Typeflag for regular files (deprecated).

	tar_typeflag_hardlink:			CHARACTER_8 = '1' -- Typeflag for hardlinks.

	tar_typeflag_symlink:			CHARACTER_8 = '2' -- Typeflag for symlinks.

	tar_typeflag_character_special: CHARACTER_8 = '3' -- Typeflag for character device nodes.

	tar_typeflag_block_special:		CHARACTER_8 = '4' -- Typeflag for block device nodes.

	tar_typeflag_directory:			CHARACTER_8 = '5' -- Typeflag for directories.

	tar_typeflag_fifo:				CHARACTER_8 = '6' -- Typeflag for named pipes.

	tar_typeflag_contiguous:		CHARACTER_8 = '7' -- Typeflag for contigeous files.

	tar_typeflag_pax_extended:		CHARACTER_8 = 'x' -- Typeflag for pax extended header.

	tar_typeflag_pax_global:		CHARACTER_8 = 'g' -- Typeflag for pax global header.

	tar_header_only_typeflags:		STRING_8	= "123456"	-- All predefined header types that have no payload.

feature -- Miscellaneous
	tar_block_size:	INTEGER = 512 -- Block size in tar.

	ustar_magic: STRING_8 = "ustar" -- ustar magic.

	ustar_version: STRING_8 = "00" -- ustar version.

feature -- PAX

	pax_header_filename: STRING_8 = "./PaxHeader" -- Filename to use for pax header.

	pax_header_uid: NATURAL_32 = 0 -- User-id to use for pax header.

	pax_header_gid: NATURAL_32 = 0 -- Group-id to use for pax header.

	pax_header_mode: NATURAL_16 = 0c644 -- Permissions o use for pax header.

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
