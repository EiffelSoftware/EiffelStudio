-- Internal representation of an external

class EXTERNAL_I 

inherit
	PROCEDURE_I
		export
			{NONE} set_external_name
		redefine
			transfer_to, equiv, update_api,
			melt, generate,
			access, is_external, new_rout_entry, valid_body_id,
			set_renamed_name, external_name, undefinable
		end;
	
feature -- Attributes for externals

	extension: EXTERNAL_EXT_I
			-- Encapsulation of the external extension

feature -- Routines for externals

	is_special: BOOLEAN is
			-- Does the external declaration include a macro or a Dll --JOCE--
		do
			Result := extension /= Void and then
				(extension.is_macro or extension.is_struct or extension.is_dll)
		end;

	has_signature: BOOLEAN is
			-- Does the external declaration include a signature ?
		do
			Result := extension /= Void and then extension.has_signature
		end;

	is_cpp: BOOLEAN is
			-- Is the external declaration a C++ feature ?
		do
			Result := extension /= Void and then extension.is_cpp
		end;

	has_arg_list: BOOLEAN is
			-- Does the signature include arguments ?
		do
			Result := extension /= Void and then extension.has_arg_list
		end;

	has_return_type: BOOLEAN is
			-- Does the signature include a result type ?
		do
			Result := extension /= Void and then extension.has_return_type
		end;

	has_include_list: BOOLEAN is
			-- Does the external declaration include a list of include files ?
		do
			Result := extension /= Void and then extension.has_include_list
		end;

	include_list: ARRAY [STRING] is
			-- Include list
		do
			if extension /= Void then
				Result := extension.header_files
			end
		end

	undefinable: BOOLEAN is
			-- Is an external undefinable?
		do
			Result := System.il_generation and then Precursor {PROCEDURE_I}
		end

	set_extension (e: like extension) is
			-- Assign `e' to `extension'.
		do
			extension := e
		end

feature -- Incrementality

	freezing_equiv (other: FEATURE_I): BOOLEAN is
			-- is `Current' equivalent to `other' as far as freezing is concerned?
		local
			other_ext: EXTERNAL_I
		do
			other_ext ?= other
			if other_ext /= Void then
				Result := same_signature (other) and then
					equal (alias_name, other_ext.alias_name) and then
					encapsulated = other_ext.encapsulated
				if Result then
					Result := equal (extension, other_ext.extension)
				end
			end
		end

	equiv (other: FEATURE_I): BOOLEAN is
		do
			Result := {PROCEDURE_I} Precursor (other) and then freezing_equiv (other)
		end

feature 

	alias_name: STRING is
			-- Alias for the external
		do
			Result := extension.alias_name
		end

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	set_renamed_name (s: STRING) is
			-- Assign `s' to `featurename'.
		do
			if alias_name = Void then
				extension.set_alias_name (feature_name)
			end
			feature_name := s
		end

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'.
		do
			encapsulated := b;
				-- FIXME
				-- The test for freezing is done in `equiv' from FEATURE_TABLE
				-- This is a TEMPORARY solution (3.3 beta bootstrap)!!!!!!

				-- For a macro or a signature in an external declaration
				-- the external is not handled as a `standard' external
				-- and the system does not freeze by itself. We have to
				-- tell it. In fact, this doesn't take the incrementality 
				-- into account: if the macro definition is removed, there is no
				-- need to freeze the system but no way to tell the 
				-- system unless we use the same scheme as for the `standard'
				-- externals.
			--if b then 
				--System.set_freeze (True);
			--end;
		end;

	is_external: BOOLEAN is
			-- Is the feature an external one ?
		do
			Result := True;
		end;

	external_name: STRING is
			-- External name
		do
			Result := alias_name
			if Result = Void then
				Result := feature_name
			end
		end;

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			external_b: EXTERNAL_B;
		do
			!!external_b;
			external_b.init (Current);
			external_b.set_type (access_type);
			external_b.set_external_name (external_name);
			external_b.set_encapsulated (encapsulated);
			external_b.set_extension (extension);
			
			Result := external_b;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			{PROCEDURE_I} Precursor (other);
			other.set_encapsulated (encapsulated);
			other.set_extension (extension);
		end;

	new_rout_entry: EXTERN_ENTRY is
			-- New external unit
		do
			!!Result;
			Result.set_body_index (body_index);
			Result.set_type_a (type.actual_type);
			Result.set_written_in (written_in);
			Result.set_pattern_id (pattern_id);
			Result.set_external_name (external_name);
			Result.set_encapsulated (encapsulated);
			Result.set_feature_id (feature_id)
			Result.set_include_list (include_list)
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_EXTERNAL_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_EXTERNAL_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
				-- Generate feature written in `class_type' in `buffer'.
		require else
			valid_buffer: buffer /= Void;
			written_in_type: class_type.associated_class.class_id = generation_class_id
			not_deferred: not is_deferred;
		local
			byte_code: BYTE_CODE;
		do
			if used then
					-- if the external declaration has a macro or a signature
					-- then encapsulated is True; otherwise do nothing
				if encapsulated then
					generate_header (buffer);
					byte_code := Byte_server.disk_item (body_index);
						-- Generation of C code for an Eiffel feature written in
						-- the associated class of the current type.
					byte_context.set_byte_code (byte_code);
						-- Generation of the C routine
					byte_context.set_current_feature (Current)
					byte_code.analyze;
					byte_code.set_real_body_id (real_body_id);
					byte_code.generate;
					byte_context.clear_all;
				else
					add_in_log (class_type, external_name)
				end;
			end;
		end;

	valid_body_id: BOOLEAN is
				-- if the external is encapsulated then an EXECUTION_UNIT
				-- has been defined instead of an EXT_EXECUTION_UNIT
				-- and real_body_id can be called
		do
			Result := encapsulated;
		end;

	melt (exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
		do
			check
				False
			end
		end

feature {NONE} -- Api
	
	update_api (f: E_ROUTINE) is
			-- Update the attributes of api feature `f'.
		do
			{PROCEDURE_I} Precursor (f)
			f.set_external (True)
		end

end
