note
	description: "[
		    Base class for assembly definitions
    		this holds the main assembly ( as a non-external assembly)
    		or can hold an external assembly
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_DEF

inherit

	DATA_CONTAINER
	 	rename
	 		make as make_data_container
	 	end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_external: BOOLEAN; a_byte: detachable ARRAY [NATURAL_8])
		require
			valid_length_iff_atached_byte: attached a_byte and then a_byte.count = 8
		do
			make_data_container (a_name, create {QUALIFIERS}.make)

			if attached a_byte then
				create public_key_token.make_from_array (a_byte)
			else
				create public_key_token.make_filled (0, 1, 8)
			end

			create namespace_cache.make(0)
			create class_cache.make (0)
			create snk_file.make_empty
		ensure
			snk_file_set: snk_file.is_empty
			external_set: not is_external
			loaded_set: not is_loaded
		end

feature -- Access

	revision: INTEGER assign set_revision
			-- `revision'

	build: INTEGER assign set_build
			-- `build'

	minor: INTEGER assign set_minor
			-- `minor'

	major: INTEGER assign set_major
			-- `major'

	is_external: BOOLEAN assign set_is_external
			-- `is_external'

	public_key_token : ARRAY [NATURAL_8]

	snk_file: STRING_32

	namespace_cache: STRING_TABLE [NAMESPACE]

	class_cache: STRING_TABLE [CLS_CLASS]

	is_loaded: BOOLEAN


feature -- Element change

	set_revision (a_revision: like revision)
			-- Assign `revision' with `a_revision'.
		do
			revision := a_revision
		ensure
			revision_assigned: revision = a_revision
		end

	set_build (a_build: like build)
			-- Assign `build' with `a_build'.
		do
			build := a_build
		ensure
			build_assigned: build = a_build
		end

	set_minor (a_minor: like minor)
			-- Assign `minor' with `a_minor'.
		do
			minor := a_minor
		ensure
			minor_assigned: minor = a_minor
		end

	set_major (a_major: like major)
			-- Assign `major' with `a_major'.
		do
			major := a_major
		ensure
			major_assigned: major = a_major
		end

	set_is_external (an_is_external: like is_external)
			-- Assign `is_external' with `an_is_external'.
		do
			is_external := an_is_external
		ensure
			is_external_assigned: is_external = an_is_external
		end

feature -- Output

	il_header_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string (".assembly ")
			if is_external then
				a_file.put_string ("extern ")
			end
			a_file.put_string (name)
			a_file.put_string ("{")
			a_file.put_new_line
			a_file.flush
			if major /= 0 or else minor /=0 or else build /= 0 or revision /=0  then
				a_file.put_string ("%T.ver ")
				a_file.put_integer (major)
				a_file.put_string (":")
				a_file.put_integer (minor)
				a_file.put_string (":")
				a_file.put_integer (build)
				a_file.put_string (":")
				a_file.put_integer (revision)
				a_file.put_new_line
				a_file.flush
			end

			across 1 |..| 8 as i loop
				if public_key_token[i] /= 0 then
					a_file.put_string ("%T.publickeytoken = (")
					across 1 |..| 8 as j loop
						a_file.put_string (public_key_token[j].to_hex_string)
						a_file.put_string (" ")
					end
					a_file.put_string (")")
					a_file.put_new_line
					a_file.flush
				end
			end
			a_file.put_string ("}")
			a_file.put_new_line
			a_file.flush
			Result := True
		end
end
