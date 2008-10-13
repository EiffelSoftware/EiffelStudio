indexing
	description: "Informations on creation type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class CREATE_INFO

inherit
	ANY

	SHARED_BYTE_CONTEXT

	BYTE_CONST
		export
			{NONE} all
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

	COMPILER_EXPORTER

feature -- C code generation

	analyze is
			-- Analyze creation type: look for Dtype(Current) usage.
		deferred
		end

	generate is
			-- Generate creation type
		require
			context_valid: context.context_class_type.type /= Void
		local
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer
			buffer.put_string ("RTLNSMART(")
			generate_type_id (buffer, context.final_mode, 0)
			buffer.put_character (')')
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL) is
			-- Generate creation type id.
		require
			buffer_not_void: buffer /= Void
			context_valid: context.context_class_type.type /= Void
		deferred
		end

feature -- IL code generation

	generate_il is
			-- Generate byte code for creation type evaluation
		deferred
		end

	generate_il_type is
			-- Generate byte code to load creation type.
		deferred
		end

	created_in (other: CLASS_TYPE): TYPE_A is
			-- Resulting type of Current as if it was used to create object in `other'
		require
			other_not_void: other /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for creation type evaluation
		require
			ba_not_void: ba /= Void
			context_valid: context.context_class_type.type /= Void
		deferred
		end

feature -- Generic conformance

	is_explicit: BOOLEAN is
			-- Is type fixed at compile time?
		do
			Result := False
		end

	generate_start (buffer: GENERATION_BUFFER) is
			-- Generate new block if necessary.
		require
			buffer_not_void: buffer /= Void
		do
			if is_generic then
				buffer.generate_block_open
			end
		end

	generate_end (buffer: GENERATION_BUFFER) is
			-- Close new block if necessary.
		require
			buffer_not_void: buffer /= Void
		do
			if is_generic then
				buffer.generate_block_close
			end
		end

	generate_gen_type_conversion (a_level: NATURAL) is
			-- Generate the conversion of a type array into an id.
		local
			gen_type : GEN_TYPE_A
		do
			gen_type ?= type_to_create

			if gen_type /= Void then
				context.generate_gen_type_conversion (gen_type, a_level)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode: BOOLEAN) is
			-- Additional info for creation of generic
			-- types with anchored parameters.
		require
			valid: buffer /= Void
			context_valid: context.context_class_type.type /= Void
		do
			-- Do nothing
		end

	make_type_byte_code (ba: BYTE_ARRAY) is
			-- Additional info for creation of generic
			-- types with anchored parameters.
		require
			context_valid: context.context_class_type.type /= Void
		do
		end

	generate_cid_array (buffer: GENERATION_BUFFER;
						final_mode: BOOLEAN; idx_cnt: COUNTER) is
			-- Generate mode dependent sequence of type id's
			-- separated by commas. 'idx_cnt' holds the
			-- index in the array for this entry.
		require
			valid_file: buffer /= Void
			valid_counter: idx_cnt /= Void
			context_valid: context.context_class_type.type /= Void
		do
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL) is
			-- Generate mode dependent initialization of
			-- cid array. 'idx_cnt' holds the index in the
			-- array for this entry.
		require
			valid_file: buffer /= Void
			valid_counter: idx_cnt /= Void
		do
		end

	type_to_create: CL_TYPE_A is
			-- Type of this info.
		deferred
		end

	is_generic: BOOLEAN is
			-- Is generated type generic?
		local
			gen_type: GEN_TYPE_A
		do
			gen_type ?= type_to_create
			Result := (gen_type /= Void)
		end

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

end -- class CREATE_INFO
