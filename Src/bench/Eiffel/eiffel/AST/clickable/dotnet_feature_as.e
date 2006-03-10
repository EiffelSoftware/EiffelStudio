indexing
	description: "Abstract description of an .NET feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	DOTNET_FEATURE_AS

create
	make
	
feature {NONE} -- Initialization
			
	make (a_consumed: CONSUMED_ENTITY) is
			-- Create instance of DOTNET_FEATURE_AS with `a_consumed'.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			consumed_entity := a_consumed
		ensure
			has_dotnet_entity: consumed_entity /= Void
		end

feature -- Formatting

	format (fctxt: DOTNET_FEAT_TEXT_FORMATTER_DECORATOR) is
			-- Format current using `fctxt'.
		require
			fctxt_not_void: fctxt /= Void
		do
			fctxt.prepare_for_feature (consumed_entity)
			fctxt.put_normal_feature
		end

feature {NONE} -- Access
			
	consumed_entity: CONSUMED_ENTITY
			-- Entity on which formatting will be done.

invariant
	has_dotnet_entity: consumed_entity /= Void

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

end -- class DOTNET_FEATURE_AS
