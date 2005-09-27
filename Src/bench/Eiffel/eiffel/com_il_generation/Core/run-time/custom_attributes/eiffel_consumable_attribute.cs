/*
indexing
	description: "Custom attributes to prevent consumer consuming types and/or features."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace EiffelSoftware.Runtime.CA
{

	[AttributeUsage (AttributeTargets.All, AllowMultiple = false, Inherited = true)]
	[Serializable]
	public class EIFFEL_CONSUMABLE_ATTRIBUTE : Attribute
	{
		/*
		feature -- Initialization
		*/
		public EIFFEL_CONSUMABLE_ATTRIBUTE (bool a_consumable)
		{
			m_consumable = a_consumable;
		}

		/*
		feature -- Access
		*/
		public bool consumable
		{
			get
			{
				return m_consumable;
			}
		}

		/*
		feature -- Implementation
		*/
		protected bool m_consumable;
		// Name of class associated to Current.
	}

} // class EIFFEL_NON_CONSUMABLE_ATTRIBUTE