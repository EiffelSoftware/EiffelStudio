/*
indexing
	description: "Handles loading of custom attributes in a version dependent manner."
	date: "$Date: 2006-02-22 18:29:02 -0800 (Wed, 22 Feb 2006) $"
	revision: "$Revision: 57134 $"
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
using System.Reflection;
using System.Collections;
#if CS_20
using System.Collections.Generic;
#endif

namespace EiffelSoftware.Runtime
{

	public class RT_CUSTOM_ATTRIBUTE_DATA
	{
		public static object[] get_eiffel_custom_attributes(Type a_type, ICustomAttributeProvider a_provider)
		{
			if (a_type == null)
			{
				throw new ArgumentNullException("a_type");
			}
			if (a_provider == null)
			{
				throw new ArgumentNullException("a_provider");
			}
#if CS_20
			Assembly a = null;
			MemberInfo mi = null;
			Type t = null;
			ParameterInfo pi = null;
			IList<CustomAttributeData> data = null;

			// Attempt to get implementation object from a provider
			pi = a_provider as ParameterInfo;
			if (pi == null)
			{
				t = a_provider as Type;
				if (t == null)
				{
					a = a_provider as Assembly;
					if (a == null)
					{
						mi = a_provider as MemberInfo;
						if (mi == null)
						{
							throw new ArgumentException("The provider is not valid.", "a_provider");
						}
						else
						{
							data = CustomAttributeData.GetCustomAttributes(mi);
						}
					}
					else
					{
						data = CustomAttributeData.GetCustomAttributes(a);
					}
				}
				else
				{
					data = CustomAttributeData.GetCustomAttributes(t);
				}
			}
			else
			{
				data = CustomAttributeData.GetCustomAttributes(pi);
			}

			ArrayList list = new ArrayList(1);
			if (data != null)
			{
				// Attribute retrieved
				foreach (CustomAttributeData cad in data)
				{
					ConstructorInfo ci = cad.Constructor;
					if (ci.DeclaringType == a_type)
					{
						// Create ctor arguments
						int i = 0;
						object[] args = new object[cad.ConstructorArguments.Count];
						foreach (CustomAttributeTypedArgument cata in cad.ConstructorArguments)
						{
							args[i++] = cata.Value;
						}
						// Create attribute object instance and add.
						object o = ci.Invoke(args);
						list.Add(o);
					}
				}
			}
			return list.ToArray();
#else
			return a_provider.GetCustomAttributes(a_type, False);
#endif
		}

	}// class RT_CUSTOM_ATTRIBUTE_DATA

}// namespace EiffelSoftware.Runtime
