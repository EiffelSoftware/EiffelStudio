note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class VISIBLE_SELEC_I

inherit

	VISIBLE_I
		redefine
			trace, generate_cecil_table, has_visible, mark_visible,
			is_visible
		end

	SHARED_SERVER

	SHARED_CECIL

	COMPILER_EXPORTER

feature

	visible_features: SEARCH_TABLE [STRING];
			-- Visible features

	set_visible_features (t: like visible_features)
			-- Assign `t' to `visible_features'.
		do
			visible_features := t;
		end;

	is_visible (feat: FEATURE_I; class_id: INTEGER): BOOLEAN
			-- Is feature name `feat_name' visible in context
			-- of class `class_id'?
		do
			Result := visible_features.has (feat.feature_name);
		end;

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE)
			-- Mark visible features from `feat_table'.
		local
			a_feature: FEATURE_I;
		do
			from
				visible_features.start
			until
				visible_features.after
			loop
				a_feature := feat_table.item (visible_features.item_for_iteration);

				if a_feature /= Void then
					remover.record (a_feature, a_feature.written_class)
				end;

				visible_features.forth;
			end;
		end;

	has_visible: BOOLEAN = True
			-- Has the current object some visible features ?

	generate_cecil_table (a_class: CLASS_C; generated_wrappers: SEARCH_TABLE [STRING])
			-- Generate cecil table
		local
			buffer: GENERATION_BUFFER
		do
			buffer := generation_buffer
			prepare_table (a_class.feature_table)
				-- Generation
			cecil_routine_table.generate (buffer, a_class, generated_wrappers)
		end

	prepare_table (feat_table: FEATURE_TABLE)
			-- Prepate cecil table.
		local
			a_feature: FEATURE_I;
			a_class: CLASS_C;
			class_id: INTEGER
		do
			cecil_routine_table.wipe_out;

			a_class := feat_table.associated_class;
			class_id := a_class.class_id

				-- Insertion in the cecil table of the effective features
			from
				cecil_routine_table.init (visible_features.count)
				a_class.set_visible_table_size (cecil_routine_table.capacity)
				visible_features.start
			until
				visible_features.after
			loop
				a_feature := feat_table.item (visible_features.item_for_iteration);

				if a_feature = Void then
					-- FIXME: Illegal feature specified
				else
					if not (a_feature.is_deferred or else a_feature.is_attribute) then
						cecil_routine_table.put (a_feature, real_name (a_feature, class_id));
					end;
				end
				visible_features.forth;
			end;
		end;

	trace
			-- Debug purpose
		do
			Precursor {VISIBLE_I}
			io.error.put_string (" for ");
			from
				visible_features.start;
			until
				visible_features.after
			loop
				io.error.put_string (visible_features.item_for_iteration);
				io.error.put_character (' ');
				visible_features.forth;
			end;
		end;

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
