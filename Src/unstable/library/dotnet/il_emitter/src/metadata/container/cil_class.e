note
	description: "[
					A class, note that it cannot contain namespaces which is enforced at compile time
			    	note that all classes have to eventually derive from one of the System base classes
			     	but that is handled internally 
			     	Enums derive from this
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_CLASS

inherit

	CIL_DATA_CONTAINER
		rename
			make as make_container
		redefine
			il_src_dump,
			adorn_generics
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_flags: CIL_QUALIFIERS; a_pack: INTEGER; a_size: INTEGER)
		do
			make_container (a_name, a_flags)
			create extends_name.make_empty
			create {ARRAYED_LIST [CIL_TYPE]} generics.make (0)
			create {ARRAYED_LIST [CIL_PROPERTY]} properties.make (0)
			pack := a_pack
			size := a_size
		ensure
			pack_set: pack = a_pack
			size_set: size = a_size
			flags_set: flags = a_flags
			name_set: name = a_name
			extend_from_void: extend_from = Void
			generic_parent_void: generic_parent = Void
			is_external_false: not is_external
			properties_empty: properties.is_empty
			generics_empty: generics.is_empty
		end

feature -- Access

	generic_parent: detachable CIL_CLASS assign set_generic_parent
			-- `generic_parent'

	is_external: BOOLEAN assign set_is_external
			-- `is_external'

	extend_from: detachable CIL_CLASS assign set_extend_from
			-- `extend_from'

	size: INTEGER assign set_size
			-- `size'

	pack: INTEGER assign set_pack
			-- `pack'

	generics: LIST [CIL_TYPE]
			-- The list of generics.

	extends_name: STRING_32

	properties: LIST [CIL_PROPERTY]
			-- The list of properties.

feature -- Element change

	set_generic_parent (a_generic_parent: like generic_parent)
			-- Assign `generic_parent' with `a_generic_parent'.
		do
			generic_parent := a_generic_parent
		ensure
			generic_parent_assigned: generic_parent = a_generic_parent
		end

	set_is_external (an_is_external: like is_external)
			-- Assign `is_external' with `an_is_external'.
		do
			is_external := an_is_external
		ensure
			is_external_assigned: is_external = an_is_external
		end

	set_extend_from (an_extend_from: like extend_from)
			-- Assign `extend_from' with `an_extend_from'.
			--| set the class we are extending from, if this is unset
			--| a system class will be chosen based on whether or not the class is a valuetype
			--| this may be unset when reading in an assembly, in that case ExtendsName
			--| may give the name of a class which is being extended from
		do
			extend_from := an_extend_from
		ensure
			extend_from_assigned: extend_from = an_extend_from
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end

	set_pack (a_pack: like pack)
			-- Assign `pack' with `a_pack'.
		do
			pack := a_pack
		ensure
			pack_assigned: pack = a_pack
		end


feature -- Status Report

	matches_generic (a_generics: detachable LIST [CIL_TYPE]): BOOLEAN
		local
			exit: BOOLEAN
			i: INTEGER
		do
			if attached a_generics then

				if generics.count = a_generics.count then
					from
						i := 1
					until
						exit or else i > generics.count
					loop
						if not generics.at (i).matches (a_generics.at (i)) then
							exit := True
						end
						i := i + 1
					end
					if i > generics.count then
						Result := True
					end
				end

			end
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			il_src_dump_class_header (a_file)
			if attached extend_from as l_extend_form then
				a_file.put_string (" extends ")
				a_file.put_string ({CIL_QUALIFIERS}.name ("", l_extend_form, False))
				a_file.put_string (l_extend_form.adorn_generics (False))
			end
			a_file.put_string (" {")
			if pack > 0 or else size > 0 then
				a_file.put_new_line
				if pack > 0 then
					a_file.put_string (" .pack ")
					a_file.put_integer (pack)
				end
				if size >= 0 then
					a_file.put_string (" .size ")
					a_file.put_integer (size)
				end
			end
			a_file.put_new_line
			Result := Precursor (a_file)
			a_file.put_new_line
			across properties as p loop
				Result := p.il_src_dump (a_file)
			end
			a_file.put_string ("}")
			a_file.put_new_line
			Result := True
		end

	il_src_dump_class_header (a_file: FILE_STREAM)
		do
			a_file.put_string (".class")
			if attached {CIL_CLASS} parent as l_parent then
				a_file.put_string (" nested")
			end
			flags.il_src_dump_before_flags (a_file)
			flags.il_src_dump_after_flags (a_file)
			a_file.put_string (" '")
			a_file.put_string (name)
			a_file.put_string ("'")
			a_file.put_string (adorn_generics (True))
		end

	adorn_generics (a_names: BOOLEAN): STRING_32
		local
			l_count: INTEGER
			l_type: CIL_TYPE
			l_file: FILE_STREAM
			bool: BOOLEAN
		do
			create l_file.make_temp
			create Result.make_empty
			if not generics.is_empty then
				Result.append ("<")
				across generics as it loop
					if a_names and then it.basic_type = {CIL_BASIC_TYPE}.type_var then
						Result.append_character ('A' + (it.var_num // 26))
						Result.append_character ('A' + (it.var_num \\ 26))
					else
						l_type := it
						l_type.show_type := True
						bool := l_type.il_src_dump (l_file)
					end
					if @ it.target_index + 1 /= @ it.last_index then
						l_file.put_string (",")
					else
						l_file.put_string (">")
					end
				end
			end
			Result := l_file.text
			l_file.close
		end

end
