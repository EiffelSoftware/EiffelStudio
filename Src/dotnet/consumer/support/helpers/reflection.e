indexing
	description: "Helper functions using .NET reflection"
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTION

feature -- Status Report

	is_consumed_type (t: TYPE): BOOLEAN is
			-- Is `t' a public CLS compliant type?
		local
			parent_name: SYSTEM_STRING
			parent_type: TYPE
		do
			if is_cls_compliant (t) then
				Result := t.is_public
				if not Result then
					if t.is_nested_public or t.is_nested_family or t.is_nested_fam_or_assem then
						parent_name := t.full_name
						parent_name := parent_name.substring_integer_integer (0, parent_name.index_of_character ('+'))
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
			Result := (m.is_public or m.is_family or m.is_family_or_assembly) and then is_cls_compliant (m)

			if Result then
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
							io.put_string ("%NNon CLS compliant parameters or return type in CLS compliant member.%N")
							io.put_string ("%Assembly:  ")
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
			Result := is_cls_compliant (m)
			if Result then
					-- check that return type is CLS compliant
				l_params := m.get_parameters
				from
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
						Result := is_cls_compliant (l_mi.return_type)
					end					
				end
			end
		end

	is_consumed_field (f: FIELD_INFO): BOOLEAN is
			-- Is `f' a public/family CLS compliant field?
		require
			f_not_void: f /= Void
		do
			Result := (f.is_public or f.is_family or f.is_family_or_assembly) and then
						is_cls_compliant (f)
						
			if Result then
					-- check that field is fully cls compliant
				Result := is_consumed_field_cls_compliant (f)
				
				if Result then
					Result := f.is_literal implies is_valid_literal_field (f)
				end
				debug ("log_illegal_non_cls_compliancy") 
					if not Result then
							-- Non-CLS compliant return type in CLS compliant field
						io.put_string ("%NNon CLS compliant return type for CLS compliant field.%N")
						io.put_string ("%Assembly:  ")
						io.put_string (f.declaring_type.assembly.full_name)
						io.put_string ("%N%TType: ")
						io.put_string (f.declaring_type.full_name)
						io.put_string ("%N%TField: ")
						io.put_string (f.name)
						io.new_line
					end
				end
			end
		end
		
	is_valid_literal_field (f: FIELD_INFO): BOOLEAN is
			-- Is `f' a valid literal field?
		require
			f_not_void: f /= Void
			f_is_literal: f.is_literal
		do
			Result := not f.declaring_type.is_enum implies f.get_value (Void) /= Void
		end
		
	is_consumed_field_cls_compliant (f: FIELD_INFO): BOOLEAN is
			-- Is `f' a CLS compliant field?
		require
			f_not_void: f /= Void
			f_is_cls_compliant: is_cls_compliant (f)
		do
			Result := is_cls_compliant (f) implies is_cls_compliant_type (f.field_type)
		end
		
	is_cls_compliant_type (a_type: TYPE): BOOLEAN is
			-- is `a_type' CLS compliant
		require
			a_type_not_void: a_type /= Void
		do
			if a_type.has_element_type then
				Result := is_cls_compliant_type (a_type.get_element_type)
			else
				Result := is_cls_compliant (a_type)
			end	
		end

	is_cls_compliant (member: MEMBER_INFO): BOOLEAN is
			-- 	Is `member' CLS compliant?
		local
			ca: CLS_COMPLIANT_ATTRIBUTE
		do
			ca ?= feature {ATTRIBUTE_}.get_custom_attribute_member_info_type (member, cls_compliant_attribute_type)
			Result := ca = Void or else ca.is_compliant
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

	cls_compliant_attribute_type: TYPE is
			-- typeof (System.CLSCompliantAttribute)
		once
			Result := feature {TYPE}.get_type_string ("System.CLSCompliantAttribute")
		end

end -- class REFLECTION
