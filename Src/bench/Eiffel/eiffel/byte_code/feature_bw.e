-- Enlarged node for Eiffel feature call in workbench mode

class FEATURE_BW 

inherit

	FEATURE_BL
		redefine
			check_dt_current, generate_access_on_type, is_polymorphic,
			need_invariant, set_need_invariant
		end

creation

	make
	
feature 

	is_polymorphic: BOOLEAN is
			-- Is the feature call polymorphic ?
		do
			Result := True;
		end;

	need_invariant: BOOLEAN;
			-- Does the call need an invariant check ?

	set_need_invariant (b: BOOLEAN) is
			-- Assign `b' to `need_invariant'.
		do
			need_invariant := b
		end;

	make is
		do
			need_invariant := True;
		end;

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I;
			type_i: TYPE_I;
			access: ACCESS_B;
			void_register: REGISTER;
		do
			type_i := context_type;
			class_type ?= type_i;
			if not (type_i.is_basic or else class_type = Void) then
				if reg.is_current then
					context.add_dt_current;
				end;
				if not reg.is_predefined then
						-- BEWARE!! The function call is polymorphic hence we'll
						-- need to evaluate `reg' twice: once to get its dynamic
						-- type and once as a parameter for Current. Hence we
						-- must make sure it is not held in a No_register--RAM.
				 	access ?= reg;	  -- Cannot fail
					if access.register = No_register then
						access.set_register (void_register);
						access.get_register;
					end;
				end
			end;
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate feature call in a `typ' context
		local
			is_nested: BOOLEAN;
			r_id: INTEGER;
			rout_info: ROUT_INFO;
			base_class: CLASS_C;
			buf: GENERATION_BUFFER
			gen_type_i: GEN_TYPE_I
			cl_type_i: CL_TYPE_I
		do
			is_nested := not is_first;
			buf := buffer
			buf.putchar ('(');
			real_type (type).c_type.generate_function_cast (buf, argument_types);
			base_class := typ.base_class;

			if 
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				if is_nested and need_invariant then
					buf.putstring ("RTVPF(");
				else
					buf.putstring ("RTWPF(");
				end;
				r_id := base_class.feature_table.item
					(feature_name).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				buf.generate_class_id (rout_info.origin)
				buf.putstring (gc_comma);
				buf.putint (rout_info.offset);
			else
				if is_nested and need_invariant then
					buf.putstring ("RTVF(");
				else
					buf.putstring ("RTWF(");
				end;
				buf.putint (typ.associated_class_type.static_type_id - 1);
				buf.putstring (gc_comma);
				buf.putint (real_feature_id);
			end;
			buf.putstring (gc_comma);
			if not is_nested then
				if precursor_type /= Void then
						-- Use dynamic type of parent instead 
						-- of dynamic type of Current.
					buf.putstring ("RTUD(");

					gen_type_i ?= context.current_type
					if gen_type_i /= Void then
						cl_type_i := precursor_type.instantiation_in (gen_type_i)
						buf.generate_type_id (cl_type_i.associated_class_type.static_type_id)
					else
						buf.generate_type_id (precursor_type.associated_class_type.static_type_id)
					end
					buf.putchar (')');
				else
					context.generate_current_dtype;
				end
			elseif need_invariant then
				buf.putchar ('"');
				buf.putstring (feature_name);
				buf.putstring ("%", ");
				reg.print_register;
			else
				buf.putstring (gc_upper_dtype_lparan);
				reg.print_register;
				buf.putchar (')');
			end;
			buf.putstring ("))");
		end;

end
