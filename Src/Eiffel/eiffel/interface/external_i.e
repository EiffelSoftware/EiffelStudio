indexing
	description: "Representation of an external procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_I

inherit
	PROCEDURE_I
		redefine
			transfer_to, equiv, update_api,
			generate, duplicate, extension,
			access_for_feature, is_external,
			set_renamed_name_id, external_name_id,
			init_arg
		end

create
	make

feature -- Initialization

	init_arg (argument_as: EIFFEL_LIST [TYPE_DEC_AS]; a_context_class: CLASS_C) is
			-- Initialization of arguments.
		local
			l_inline_ext: INLINE_EXTENSION_I
		do
			Precursor {PROCEDURE_I} (argument_as, a_context_class)
			if has_arguments and extension.is_inline then
					-- In order to replace arguments specified in external `alias' part of
					-- inline clause, we need to initialize `extension' with argument
					-- names.
				l_inline_ext ?= extension
				check
					l_inline_ext_not_void: l_inline_ext /= Void
				end

				l_inline_ext.set_argument_names (arguments.argument_names)
			end
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current external feature.
		do
			Result := Precursor {PROCEDURE_I}
			Result.set_extension (extension.twin)
		end

feature -- Attributes for externals

	extension: EXTERNAL_EXT_I
			-- Encapsulation of the external extension

feature -- Routines for externals

	make, set_extension (e: like extension) is
			-- Assign `e' to `extension'.
		require
			e_not_void: e /= Void
		do
			extension := e
		ensure
			extension_set: extension = e
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
					equal (external_alias_name, other_ext.external_alias_name) and then
					encapsulated = other_ext.encapsulated
				if Result then
					Result := equal (extension, other_ext.extension)
				end
			end
		end

	equiv (other: FEATURE_I): BOOLEAN is
		do
			Result := Precursor {PROCEDURE_I} (other) and then freezing_equiv (other)
		end

feature

	external_alias_name_id: INTEGER is
			-- Alias for the external
		do
			Result := extension.alias_name_id
		end

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	set_renamed_name_id (id: INTEGER; alias_id: INTEGER) is
			-- Assign `id' to `feature_name_id'.
		do
			if external_alias_name_id = 0 then
				extension.set_alias_name_id (feature_name_id)
			end
			Precursor {PROCEDURE_I} (id, alias_id)
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

	external_alias_name: STRING is
			-- External alias name if any.
		do
			Result := Names_heap.item (external_alias_name_id)
		end

	external_name_id: INTEGER is
			-- External_name ID
		do
			Result := external_alias_name_id
			if Result = 0 then
				Result := feature_name_id
			end
		end

	access_for_feature (access_type: TYPE_I; static_type: CL_TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			external_b: EXTERNAL_B;
		do
			create external_b
			external_b.init (Current)
			if static_type /= Void then
				external_b.set_static_class_type (static_type)
			end
			external_b.set_type (access_type)
			external_b.set_external_name_id (external_name_id)
			external_b.set_encapsulated (encapsulated)
			external_b.set_extension (extension)

			Result := external_b
		end

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			Precursor {PROCEDURE_I} (other);
			other.set_encapsulated (encapsulated);
			other.set_extension (extension);
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_EXTERNAL_I
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_EXTERNAL_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
				-- Generate feature written in `class_type' in `buffer'.
		local
			byte_code: BYTE_CODE
		do
			if used then
				generate_header (buffer);
				byte_code := Byte_server.disk_item (body_index)
				check
					byte_code_not_void: byte_code /= Void
				end
					-- Generation of C code for an Eiffel feature written in
					-- the associated class of the current type.
				byte_context.set_byte_code (byte_code)
					-- Generation of the C routine
				byte_context.set_current_feature (Current)
				byte_code.analyze
				byte_code.set_real_body_id (real_body_id (class_type))
				byte_code.generate
				byte_context.clear_feature_data
			else
				system.removed_log_file.add (class_type, feature_name)
			end
		end

feature {NONE} -- Api

	update_api (f: E_ROUTINE) is
			-- Update the attributes of api feature `f'.
		do
			Precursor {PROCEDURE_I} (f)
			f.set_external (True)
		end

invariant
	extension_not_void: extension /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
