note
	description: "[
			Header of a tar entry.
			Contains the metadata about the following payload.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TAR_HEADER

inherit
	ANY
		redefine
			default_create,
			is_equal
		end

feature {NONE} -- Initialization

	default_create
			-- Create an empty TAR_HEADER.
		do
			create filename.make_empty
			create linkname.make_empty
			create user_name.make_empty
			create group_name.make_empty
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN
			-- Is `other' considered to be the same header as `Current' ?
		do
			Result := 	Current.filename ~ other.filename and
						Current.mode = other.mode and
						Current.user_id = other.user_id and
						Current.group_id = other.group_id and
						Current.size = other.size and
						Current.mtime = other.mtime and
						Current.typeflag = other.typeflag and
						Current.linkname ~ other.linkname and
						Current.user_name ~ other.user_name and
						Current.group_name ~ other.group_name and
						Current.device_major = other.device_major and
						Current.device_minor = other.device_minor
		end

feature -- Fields

	filename: PATH
			-- File name.

	mode: NATURAL_16
			-- Protection mode (lower 12 bits).

	user_id: NATURAL_32
			-- User ID.

	group_id: NATURAL_32
			-- Group ID.

	size: NATURAL_64
			-- File size.

	mtime: NATURAL_64
			-- Last modification time.

	typeflag: CHARACTER_8
			-- File type flag.

	linkname: PATH
			-- Link target.

	user_name: IMMUTABLE_STRING_8
			-- User name.

	group_name: IMMUTABLE_STRING_8
			-- Group name.

	device_major: NATURAL_32
			-- Major device number.

	device_minor: NATURAL_32
			-- Minor device number.

feature -- Mode queries

	is_setuid: BOOLEAN
			-- is the setuid bit set?
		do
			Result := (mode & {TAR_CONST}.setuid_mask) /= 0
		end

	is_setgid: BOOLEAN
			-- is the setgid bit set?
		do
			Result := (mode & {TAR_CONST}.setgid_mask) /= 0
		end

	is_user_readable: BOOLEAN
			-- is the user-read bit set?
		do
			Result := (mode & {TAR_CONST}.uread_mask) /= 0
		end

	is_user_writable: BOOLEAN
			-- is the user-write bit set?
		do
			Result := (mode & {TAR_CONST}.uwrite_mask) /= 0
		end

	is_user_executable: BOOLEAN
			-- is the user-execute bit set?
		do
			Result := (mode & {TAR_CONST}.uexec_mask) /= 0
		end

	is_group_readable: BOOLEAN
			-- is the group-read bit set?
		do
			Result := (mode & {TAR_CONST}.gread_mask) /= 0
		end

	is_group_writable: BOOLEAN
			-- is the group-write bit set?
		do
			Result := (mode & {TAR_CONST}.gwrite_mask) /= 0
		end

	is_group_executable: BOOLEAN
			-- is the group-execute bit set?
		do
			Result := (mode & {TAR_CONST}.gexec_mask) /= 0
		end

	is_other_readable: BOOLEAN
			-- is the other-read bit set?
		do
			Result := (mode & {TAR_CONST}.oread_mask) /= 0
		end

	is_other_writable: BOOLEAN
			-- is the other-write bit set?
		do
			Result := (mode & {TAR_CONST}.owrite_mask) /= 0
		end

	is_other_executable: BOOLEAN
			-- is the other-execute bit set?
		do
			Result := (mode & {TAR_CONST}.oexec_mask) /= 0
		end

feature -- Assign

	set_filename (a_filename: PATH)
			-- Set `filename' to `a_filename'.
		do
			create filename.make_from_separate (a_filename)
		ensure
			correctly_set: filename ~ a_filename
		end

	set_mode (a_mode: NATURAL_16)
			-- Set `mode' to `a_mode'.
		do
			mode := a_mode & 0c7777
		ensure
			correctly_set: mode = a_mode & 0c7777
		end

	set_user_id (a_user_id: NATURAL_32)
			-- Set `user_id' to `a_user_id'.
		do
			user_id := a_user_id
		ensure
			correctly_set: user_id = a_user_id
		end

	set_group_id (a_group_id: NATURAL_32)
			-- Set `group_id' to `a_group_id'.
		do
			group_id := a_group_id
		ensure
			correctly_set: group_id = a_group_id
		end

	set_size (a_size: NATURAL_64)
			-- Set `size' to `a_size'.
		do
			size := a_size
		ensure
			correctly_set: size = a_size
		end

	set_mtime (a_mtime: NATURAL_64)
			-- Set `mtime' to `a_mtime'.
		do
			mtime := a_mtime
		ensure
			correctly_set: mtime = a_mtime
		end

	set_typeflag (a_typeflag: CHARACTER_8)
			-- Set `typeflag' to `a_typeflag'.
		do
			typeflag := a_typeflag
		ensure
			correctly_set: typeflag = a_typeflag
		end

	set_linkname (a_linkname: PATH)
			-- Set `linkname' to `a_linkname'.
		do
			linkname := a_linkname
		ensure
			correctly_set: linkname ~ a_linkname
		end

	set_user_name (a_user_name: STRING_8)
			-- Set `user_name' to `a_user_name'.
		do
			create user_name.make_from_string (a_user_name)
		ensure
			correctly_set: user_name.out ~ a_user_name
		end

	set_group_name (a_group_name: STRING_8)
			-- Set `group_name' to `a_group_name'.
		do
			create group_name.make_from_string (a_group_name)
		ensure
			correctly_set: group_name.out ~ a_group_name
		end

	set_device_major (a_device_major: NATURAL_32)
			-- Set `device_major' to `a_device_major'.
		do
			device_major := a_device_major
		ensure
			correctly_set: device_major = a_device_major
		end

	set_device_minor (a_device_minor: NATURAL_32)
			-- Set `device_minor' to `a_device_minor'.
		do
			device_minor := a_device_minor
		ensure
			correctly_set: device_minor = a_device_minor
		end

	set_setuid (b: BOOLEAN)
			-- Set uid bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.setuid_mask)
		ensure
			correctly_set: is_setuid = b
		end

	set_setgid (b: BOOLEAN)
			-- Set gid bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.setgid_mask)
		ensure
			correctly_set: is_setgid = b
		end

	set_user_readable (b: BOOLEAN)
			-- Set user-read bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.uread_mask)
		ensure
			correctly_set: is_user_readable = b
		end

	set_user_writable (b: BOOLEAN)
			-- Set user-write bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.uwrite_mask)
		ensure
			correctly_set: is_user_writable = b
		end

	set_user_executable (b: BOOLEAN)
			-- Set user-execute bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.uexec_mask)
		ensure
			correctly_set: is_user_executable = b
		end

	set_group_readable (b: BOOLEAN)
			-- Set group-read bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.gread_mask)
		ensure
			correctly_set: is_group_readable = b
		end

	set_group_writable (b: BOOLEAN)
			-- Set group-write bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.gwrite_mask)
		ensure
			correctly_set: is_group_writable = b
		end

	set_group_executable (b: BOOLEAN)
			-- Set group-execute bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.gexec_mask)
		ensure
			correctly_set: is_group_executable = b
		end

	set_other_readable (b: BOOLEAN)
			-- Set other-read bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.oread_mask)
		ensure
			correctly_set: is_other_readable = b
		end

	set_other_writable (b: BOOLEAN)
			-- Set other-write bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.owrite_mask)
		ensure
			correctly_set: is_other_writable = b
		end

	set_other_executable (b: BOOLEAN)
			-- Set other-execute bit to `b'.
		do
			mode := mode.set_bit_with_mask (b, {TAR_CONST}.oexec_mask)
		ensure
			correctly_set: is_other_executable = b
		end

invariant
	valid_mode: (mode & 0c7777 = mode)

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
