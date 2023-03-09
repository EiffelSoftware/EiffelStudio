note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_NAME_EXTRACTOR

inherit
	SHARED_API_ROUTINES

feature -- Access

	feature_name (a_feature: FEATURE_AS): STRING_32
			-- Return name of `a_feature' (i.e. "feature_name")
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := a_feature.feature_name.name_32.twin
		ensure
			Result_not_void: Result /= Void
		end

	feature_names (a_feature: FEATURE_AS): LIST [STRING_32]
			-- Return all names of `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
		do
			l_feature_names := a_feature.feature_names
			create {ARRAYED_LIST [STRING_32]} Result.make (l_feature_names.count)
			if l_feature_names.count = 1 then
				Result.extend (a_feature.feature_name.name_32.twin)
			else
				from
					l_feature_names.start
					l_feature_names.forth
				until
					l_feature_names.after
				loop
					Result.extend (l_feature_names.item.visual_name_32)
					l_feature_names.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	full_signature_compiled (a_feature: E_FEATURE): STRING_32
			-- Parameter of `a_feature'. (i.e. (foo: LIST [BAR], bar: BAR): INTEGER
		require
			a_feature_not_void: a_feature /= Void
		local
			l_st: YANK_STRING_WINDOW
		do
			create l_st.make
			a_feature.append_just_signature (l_st)
			Result := l_st.stored_output
		ensure
			Result_not_void: Result /= Void
		end

	full_name_compiled (a_feature: E_FEATURE): STRING_32
			-- Full name of `a_feature' (i.e. "feature_name (foo: FOO): LIST [FOO, BAR [FOO2]]")
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := feature_name (a_feature.ast) + full_signature_compiled (a_feature)
		ensure
			Result_not_void: Result /= Void
		end

	full_name (a_feature: FEATURE_AS): STRING_32
			-- Full name of `a_feature' (i.e. "feature_name: LIST [FOO, BAR [FOO2]]")
			-- without parameters.
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := feature_name (a_feature) + full_signature (a_feature)
			if a_feature.body.content /= Void and then a_feature.is_deferred then
				Result.append ("*")
			end
		ensure
			Result_not_void: Result /= Void
		end

	full_signature (a_feature: FEATURE_AS): STRING
			-- Full signature of `a_feature' (i.e. : INTEGER [FOO [BAR], INTEGER])
		local
			l_body: BODY_AS
		do
			Result := ": "
			l_body := a_feature.body
			if l_body /= Void then
				Result.append (suppliers_name (l_body.type))
				Result.replace_substring_all ("[ ", "[")
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	suppliers_name_compiled (a_type: TYPE_A): STRING
			-- Try to extract as good as possible all supplier names
			-- from `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			l_generics: ARRAYED_LIST [TYPE_A]
			i, nb: INTEGER
		do
			if attached {FORMAL_A} a_type as formal then
				Result := formal.dump
			else
				Result := a_type.base_class.name_in_upper.twin
			end

			l_generics := a_type.generics

			if l_generics /= Void then
				Result.append (" [")
				from
					i := 1
					nb := l_generics.count
				until
					i > nb
				loop
					Result.append (suppliers_name_compiled (l_generics.i_th (i)))
					i := i + 1
				end
				Result.append ("]")
			end
		ensure
			Result_not_void: Result /= Void
		end

	suppliers_name (a_type: TYPE_AS): STRING
			-- Try to extract as good as possible all supplier names
			-- from `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			g: TYPE_LIST_AS
		do
			Result := ""
			if attached {CLASS_TYPE_AS} a_type as ct then
				Result.append (supplier_name (class_i_by_name (ct.class_name.name_8)))
				g := ct.generics
				if g /= Void then
					Result.append (" [ ")
					from
						g.start
					until
						g.after
					loop
						if not g.isfirst then
							Result.append (", ")
						end
						Result.append (suppliers_name (g.item))
						g.forth
					end
					Result.append ("]")
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	supplier_name (sup: CLASS_I): STRING
			-- Name of `sup'.
		do
			if sup /= Void then
				Result := sup.name.twin
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class FEATURE_NAME_EXTRACTOR
