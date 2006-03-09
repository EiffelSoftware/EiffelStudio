indexing
	description: "Predefined custom attributes blobls."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_CUSTOM_ATTRIBUTES

feature -- Predefined custom attributes

	not_cls_compliant_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not CLS compliant attribute
		once
			create Result.make
			Result.put_boolean (False)
			Result.put_integer_16 (0)
		ensure
			not_cls_compliant_ca_not_void: Result /= Void
		end

	cls_compliant_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for CLS compliant attribute
		once
			create Result.make
			Result.put_boolean (True)
			Result.put_integer_16 (0)
		ensure
			cls_compliant_ca_not_void: Result /= Void
		end

	not_com_visible_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not COM Visible attribute.
		once
			create Result.make
			Result.put_boolean (False)
			Result.put_integer_16 (0)
		ensure
			not_com_visible_ca_not_void: Result /= Void
		end

	empty_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for custom attributes without argument.
		once
			create Result.make
			Result.put_integer_16 (0)
		ensure
			empty_ca_not_void: Result /= Void
		end

	enabled_debuggable_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not CLS compliant attribute
		once
			create Result.make
			Result.put_boolean (True)
			Result.put_boolean (True)
			Result.put_integer_16 (0)
		ensure
			not_cls_compliant_ca_not_void: Result /= Void
		end

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

end -- class IL_PREDEFINED_CUSTOM_ATTRIBUTES
