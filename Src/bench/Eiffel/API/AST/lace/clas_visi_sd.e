indexing
	description: "Description of a visible class in Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CLAS_VISI_SD

inherit

	AST_LACE
		redefine
			adapt
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (cn: like class_name; vn: like visible_name;
		cr: like creation_restriction; er: like export_restriction;
		r: like renamings) is
			-- Create a new CLAS_VISI AST node.
		require
			cn_not_void: cn /= Void
		do
			class_name := cn
			cn.to_upper
			visible_name := vn
			if vn /= Void then
				vn.to_upper
			end
			creation_restriction := cr
			export_restriction := er
			renamings := r
		ensure
			class_name_set: class_name = cn
			visible_name_set: visible_name = vn
			creation_restriction_set: creation_restriction = cr
			export_restriction_set: export_restriction = er
			renamings_set: renamings = r
		end

feature -- Properties

	class_name: ID_SD
			-- Eiffel class name of visible class
			-- Never Void

	visible_name: ID_SD
			-- Exported name
			-- Can be Void

	creation_restriction: LACE_LIST [ID_SD]
			-- Can be Void

	export_restriction: LACE_LIST [ID_SD]
			-- Can be Void

	renamings: LACE_LIST [TWO_NAME_SD]
			-- Can be Void

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result.initialize (class_name.duplicate, duplicate_ast (visible_name),
				duplicate_ast (creation_restriction), duplicate_ast (export_restriction),
				duplicate_ast (renamings))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then class_name.same_as (other.class_name)
					and then same_ast (visible_name, other.visible_name)
					and then same_ast (creation_restriction, other.creation_restriction)
					and then same_ast (export_restriction, other.export_restriction)
					and then same_ast (renamings, other.renamings)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			class_name.save (st)
			if visible_name /= Void then
				st.put_string (" as ")
				visible_name.save (st)
			end
			st.indent
			if creation_restriction /= Void then
				st.put_new_line
				st.put_string ("create")
				st.put_new_line
				st.indent
				creation_restriction.save_with_interval_separator (st, ", ")
				st.exdent
			end
			if export_restriction /= Void then
				st.put_new_line
				st.put_string ("export")
				st.put_new_line
				st.indent
				export_restriction.save_with_interval_separator (st, ", ")
				st.exdent
			end
			if renamings /= Void then
				st.put_new_line
				st.put_string ("rename")
				st.put_new_line
				st.indent
				renamings.save_with_interval_separator (st, ", ")
				st.exdent
			end
			st.put_new_line
			st.put_string ("end")
			st.exdent
		end

feature {COMPILER_EXPORTER}

	external_name: STRING is
			-- External name for the visible class
		do
			if visible_name = Void then
				Result := class_name;
			else
				Result := visible_name;
			end;
		ensure
			external_name_not_void: Result /= Void
			external_name_in_upper: Result.as_upper.is_equal (Result)
		end;

	adapt is
			-- Adapt external visibility of class
		require else
			class_name_exists: class_name /= Void;
		local
			cluster: CLUSTER_I;
			a_class: CLASS_I;
			vd25: VD25;
			vd26: VD26;
		do
			cluster := context.current_cluster;
			a_class := cluster.classes.item (class_name);
			if a_class = Void then
				create vd25;
				vd25.set_class_name (class_name);
				vd25.set_cluster (cluster);
				Error_handler.insert_error (vd25);
			else
					-- First tset if there is no ambiguity for the 
					-- effective class name used for the external
					-- environment
				if Universe.is_ambiguous_name (external_name) then
					create vd26;
					vd26.set_cluster (cluster);
					vd26.set_class_name (external_name);
					Error_handler.insert_error (vd26);
				end;
					
				a_class.set_visible_level (visible_level);
				a_class.set_visible_name (visible_name);
			end;
		end;
		
	visible_level: VISIBLE_I is
			-- Visible level controler associated to current option
		local
			visi1: VISIBLE_EXPORT_I;
			visi2: VISIBLE_SELEC_I;
			table: SEARCH_TABLE [STRING];
			rename_table: HASH_TABLE [STRING, STRING];
			cuple: TWO_NAME_SD;
		do
			if export_restriction = Void then
				create visi1;
				Result := visi1;
			else
				create visi2;
				from
					create table.make (export_restriction.count);
					export_restriction.start;
				until
					export_restriction.after
				loop
					table.put (export_restriction.item);
					export_restriction.forth;
				end;
				visi2.set_visible_features (table);
				Result := visi2;
			end;
			if renamings /= Void then
				from
					renamings.start;
					create rename_table.make (renamings.count);
				until
					renamings.after
				loop
					cuple := renamings.item;
					rename_table.put (cuple.new_name, cuple.old_name);
					renamings.forth;
				end;
				Result.set_renamings (rename_table);
			end;
		ensure
			Result_exists: Result /= Void;
		end;

invariant
	class_name_not_void: class_name /= Void
	class_name_in_upper: class_name.as_upper.is_equal (class_name)
	visible_name_in_upper: visible_name /= Void implies visible_name.as_upper.is_equal (visible_name)
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CLAS_VISI_SD



