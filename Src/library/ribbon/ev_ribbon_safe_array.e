note
	description: "[
					This C structure holds a safe array and its attributes.
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_SAFE_ARRAY

create
	make

feature {NONE} -- Initialization

	make (a_list: ARRAYED_LIST [EV_SIMPLE_PROPERTY_SET])
			-- Creation method
		local
			l_vt_unknown: NATURAL_16
			l_ppv_data: POINTER
			l_managed_data: MANAGED_POINTER
			l_result: NATURAL_16
		do
			l_vt_unknown := 13
			psa := c_safe_array_create_vector (l_vt_unknown, 0, a_list.count.as_natural_32)
			l_result := c_safe_array_access_data (psa, $l_ppv_data)
			check l_ppv_data /= default_pointer end
			create l_managed_data.share_from_pointer (l_ppv_data, a_list.count * c_size_of_pointer)
			from
				a_list.start
			until
				a_list.after
			loop

				l_managed_data.put_pointer (a_list.item.item.item, (a_list.index - 1) * c_size_of_pointer)

				a_list.forth
			end
			l_result := c_safe_array_unaccess_data (psa)
		end

feature -- Query

	psa: POINTER
			-- Safe array pointer

feature {NONE} -- Externals

	c_size_of_pointer: INTEGER
			--
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				return sizeof (EIF_POINTER);
			}
			]"
		end

	c_safe_array_create_vector (a_var_type: NATURAL_16; a_lower_bound: INTEGER_64; a_elements: NATURAL_32): POINTER
			-- Creates a one-dimensional array. A safe array created with SafeArrayCreateVector is a fixed size, so the constant FADF_FIXEDSIZE is always set.
		external
			"C inline use <OleAuto.h>"
		alias
			"[
			{
				return (EIF_POINTER)SafeArrayCreateVector ((VARTYPE)$a_var_type,
															(long)$a_lower_bound,
															(unsigned int)$a_elements);
			}
			]"
		end

	c_safe_array_access_data (a_psa: POINTER; a_ppv_data: TYPED_POINTER [POINTER]): NATURAL_16
			-- Increments the lock count of an array, and retrieves a pointer to the array data.
		external
			"C inline use <OleAuto.h>"
		alias
			"[
			{
				return (EIF_NATURAL_16) SafeArrayAccessData ((SAFEARRAY *)$a_psa,
															(void HUGEP **)$a_ppv_data);
			}
			]"
		end

	c_safe_array_unaccess_data (a_psa: POINTER): NATURAL_16
			-- Decrements the lock count of an array, and invalidates the pointer retrieved by SafeArrayAccessData.
		external
			"C inline use <OleAuto.h>"
		alias
			"[
			{
				return (EIF_NATURAL_16) SafeArrayUnaccessData ((SAFEARRAY *)$a_psa);
			}
			]"
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
