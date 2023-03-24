note
	description: "Metadata Emitter"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_EMIT

inherit

	REFACTORING_HELPER
		export {NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_dispenser: CIL_DISPENSER)
		do
			dispenser := a_dispenser
			create pe_lib.make
		end

feature {NONE} -- Access

	dispenser: CIL_DISPENSER

	pe_lib: PE_LIB

feature -- Definition: access

	define_type_ref_mscorlib (a_type_name: STRING_32): CIL_CLASS
			-- Retrieve the class for `type_name' located in `mscorlib'.
		local
			l_find: TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
			l_class: CIL_CLASS
		do
			l_find := pe_lib.find (a_type_name, Void, pe_lib.mscorlib_assembly)
			if l_find.type /= {CIL_FIND_TYPE}.s_class then
				create l_class.make (a_type_name, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				pe_lib.mscorlib_assembly.add (l_class)
			elseif attached {CIL_CLASS} l_find.resource as l_r then
				l_class := l_r
			else
				create l_class.make (a_type_name, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				pe_lib.mscorlib_assembly.add (l_class)
			end
			Result := l_class
		end

	define_type_ref (a_type_name: STRING_32; a_assembly: CIL_ASSEMBLY_DEF): CIL_CLASS
			-- Retrieve the class for `type_name' located in assembly `a_assembly'.
		local
			l_find: TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
			l_class: CIL_CLASS
		do
			l_find := pe_lib.find (a_type_name, Void, a_assembly)
			if l_find.type /= {CIL_FIND_TYPE}.s_class then
				create l_class.make (a_type_name, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				a_assembly.add (l_class)
			elseif attached {CIL_CLASS} l_find.resource as l_r then
				l_class := l_r
			else
				create l_class.make (a_type_name, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				a_assembly.add (l_class)
			end
			Result := l_class
		end

	define_assembly_ref (a_name: STRING_32; a_assembly_info: MD_ASSEMBLY_INFO; a_public_key: ARRAY [NATURAL_8])
		require
			valid_public_key_size: a_public_key.count = 8
		local
			l_assembly: CIL_ASSEMBLY_DEF
		do
			l_assembly := pe_lib.add_external_assembly (a_name, a_public_key)
		end

	define_mscorlib_assembly_ref (a_assembly_info: MD_ASSEMBLY_INFO; a_public_key: ARRAY [NATURAL_8])
			-- Define the mscorlib assembly
		require
			valid_public_key_size: a_public_key.count = 8
		do
			if attached {CIL_ASSEMBLY_DEF} pe_lib.mscorlib_assembly as l_mscorlib then
				l_mscorlib.set_major (a_assembly_info.major_version)
				l_mscorlib.set_minor (a_assembly_info.minor_version)
				l_mscorlib.set_revision (a_assembly_info.revision_number)
				l_mscorlib.set_build (a_assembly_info.revision_number)
				l_mscorlib.public_key_token := a_public_key
			end
		end

	define_method_ref (a_name: STRING_32; a_class: CIL_CLASS; a_signature: CIL_METHOD_SIGNATURE)
			-- Create reference to method in class `a_class'.
		do
			a_signature.set_container (a_class)
			a_signature.set_name (a_name)
		end

feature -- Definition: creation

	define_assembly (a_name: STRING_32; a_assembly_info: MD_ASSEMBLY_INFO; a_snk_file: STRING_32): CIL_ASSEMBLY_DEF
			-- Define a new assembly.
		local
			l_assembly_ref: CIL_ASSEMBLY_DEF
		do
			create l_assembly_ref.make (a_name, False, create {ARRAY [NATURAL_8]}.make_filled (0, 1, 8))
			pe_lib.assembly_refs.force (l_assembly_ref)
			pe_lib.working_assembly.set_snk_file (a_snk_file)
			pe_lib.working_assembly.set_major (a_assembly_info.major)
			pe_lib.working_assembly.set_minor (a_assembly_info.minor)
			pe_lib.working_assembly.set_revision (a_assembly_info.revision)
			pe_lib.working_assembly.set_build (a_assembly_info.build)
			Result := pe_lib.working_assembly
		end

	define_type (a_name: STRING_32; a_flags: CIL_QUALIFIERS; a_object: CIL_CLASS): CIL_CLASS
			-- Create a new type `a_name'
		do
			create Result.make (a_name, a_flags, -1, -1)
			Result.set_extend_from (a_object)
			pe_lib.working_assembly.add (Result)
		end

	define_method (a_signature: CIL_METHOD_SIGNATURE; a_flags: CIL_QUALIFIERS; a_type: CIL_CLASS; a_entry: BOOLEAN): CIL_METHOD
			-- Create a new method from signature `a_signatre' in type `a_type'.
		do
			create Result.make (a_signature, a_flags, a_entry)
			a_type.add (Result)
			Result.optimize
		end

	define_field (a_name: STRING_32; a_field_type: CIL_TYPE; a_flags: CIL_QUALIFIERS; a_type: CIL_CLASS): CIL_FIELD
			-- Create a new field `a_name' in class `a_type'.
		do
			create Result.make (a_name, a_field_type, a_flags)
			a_type.add (Result)
		end

	define_local_from_basic_type (a_name: STRING_32; a_type: CIL_BASIC_TYPE): CIL_LOCAL
			-- Create a new local varaible `a_name' from a basic type `a_type'.
		do
			create Result.make (a_name, create {CIL_TYPE}.make (a_type))
		end

	define_local_from_container (a_name: STRING_32; a_container: CIL_DATA_CONTAINER): CIL_LOCAL
			-- -- Create a new local varaible `a_name' from a container `a_container'.
		do
			create Result.make (a_name, create {CIL_TYPE}.make_with_container (a_container))
		end

	define_label (a_name: STRING_32): CIL_OPERAND
			-- Create a new label `a_name'
		do
			Result := {CIL_OPERAND_FACTORY}.label_operand (a_name)
		end

feature -- Settings

	set_module_name (a_name: STRING_32)
			-- Set name of current generated module `a_name'.
		do
			debug ("il_emitter")
				to_implement ("Add implementation, MODULE is not supported")
			end
		end

feature -- Save

	dump_output_file (a_file_name: STRING_32; a_mode: CIL_OUTPUT_MODE; a_gui: BOOLEAN)
			-- write an output file, possibilities are a .il file, an EXE or a DLL
			-- the file can also be tagged as either console or win32
		do
			pe_lib.dump_output_file (a_file_name, a_mode, a_gui)
		end

end
