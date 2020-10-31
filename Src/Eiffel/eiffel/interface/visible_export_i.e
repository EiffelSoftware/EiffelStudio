note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class VISIBLE_EXPORT_I

inherit

	VISIBLE_I
		redefine
			is_visible, mark_visible, has_visible,
			generate_cecil_table
		end
	SHARED_SERVER
	SHARED_CECIL
	COMPILER_EXPORTER

feature

	is_visible (feat: FEATURE_I; class_id: INTEGER): BOOLEAN
			-- Is feature name `feat_name' visible in context
			-- of class `class_id'?
		do
			Result :=
				feat.export_status.is_all or else
					-- If it is a creation routine, we can export
					-- it, so that we match the Eiffel way to create
					-- an object.
				attached system.class_of_id (class_id).creators as cs and then
				cs.has (feat.feature_name_id)
		end

	has_visible: BOOLEAN = True
			-- Has the current object some visible features?

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE)
			-- Mark visible features from `feat_table'.
		local
			a_feature: FEATURE_I
			class_id: INTEGER
		do
			from
				class_id := feat_table.feat_tbl_id
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration
				if is_visible (a_feature, class_id) then
					remover.register_monomorphic (a_feature, class_id)
				end
				feat_table.forth
			end
		end

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
			-- Prepare hash table
		local
			a_feature: FEATURE_I
			a_class: CLASS_C
			class_id: INTEGER
			nb: INTEGER
		do
			a_class := feat_table.associated_class
			class_id := a_class.class_id
			cecil_routine_table.wipe_out

			from
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature, class_id)
				then
					nb := nb + 1
				end
				feat_table.forth
			end
				-- Insertion in the cecil table of the effective features
			from
				cecil_routine_table.init (nb.max (1))
				a_class.set_visible_table_size (cecil_routine_table.capacity)
				feat_table.start
			until
				feat_table.after
			loop
				a_feature := feat_table.item_for_iteration;
				if
					not (a_feature.is_deferred or else a_feature.is_attribute)
					and then is_visible (a_feature, class_id)
				then
					cecil_routine_table.put (a_feature, real_name (a_feature, class_id))
				end
				feat_table.forth;
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
