note
	description: "[
				   A property, note we are only supporting classic properties here, not any
			     * extensions that are allowed in the image file format
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_PROPERTY

inherit

	REFACTORING_HELPER

create
	make,
	make_with_lib

feature {NONE} -- Intialization

	make
		do
			create name.make_empty
			flags := Special_name
			instance := True
		ensure
			name_empty: name.is_empty
			parent_void: parent = Void
			type_void: type = Void
			setter_void: setter = Void
			getter_void: getter = Void
			flags_set: flags = special_name
			instance_set: instance = True
		end

	make_with_lib (a_lib: PE_LIB; a_name: STRING_32; a_type: CIL_TYPE; a_indices: LIST [CIL_TYPE]; has_setter: BOOLEAN; a_parent: detachable CIL_DATA_CONTAINER)
		do
			name := a_name
			type := a_type
			flags := special_name
			instance := True
			parent := a_parent
			create_functions (a_lib, a_indices, has_setter)
		ensure
			name_set: name = a_name
			type_set: type = a_type
			flags_set: flags = special_name
			instance_set: instance = True
			parent_set: parent = a_parent
		end

feature -- Access

	parent: detachable CIL_DATA_CONTAINER
			-- The parent container (always a class).
			-- Add an invariant.

	instance: BOOLEAN
			-- It is an instance member or an static property.

	name: STRING_32
			-- the name.

	type: detachable CIL_TYPE
			-- the type.

	getter: detachable CIL_METHOD
			-- the getter

	setter: detachable CIL_METHOD
			-- the setter.

	flags: INTEGER

feature -- Enums

		-- TODO check if it's ok to
		-- create a once class.

	Special_name: INTEGER = 0x200

	RT_special_name: INTEGER = 0x400

	Has_default: INTEGER = 0x1000

feature -- Element Change

	set_name (a_name: STRING_32)
			-- Set `name` with `a_name`.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_instance (a_val: BOOLEAN)
			-- Set `instance` with `a_val`.
			--| choose whether it is an instance member or static property.
		do
			instance := a_val
			if attached getter as l_getter then
				l_getter.set_instance (a_val)
			end
			if attached setter as l_setter then
				l_setter.set_instance (a_val)
			end
		ensure
			instance_set: instance = a_val
		end

	set_type (a_type: like type)
			-- Set `type` with `a_type`.
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	call_get (a_lib: PE_LIB; a_code: CIL_CODE_CONTAINER)
			-- Call the getter, leaving property on stack
			-- If you had other arguments you should push them before the call.
		do
			if attached getter as l_getter then
				a_code.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_call, {CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (l_getter.prototype))))
			end
		end

	call_set (a_lib: PE_LIB; a_code: CIL_CODE_CONTAINER)
			-- Call the setter
			-- If you had other arguments you should push them before the call
			-- then push the value you want to set
		do
			if attached setter as l_setter then
				a_code.add_instruction (create {CIL_INSTRUCTION}.make ({CIL_INSTRUCTION_OPCODES}.i_call, {CIL_OPERAND_FACTORY}.complex_operand (create {CIL_METHOD_NAME}.make (l_setter.prototype))))
			end
		end

	set_getter (a_getter: like getter)
			-- Set `getter` with `a_getter`.
		do
			getter := a_getter
		ensure
			getter_set: getter = a_getter
		end

	set_setter (a_setter: like setter)
			-- Set `setter` with `a_setter`.
		do
			setter := a_setter
		ensure
			setter_set: setter = a_setter
		end

	set_container (a_parent: CIL_DATA_CONTAINER; a_add: BOOLEAN)
			-- Set the parent container
			--| always a class.
		require
			is_class: attached {CIL_CLASS} a_parent
		local
			l_parent: like parent
		do
			l_parent := a_parent
			if a_add then
				if attached getter as l_getter then
					l_parent.add (l_getter)
					l_getter.prototype.set_container (a_parent)
				end
				if attached setter as l_setter then
					l_parent.add (l_setter)
					l_setter.prototype.set_container (a_parent)
				end
			end
			parent := l_parent
		end

feature {NONE} -- Implementation

	create_functions (a_lib: PE_LIB; a_indices: LIST [CIL_TYPE]; has_setter: BOOLEAN)
		local
			l_found: BOOLEAN
			l_exit: BOOLEAN
			l_prototype: CIL_METHOD_SIGNATURE
			l_getter_name: STRING_32
			l_setter_name: STRING_32
			l_count: INTEGER
			l_stream: STRING_32
		do
			l_getter_name := {STRING_32}"get_" + name
			if attached parent as l_parent then
				across l_parent.methods as m until l_exit loop
					if attached {CIL_METHOD} m as l_method and then l_method.prototype.name.same_string (l_getter_name) then
						l_found := True
						l_exit := True
						getter := l_method
					end
				end
			end
			if getter = Void then
				create l_prototype.make (l_getter_name, {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, parent)
				create getter.make (l_prototype,
					create {CIL_QUALIFIERS}.make_with_flags
						({CIL_QUALIFIERS_ENUM}.public | if instance then {CIL_QUALIFIERS_ENUM}.instance else {CIL_QUALIFIERS_ENUM}.static end),
					False)
			end
			if has_setter then
				fixme ("Refactor setter/getter code")
				l_setter_name := {STRING_32}"set_" + name
				if attached parent as l_parent then
					l_exit := False
					across l_parent.methods as m until l_exit loop
						if attached {CIL_METHOD} m as l_method and then l_method.prototype.name.same_string (l_setter_name) then
							l_found := True
							l_exit := True
							setter := l_method
						end
					end
				end
				if setter = Void then
					create l_prototype.make (l_setter_name, {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed, parent)
					create setter.make (l_prototype,
						create {CIL_QUALIFIERS}.make_with_flags
							({CIL_QUALIFIERS_ENUM}.public | if instance then {CIL_QUALIFIERS_ENUM}.instance else {CIL_QUALIFIERS_ENUM}.static end),
						False)
				end
			end

			if not l_found then
				l_count := 1

				across a_indices as i loop
					create l_stream.make_from_string ("P")
					l_stream.append ("P")
					l_stream.append_integer (l_count)
					if attached getter as l_getter then
						l_getter.prototype.add_parameter (create {CIL_PARAM}.make_with_index (l_stream, Void, @ i.cursor_index - 1))
					end
					if attached setter as l_setter then
						l_setter.prototype.add_parameter (create {CIL_PARAM}.make_with_index (l_stream, Void, @ i.cursor_index - 1))
					end
					l_count := l_count + 1
				end
				if attached getter as l_getter then
					l_getter.prototype.set_return_type (type)
				end
				if attached setter as l_setter then
					l_setter.prototype.add_parameter (create {CIL_PARAM}.make ("Value", type))
					l_setter.prototype.set_return_type (create {CIL_TYPE}.make_with_pointer_level ({CIL_BASIC_TYPE}.void_, 0))
				end
			end

		end

feature -- Output

	il_src_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			a_stream.put_string (".property ")
			if flags & special_name /= 0 then
				a_stream.put_string ("specialname ")
			end
			if instance then
				a_stream.put_string ("instance ")
			end
			if attached type as l_type then
				Result := l_type.il_src_dump (a_stream)
			end
			a_stream.put_string (" ")
			a_stream.put_string (name)
			a_stream.put_string ("() {")
			a_stream.put_new_line
			a_stream.flush
			if attached getter as l_getter then
				a_stream.put_string (".get")
				l_getter.prototype.il_signature_dump (a_stream)
				a_stream.put_new_line
			end
			if attached setter as l_setter then
				a_stream.put_string (".set")
				l_setter.prototype.il_signature_dump (a_stream)
				a_stream.put_new_line
			end
			a_stream.put_string ("}")

			Result := True
		end

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		local
			l_property_index: NATURAL_32
			l_name_index: NATURAL_32
			l_sig: ARRAY [NATURAL_8]
			l_sz:  CELL [NATURAL_32]
			l_property_signature: NATURAL_32
			l_table: PE_TABLE_ENTRY_BASE
			l_semantics: PE_SEMANTICS
			l_dis: NATURAL_32
		do
			if attached {PE_WRITER} a_stream.pe_writer as l_writer then
					-- TODO chec if the index it's ok or we need to add 1.
				l_property_index := l_writer.next_table_index ({PE_TABLES}.tproperty)
				l_name_index := l_writer.hash_string (name)
				create l_sz.put (0)
				l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.property_sig (Current, l_sz)
				l_property_signature := l_writer.hash_blob (l_sig, l_sz.item)

				create {PE_PROPERTY_TABLE_ENTRY} l_table.make_with_data (flags.to_natural_16, l_name_index, l_property_signature)
				l_dis := l_writer.add_table_entry (l_table)

				create l_semantics.make_with_tag_and_index ({PE_SEMANTICS}.property, l_property_index)

				-- FIXME : Coverity complains that the following 'new' statements leak memory, however, I think
			    -- the design is that the related constructors have side effects and the whole point of the new is to invoke those
			    -- however, this is an awkard design that is hard to maintain and should probably be reworked.

			    create {PE_METHOD_SEMANTICS_TABLE_ENTRY} l_table.make_with_data ({PE_METHOD_SEMANTICS_TABLE_ENTRY}.getter.to_natural_16, if attached getter as l_getter  then l_getter.prototype.pe_index else {NATURAL_32} 0 end, l_semantics)
				l_dis := l_writer.add_table_entry (l_table)
				if attached setter as l_setter then
					create {PE_METHOD_SEMANTICS_TABLE_ENTRY} l_table.make_with_data ({PE_METHOD_SEMANTICS_TABLE_ENTRY}.setter.to_natural_16, l_setter.prototype.pe_index, l_semantics)
					l_dis := l_writer.add_table_entry (l_table)
				end
			end
			Result := True
		end

end
