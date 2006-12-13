indexing
	description: "Temprary class for interface names used in framework."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FRAMEWORK_CONSTANTS

inherit
	SHARED_LOCALE

feature -- Names

	b_cancel: STRING_GENERAL is do Result := locale.translate ("Cancel") end
	b_ok: STRING_GENERAL is do Result := locale.translate ("OK") end
	b_yes: STRING_GENERAL is do Result := locale.translate ("Yes") end
	b_no: STRING_GENERAL is do Result := locale.translate ("No") end

	t_confirmation: STRING_GENERAL is do Result := locale.translate ("Confimation") end
	t_warning: STRING_GENERAL is do Result := locale.translate ("Warning") end
	t_question: STRING_GENERAL is do Result := locale.translate ("Question") end

	lb_chart: STRING_GENERAL is		do Result := locale.translate("Chart") end
	lb_relations: STRING_GENERAL is		do Result := locale.translate("Relations")	end
	lb_text: STRING_GENERAL is		do Result := locale.translate("Text")	end
	lb_Flat: STRING_GENERAL is					do Result := locale.translate("flat view")	end
	lb_flat_contracts:  STRING_GENERAL is		do Result := locale.translate("Flat contracts")	end
	lb_Flatshort: STRING_GENERAL is				do Result := locale.translate("interface view")	end
	lb_contract: STRING_GENERAL is		do Result := locale.translate("Contract")	end

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
