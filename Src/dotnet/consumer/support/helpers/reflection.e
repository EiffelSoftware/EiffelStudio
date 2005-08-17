indexing
	description: "Helper functions using .NET reflection"
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTION

feature -- Status Report

	is_consumed_type (t: SYSTEM_TYPE): BOOLEAN is
			-- Is `t' a public CLS compliant type?
		local
			parent_name: SYSTEM_STRING
			parent_type: SYSTEM_TYPE
		do
			if is_cls_compliant_type (t) then
				Result := t.is_public
				if not Result then
					if t.is_nested_public or t.is_nested_family or t.is_nested_fam_or_assem then
						parent_name := t.full_name
						parent_name := parent_name.substring (0, parent_name.index_of_character ('+'))
						parent_type := t.assembly.get_type_string (parent_name)
						Result := parent_type /= Void and then parent_type.is_public
					end
				end
			end
		end

	is_consumed_method (m: METHOD_BASE): BOOLEAN is
			-- Is `m' a public/family CLS compliant method?
		require
			m_not_void: m /= Void
		local
			l_properties: NATIVE_ARRAY [PROPERTY_INFO]
			l_is_errornous: BOOLEAN
			i: INTEGER
		do			
			if (m.is_public or m.is_family or m.is_family_or_assembly) and then is_cls_compliant (m) then
					-- check that member is fully cls compliant
				Result := is_consumed_method_true_cls_compliant (m)
				debug ("log_illegal_non_cls_compliancy") 
					if not Result then
						l_is_errornous := True
						if m.is_special_name then
								-- check if a matching property is marked CLS compliant
							l_properties := m.declaring_type.get_properties
							from
								i := l_properties.lower
							until
								i > l_properties.upper or not l_is_errornous
							loop
								if (l_properties.item (i).get_get_method /= Void and then l_properties.item (i).get_get_method.equals (m)) 
										or (l_properties.item (i).get_set_method /= Void and then l_properties.item (i).get_set_method.equals (m)) then
									l_is_errornous := is_cls_compliant (l_properties.item (i))
								end
								i := i + 1
							end
						end
						if l_is_errornous then
								-- Non-CLS compliant parameters or return type in CLS compliant method
							io.put_string ("%NNon CLS compliant parameters or return type in CLS compliant member.")
							io.put_string ("%N%TAssembly:  ")
							io.put_string (m.declaring_type.assembly.full_name)
							io.put_string ("%N%TType: ")
							io.put_string (m.declaring_type.full_name)
							io.put_string ("%N%TMethod: ")
							io.put_string (m.name)
							io.new_line							
						end
					end
				end
			end
		end
		
	is_consumed_method_true_cls_compliant (m: METHOD_BASE): BOOLEAN is
			-- Is `m' a CLS compliant method?
		require
			m_not_void: m /= Void
			m_is_cls_compliant: is_cls_compliant (m)
		local
			l_params: NATIVE_ARRAY [PARAMETER_INFO]
			l_mi: METHOD_INFO
			i: INTEGER
		do
				-- check that return type is CLS compliant
			l_params := m.get_parameters
			from
				Result := True
				i := l_params.lower
			until
				i > l_params.upper or not Result
			loop
				Result := is_cls_compliant_type ((l_params @ i).parameter_type)
				i := i + 1
			end
			if Result then
				l_mi ?= m
				if l_mi /= Void and then l_mi.return_type /= Void then
					Result := is_cls_compliant_type (l_mi.return_type)
				end					
			end
			if Result then
				Result := is_cls_compliant_type (m.declaring_type)
			end
		end

	is_consumed_field (f: FIELD_INFO): BOOLEAN is
			-- Is `f' a public/family CLS compliant field?
		require
			f_not_void: f /= Void
		do
			if
				(f.is_public or f.is_family or f.is_family_or_assembly) and then
				is_cls_compliant (f)
			then
					-- check that field is fully cls compliant
				Result := is_cls_compliant_type (f.field_type)
				
				if Result and then f.is_literal then
					Result := is_valid_literal_field (f)
				end
				debug ("log_illegal_non_cls_compliancy") 
					if not Result then
							-- Non-CLS compliant return type in CLS compliant field
						io.put_string ("%NNon CLS compliant return type for CLS compliant field.")
						io.put_string ("%N%TAssembly:  ")
						io.put_string (f.declaring_type.assembly.full_name)
						io.put_string ("%N%TType: ")
						io.put_string (f.declaring_type.full_name)
						io.put_string ("%N%TField: ")
						io.put_string (f.name)
						io.new_line
					end
				end
			end
			if Result then
				Result := is_cls_compliant_type (f.declaring_type)
			end
		end
		
	is_valid_literal_field (f: FIELD_INFO): BOOLEAN is
			-- Is `f' a valid literal field?
		require
			f_not_void: f /= Void
			f_is_literal: f.is_literal
		do
			Result := f.get_value (Void) /= Void
		end
		
	is_cls_compliant_type (a_type: SYSTEM_TYPE): BOOLEAN is
			-- is `a_type' CLS compliant
		require
			a_type_not_void: a_type /= Void
		local
			l_cls: like cls_compliant_status
			l_obj: SYSTEM_OBJECT
		do
			l_cls := cls_compliant_status
			l_obj := l_cls.item (a_type)
			if l_obj /= Void then
				Result ?= l_obj
			else
				if not a_type.is_pointer then
					if a_type.has_element_type then
						Result := is_cls_compliant_type (a_type.get_element_type)
					else
							-- Compliant if is has the custom attribute set to True, or none.
						Result := is_eiffel_compliant (a_type) and not is_cls_generic_type (a_type)
					end
				end
				l_cls.set_item (a_type, Result)
			end
		end

	is_cls_generic_type (a_type: SYSTEM_TYPE): BOOLEAN is
			--
		local
			l_name: SYSTEM_STRING
		do
				-- If `a_type.full_name' is Void, it means it is a formal generic parameter.
				-- We consider this case and the case where the string contains ``'
				-- as generic type.
			l_name := a_type.full_name
			Result := l_name = Void or else l_name.index_of ('`') >= 0
		end
		
	is_cls_compliant (member: MEMBER_INFO): BOOLEAN is
			-- 	Is `member' CLS compliant?
		local
			ca: CLS_COMPLIANT_ATTRIBUTE
		do
			ca ?= feature {SYSTEM_ATTRIBUTE}.get_custom_attribute_member_info_type (member, {CLS_COMPLIANT_ATTRIBUTE})
			Result := ca = Void or else ca.is_compliant
		end
		
	is_eiffel_compliant (type: SYSTEM_TYPE): BOOLEAN is
			-- 	Is `type' and Eiffel compliant type?
		do
			Result := is_cls_compliant (type)
			if not Result then
				Result ?= eiffel_compliant_types.item (type)
			end
		end

	is_public_field (a_field: FIELD_INFO): BOOLEAN is
			-- Is `a_field' public and static?
		do
			Result := a_field.is_public and not a_field.is_literal
		end
		
	is_init_only_field (a_field: FIELD_INFO): BOOLEAN is
			-- Is `a_field' a initonly field?
		do
			Result := a_field.is_init_only
		end

feature {NONE} -- Implementation

	cls_compliant_status: HASHTABLE is
			-- Table where keys are instances of SYSTEM_TYPE and values are their associated
			-- CLS compliant value.
		once
			create Result.make (500)
		ensure
			cls_compliant_status_not_void: Result /= Void
		end
		
	eiffel_compliant_types: HASHTABLE is
			-- Table where keys are instances of SYSTEM
		once
			create Result.make (5)
			Result.add ({SYSTEM_TYPE}.get_type_string ("System.IntPtr"), True)
			Result.add ({SYSTEM_TYPE}.get_type_string ("System.Byte"), True)
			Result.add ({SYSTEM_TYPE}.get_type_string ("System.UInt16"), True)
			Result.add ({SYSTEM_TYPE}.get_type_string ("System.UInt32"), True)
			Result.add ({SYSTEM_TYPE}.get_type_string ("System.UInt64"), True)
		end

end -- class REFLECTION
