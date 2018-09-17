note
	description: "Error for a declaration of a once feature as a creation procedure"

class
	VGCC9

inherit

	VGCC
		redefine
			subcode, build_explain
		end

create
	make_invalid_context

feature {NONE} -- Implementation

	make_invalid_context (a_feature: FEATURE_I; a_context_class, a_written_class: CLASS_C)
			-- New instance of VRVA(2) error.
		require
			a_feature_attached: a_feature /= Void
			a_context_class_attached: a_context_class /= Void
			a_written_class_attached: a_written_class /= Void
		do
			set_class (a_context_class)
			set_written_class (a_written_class)
			set_feature (a_feature)
		end


feature -- Properties

	subcode: INTEGER = 9

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Construct `a_text_formatter' with error.
		do
			a_text_formatter.add ("Once creation procedure: ")
			a_text_formatter.add (e_feature.name_32)
			a_text_formatter.add (" is inherited from: ")
			a_text_formatter.add (written_class.class_signature)
			a_text_formatter.add ("but must be immediate (non-inherited).")
			a_text_formatter.add_new_line
		end


note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end -- class VAPE
