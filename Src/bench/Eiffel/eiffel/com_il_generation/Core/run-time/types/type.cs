/*
indexing
	description: "Abstract representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt"
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

*/
	
using System;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public abstract class RT_TYPE {

/*
feature -- Conformance
*/
	public virtual bool conform_to (RT_TYPE other)
		// Does `Current' conform to `other'?
	{
		return false;
	}

/*
feature -- Status Report
*/
	public virtual bool is_basic ()
		// Does `Current' represent a basic type?
	{
		return false;
	}

	public virtual bool is_tuple ()
		// Does `Current' represent a TUPLE type?
	{
		return false;
	}

	public virtual bool is_none ()
		// Does `Current' represent a NONE type?
	{
		return false;
	}

	public virtual bool has_formal ()
		// Does `Current' have a formal generic parameter?
	{
		return false;
	}

	public virtual String class_name ()
		// Name of object's generating class who has Current as an EIFFEL_DERIVATION
		// (base class of the type of which it is a direct instance)
	{
		return String.Empty;
	}

	public virtual String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return String.Empty;
	}
	
	public virtual RT_TYPE evaluated_type (RT_GENERIC_TYPE context_type)
		// Evaluate Current in context of `context_type'.
	{
		return this;
	}
}

}
