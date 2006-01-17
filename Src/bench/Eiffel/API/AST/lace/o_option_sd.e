indexing
	description: "Optional option"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	O_OPTION_SD

inherit
	D_OPTION_SD
		rename
			initialize as d_initialize
		redefine
			adapt, duplicate, save, same_as, is_optional
		end;

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like option; v: like value; t: like target_list) is
			-- Create a new O_OPTION AST node.
		require
			o_not_void: o /= Void
		do
			option := o
			value := v
			target_list := t
		ensure
			option_set: option = o
			value_set: value = v
			target_list_set: target_list = t
		end

feature -- Properties

	target_list: LACE_LIST [ID_SD];
			-- List of class targets

feature -- Status report

	is_optional: BOOLEAN is True
			-- Current is an instance of `O_OPTION_SD'.

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result.initialize (option.duplicate,
				duplicate_ast (value), duplicate_ast (target_list))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then option.same_as (other.option)
			 		and then same_ast (value, other.value)
					and then same_ast (target_list, other.target_list)
		end


feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			Precursor {D_OPTION_SD} (st)
			st.put_character (':')
			st.put_character (' ')
			if target_list /= Void then
				target_list.save_with_interval_separator (st, ", ")
			end
		end

feature {COMPILER_EXPORTER}

	adapt is
			-- Option adaptation
		local
			vd39: VD39
		do
				-- Check class names valididty
			if 
				(target_list /= Void)
			then
				check_target_list;
			else
				create vd39;
				vd39.set_cluster (context.current_cluster);
				vd39.set_option_name (option.option_name);
				Error_handler.insert_error (vd39)
			end;

				-- Check sum error
			Error_handler.checksum;

				-- Option adaptation
			option.adapt (value, context.current_cluster.classes, target_list);
		end;

	check_target_list is
			-- Check target list validity
		local
			vd16: VD16;
			cluster: CLUSTER_I;
			classes: HASH_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				cluster := context.current_cluster;
				classes := cluster.classes;
				target_list.start;
			until
				target_list.after
			loop
					-- Class names are stored in upper, thus the conversion to upper cases
					-- for the lookup.
				class_name := target_list.item.as_upper

				if not classes.has (class_name) then
					create vd16;
					vd16.set_class_name (class_name);
					vd16.set_cluster (cluster);
					vd16.set_node (Current);
					Error_handler.insert_error (vd16);
				end;

				target_list.forth;
			end;
		end;

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

end -- class O_OPTION_SD
