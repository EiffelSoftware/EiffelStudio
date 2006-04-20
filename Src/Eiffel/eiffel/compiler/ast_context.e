indexing
	description: "Context for third pass"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CONTEXT

inherit
	ANY

	SHARED_SERVER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create instance of AST_CONTEXT.	
		do
			create locals.make (10)
			create supplier_ids.make
		end

feature -- Access

	current_class: CLASS_C
			-- Current analyzed class.

	current_class_type: LIKE_CURRENT
			-- Actual type of `current_class'

	current_feature_table: FEATURE_TABLE
			-- Current feature table

	written_class: CLASS_C
			-- Class where the code is originally written.
			-- (Used for checking inherited code in current context.)

	current_feature: FEATURE_I
			-- Current analyzed feature.

	locals: HASH_TABLE [LOCAL_INFO, STRING]
			-- Current local variables of the analyzed feature

	supplier_ids: FEATURE_DEPENDANCE
			-- Supplier units

feature -- Status report

	is_ignoring_export: BOOLEAN
			-- Do we ignore export validity for feature access ?
			-- Useful for expression evaluation

	last_conversion_info: CONVERSION_INFO
			-- Information about last conversion

feature -- Setting

	initialize (a_class: like current_class; a_type: CL_TYPE_A; a_feat_tbl: like current_feature_table) is
			-- Initialize current context for class analyzis.
		require
			a_class_not_void: a_class /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_type_not_void: a_type /= Void
		do
			current_class := a_class
			create current_class_type
			current_class_type.set_actual_type (a_type)
			current_feature_table := a_feat_tbl
			written_class := Void
		ensure
			current_class_set: current_class = a_class
			current_class_type_set: current_class_type.conformance_type = a_type
			current_feature_table_set: current_feature_table = a_feat_tbl
		end

	set_current_feature (f: FEATURE_I) is
			-- Assign `f' to `current_feature'.
		require
			f_not_void: f /= Void
		do
			current_feature := f
		ensure
			current_feature_set: current_feature = f
		end

	set_written_class (c: like written_class) is
			-- Set `written_class' to `c'.
		do
			written_class := c
		ensure
			written_class_set: written_class = c
		end

	set_is_ignoring_export (b: BOOLEAN) is
			-- Assign `b' to `is_ignoring_export'.
		do
			is_ignoring_export := b
		ensure
			is_ignoring_export_set: is_ignoring_export = b
		end

	set_locals (l: like locals) is
			-- Assign `l' to `locals'.
		do
			locals := l;
		end;

	set_last_conversion_info (l: like last_conversion_info) is
			-- Assign `l' to `last_conversion_info'.
		do
			last_conversion_info := l
		ensure
			last_conversion_info_set: last_conversion_info = l
		end

	init_error (e: FEATURE_ERROR) is
			-- Initialize `e'.
		require
			good_argument: not (e = Void)
		do
			e.set_class (current_class)
			e.set_written_class (written_class)
			if current_feature /= Void then
				e.set_feature (current_feature)
			end
		end

	init_byte_code (byte_code: BYTE_CODE) is
			-- Initialiaze `byte_code'.
		require
			current_feature /= Void;
		local
			local_dec: ARRAY [TYPE_I]
			local_info: LOCAL_INFO
			local_count: INTEGER
			argument_count: INTEGER
			i: INTEGER
			arguments: FEAT_ARG
			rout_id: INTEGER
		do
				-- Name
			byte_code.set_feature_name_id (current_feature.feature_name_id)
				-- Feature id
			byte_code.set_body_index (current_feature.body_index)
				-- Result type if any
			byte_code.set_result_type (current_feature.type.type_i)
				-- Routine id
			rout_id := current_feature.rout_id_set.first
			byte_code.set_rout_id (rout_id)
				-- Pattern id
			byte_code.set_pattern_id (current_feature.pattern_id)
				-- Local variable declarations
			local_count := locals.count
			if local_count > 0 then
				from
					locals.start
					create local_dec.make (1, local_count)
				until
					locals.after
				loop
					local_info := locals.item_for_iteration
					local_dec.put (local_info.type.type_i, local_info.position)
					locals.forth
				end
				byte_code.set_locals (local_dec)
			end
				-- Arguments declarations
			argument_count := current_feature.argument_count
			if argument_count > 0 then
				from
					arguments := current_feature.arguments
					i := 1
					create local_dec.make (1, argument_count)
				until
					i > argument_count
				loop
					local_dec.put (arguments.i_th (i).type_i, i)
					i := i + 1
				end
				byte_code.set_arguments (local_dec)
			end
		end

feature -- Managing the type stack

	clear_all is
			-- Clear the structure: to use while changing of analyzed
			-- current_class.
		do
			current_class := Void
			current_class_type := Void
			current_feature_table := Void
			written_class := Void
			clear_feature_context
		end

	clear_feature_context is
			-- Clear `current_feature' context: to use while changing of current
			-- analyzed feature.
		do
			current_feature := Void
			locals.clear_all
			last_conversion_info := Void
			supplier_ids.wipe_out
		end;

invariant
	locals_not_void: locals /= Void

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
