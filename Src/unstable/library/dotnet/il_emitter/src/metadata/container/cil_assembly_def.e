note
	description: "[
					    Base class for assembly definitions
			    		this holds the main assembly ( as a non-external assembly)
			    		or can hold an external assembly
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_ASSEMBLY_DEF

inherit

	CIL_DATA_CONTAINER
		rename
			make as make_data_container
		redefine
			in_assembly_ref,
			get_assembly
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_external: BOOLEAN; a_byte: detachable ARRAY [NATURAL_8])
		require
			valid_length_iff_atached_byte: attached a_byte implies a_byte.count = 8
		do
			make_data_container (a_name, create {CIL_QUALIFIERS}.make)

			if attached a_byte then
				create public_key_token.make_from_array (a_byte)
			else
				create public_key_token.make_filled (0, 1, 8)
			end

			is_external := a_external
			create namespace_cache.make (0)
			create class_cache.make (0)
			create snk_file.make_empty
			create custom_attributes.make
		ensure
			snk_file_set: snk_file.is_empty
			external_set: is_external = a_external
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

	public_key_token: ARRAY [NATURAL_8]

	snk_file: STRING_32
			-- name of strong name key file
			-- by default "".

	namespace_cache: STRING_TABLE [CIL_NAMESPACE]

	class_cache: STRING_TABLE [CIL_CLASS]

	is_loaded: BOOLEAN

	custom_attributes: CIL_CUSTOM_ATTRIBUTE_CONTAINER

	get_assembly, assembly_def: CIL_ASSEMBLY_DEF
			-- Return current assembly
		do
			Result := Current
		end

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

	set_version (a_major, a_minor, a_build, a_revision: INTEGER)
			-- Set assembly definition version
			-- `major` with `a_major`
			-- `minor` with `a_minor`
			-- `build` with `a_build`
			-- `revision` with `a_revision`
		do
			major := a_major
			minor := a_minor
			build := a_build
			revision := a_revision
		ensure
			version_set: major = a_major and then
				minor = a_minor and then
				build = a_build and then
				revision = a_revision
		end

	set_snk_file (a_name: STRING_32)
			-- Set `snk_file` with `a_name`.
		do
			snk_file := a_name
		ensure
			snk_file_set: snk_file = a_name
		end

	set_loaded
			-- Set `is_loaded` to True.
		do
			is_loaded := True
		ensure
			loaded_set: is_loaded
		end

	insert_namespaces_table (a_lib: PE_LIB; a_namespaces: STRING_TABLE [CIL_NAMESPACE]; a_name: STRING_32): detachable CIL_NAMESPACE
			--| Correspond to Namespace *InsertNameSpaces(PELib &lib, std::map<std::string, Namespace *> &nameSpaces, const std::string& name);
		local
			l_parent, l_rv: CIL_NAMESPACE
			n: INTEGER
			l_name: STRING_32
			l_end: STRING_32
			l_dc: CIL_DATA_CONTAINER
			l_tmp: CIL_NAMESPACE
		do
			l_name := a_name
			if attached a_namespaces.item (a_name) as l_cnp then
				Result := l_cnp
			else
				n := l_name.index_of ('.', l_name.lower)
				create l_end.make_from_string (l_name)
				if n /= 0 then
					l_parent := insert_namespaces_table (a_lib, a_namespaces, l_name.substring (l_name.lower, n))
					l_end := l_name.substring (n+1, l_name.count)
				end
				if attached l_parent then
					l_dc := l_parent.find_container_string (l_end, Void)
					if attached {CIL_NAMESPACE} l_dc as l_item then
						l_parent := l_item
						l_rv := l_parent
					end
				else
					l_dc := find_container_string (l_end, Void)
					if attached {CIL_NAMESPACE} l_dc as l_item then
						l_parent := l_item
						l_rv := l_parent
					end
				end
				if attached l_rv then
					a_namespaces.force (l_rv, l_name)
				else
					create l_tmp.make (l_end)
					a_namespaces.force (l_tmp, l_name)
					if attached l_parent then
						l_parent.add (l_tmp)
					end
				end
				Result := a_namespaces.item (name)
			end
		end

	insert_namespaces (a_lib: PE_LIB; a_namespace: CELL [detachable CIL_NAMESPACE]; a_name: STRING_32): detachable CIL_NAMESPACE
			--| Correspond to Namespace *InsertNameSpaces(PELib &lib, Namespace *nameSpace, std::string nameSpaceName);
		local
			l_in: STRING_32
			n: INTEGER
			l_namespace_void: CELL [detachable CIL_NAMESPACE]
			l_namespace: CIL_NAMESPACE
			l_name: STRING_32
			l_rv: CIL_NAMESPACE
			l_dc: CIL_DATA_CONTAINER
		do
			l_name := a_name
			if attached namespace_cache.item (l_name) as l_elem then
				Result := l_elem
			else
				l_in := l_name
				n := l_name.index_of ('0', l_name.lower)
				if n /= 0 then
					create l_namespace_void.put (Void)
					l_namespace := insert_namespaces (a_lib, l_namespace_void, a_name.substring (l_name.lower, n))
					a_namespace.put (l_namespace)
					l_name := l_name.substring (n + 1, l_name.count)
				end
				if attached l_namespace then
					l_dc := l_namespace.find_container_string (l_name, Void)
					if attached {CIL_NAMESPACE} l_dc as l_nsp then
						l_namespace := l_nsp
						l_rv := l_namespace
					end
				else
					l_dc := find_container_string (l_name, Void)
					if attached {CIL_NAMESPACE} l_dc as l_nsp then
						l_namespace := l_nsp
						l_rv := l_namespace
					end
				end
				if l_rv = Void then
					create l_rv.make (l_name)
					if attached l_namespace then
						l_namespace.add (l_rv)
					else
						add (l_rv)
					end
					l_namespace := l_rv
					namespace_cache.force (l_namespace, l_in)
				end
				Result := l_namespace
			end
		end

	insert_classes (a_lib: PE_LIB; a_namespace: detachable CIL_NAMESPACE; a_cls: CELL [detachable CIL_CLASS] a_name: STRING_32): CIL_CLASS
		local
			n: INTEGER
			l_cls: CIL_CLASS
			l_name: STRING_32
			l_rv: CIL_CLASS
			l_res, l_dc: CIL_DATA_CONTAINER
			l_cell: CELL [detachable CIL_CLASS]

		do
			l_name := a_name
			n := l_name.last_index_of ('.', 1)
			if n /= 0 then
				create l_cell.put (Void)
				l_cls := insert_classes (a_lib, a_namespace, l_cell, l_name.substring (1, n))
				a_cls.put (l_cls)
				l_name := l_name.substring (n + 1, l_name.count)
			end
			if attached l_cls then
				l_res := l_cls.find_container_string (l_name, Void)
				if attached {CIL_CLASS} l_res as l_class then
					l_rv := l_class
				end
			else
				l_dc := if attached a_namespace as l_nsp then l_nsp.find_container_string (l_name, Void) else Void end
				if attached {CIL_CLASS} l_dc or attached {CIL_ENUM} l_dc then
					if attached {CIL_CLASS} l_dc as l_class then
						l_rv := l_class
					end
				end
			end
			if attached l_rv then
				if attached a_namespace then
					a_namespace.add (l_rv)
				end
			else
				create l_rv.make (l_name, create {CIL_QUALIFIERS}.make, -1, -1)
				if attached l_cls then
					l_cls.add (l_rv)
				end
			end
			Result := l_rv
		end

feature -- Status Report

	lookup_class (a_lib: PE_LIB; a_namespace: STRING_32; a_name: STRING_32): CIL_CLASS
			--  lookup or create a class.
		local
			l_in: STRING_32
			l_namespace: CIL_NAMESPACE
			l_rv: CIL_CLASS
			l_class_void: CELL [detachable CIL_CLASS]
			l_namespace_void: CELL [detachable CIL_NAMESPACE]
		do
			l_in := a_namespace + "::" + a_name
			if attached class_cache.item (l_in) as l_elem then
				Result := l_elem
			else
				create l_namespace_void.put (Void)
				l_namespace := insert_namespaces (a_lib, l_namespace_void, a_namespace)
				create l_class_void.put (Void)
				l_rv := insert_classes (a_lib, l_namespace, l_class_void, a_name)
				class_cache.force (l_rv, l_in)
				Result := l_rv
			end
		end

	in_assembly_ref: BOOLEAN
		do
			Result := is_external
		end

feature -- Output

	pe_header_dump (a_stream: FILE_STREAM): BOOLEAN
		local
			l_name_index: NATURAL_64
			l_table: PE_TABLE_ENTRY_BASE
			l_blob_index: NATURAL_64
			l_exit: BOOLEAN
		do
			if attached {PE_WRITER} a_stream.pe_writer as l_writer then
				l_name_index := l_writer.hash_string (name)
				if is_external then
					across 1 |..| 8 as ic until l_exit loop
						if public_key_token [ic] /= 0 then
							l_blob_index := l_writer.hash_blob (public_key_token, 8)
							l_exit := True
						end
					end
					create {PE_ASSEMBLY_REF_TABLE_ENTRY} l_table.make_with_data ({PE_ASSEMBLY_FLAGS}.PA_none, major.to_natural_16, minor.to_natural_16, build.to_natural_16, revision.to_natural_16, l_name_index, l_blob_index)
				else
					create {PE_ASSEMBLY_DEF_TABLE_ENTRY} l_table.make_with_data ({PE_ASSEMBLY_FLAGS}.PA_none, major.to_natural_16, minor.to_natural_16, build.to_natural_16, revision.to_natural_16, l_name_index)
				end
				pe_index := l_writer.add_table_entry (l_table)
				Result := True
			end
		end

	il_header_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string (".assembly ")
			if is_external then
				a_file.put_string ("extern ")
			end
			a_file.put_string ("'")
			a_file.put_string (name)
			a_file.put_string ("'")
			a_file.put_string (" {")
			a_file.put_new_line
			a_file.flush
			if major /= 0 or else minor /= 0 or else build /= 0 or revision /= 0 then
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
				if public_key_token [i] /= 0 then
					a_file.put_string ("%T.publickeytoken = (")
					across 1 |..| 8 as j loop
						a_file.put_string (public_key_token [j].to_hex_string)
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
