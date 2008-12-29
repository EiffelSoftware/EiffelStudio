note
	description: "[
					Error which reports that a features result type was redefined differently.
					This error occurs in the context of multi constraints.
					Martins 5/7/2007: This is an unoffical error! Not ECMA approved!
					
					Example:
					  class A
					  feature
					    f: ANY
					  end
					  
					  class B
					  inherit A redefine f end
					  feature
					    f: INTEGER
					  end
					  
					  class C
					  inherit A redefine f end
					  feature
					    f: STRING
					  end
					  
					  class NON_MULTI
					  feature
					    a: A
					    example: ANY
					      do
					         Result := a.f.is_equal (3) -- @1
					      end
					      
					  class MULTI [G -> {B, C}]
					  inherit NON_MULTI redefine a end
					  feature
					    a: G
					  end
					  
					Where is the problem?
					In the context of `MULTI' the feature `example' has an ambiguous call @1.
					This is because f occurs redefined in B and C and, assuming that the signature of
					`is_equal' is `like Current' this would yield to a CAT call in case an actual formal derivation
					would not select the version of from B but the one from C (which is STRING, not INTEGER).
					Even though one could check all possibilities to find out whether there is a problem or not, we
					decided to throw an error: VTMC4

				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VTMC4

inherit
	VTMC
		redefine
			build_explain,
			subcode
		end

create
	default_create

feature -- Properties

	subcode: INTEGER_32 = 4

	feature_info: LIST [TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A [TYPE_A]]]

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		local
			l_class_type: CL_TYPE_A
			l_feature: FEATURE_I
		do
			from
				feature_info.start
			until
				feature_info.after
			loop
				l_class_type ?= feature_info.item.cl_type.type
				l_feature := feature_info.item.feature_i
				a_text_formatter.add_sectioned_feature_name (l_feature.e_feature)
				a_Text_formatter.add (" written in ")
				a_text_formatter.add_class (l_class_type.associated_class.original_class)
				a_Text_formatter.add_new_line
				feature_info.forth
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_info (a_feature_info: like feature_info)
			-- Set `feature_info' to `a_feature_info'
		require
			a_feature_info_not_void: a_feature_info /= Void
		do
			feature_info := a_feature_info
		ensure
			feature_info_set: a_feature_info = feature_info
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class VTMC4

