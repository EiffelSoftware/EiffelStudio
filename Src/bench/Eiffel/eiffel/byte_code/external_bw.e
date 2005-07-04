indexing
	description: "Enlarged node for external feature call in workbench mode."
	date: "$Date$"
	revision: "$Revision: "

class
	EXTERNAL_BW 

inherit
	EXTERNAL_BL
		redefine
			check_dt_current, generate_access_on_type,
			need_invariant, set_need_invariant
		end

create
	make

feature -- Initialization

	make is
		do
			need_invariant := True
		end
	
feature -- Access

	need_invariant: BOOLEAN
			-- Does the call need an invariant check ?

feature -- Settings

	set_need_invariant (b: BOOLEAN) is
			-- Assign `b' to `need_invariant'.
		do
			need_invariant := b
		end

feature -- Checking

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I
			type_i: TYPE_I
			cond: BOOLEAN
			access: ACCESS_B
			void_register: REGISTER
		do
			if not is_static_call then
				type_i := context_type
				class_type ?= type_i
				cond := not (type_i.is_basic or else class_type = Void)
				if reg.is_current and cond then
					context.add_dt_current
				end
				if not reg.is_predefined and cond then
						-- BEWARE!! The function call is polymorphic hence we'll
						-- need to evaluate `reg' twice: once to get its dynamic
						-- type and once as a parameter for Current. Hence we
						-- must make sure it is not held in a No_register--RAM.
				 	access ?= reg;	  -- Cannot fail
					if access.register = No_register then
						access.set_register (void_register)
						access.get_register
					end
				end
			end
		end

feature -- Code generation

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate external call in a `typ' context
		local
			is_nested: BOOLEAN
			r_id: INTEGER
			rout_info: ROUT_INFO
			buf: GENERATION_BUFFER
			l_typ: CL_TYPE_I
		do
			is_nested := not is_first
			buf := buffer

			if is_static_call then
				l_typ ?= real_type (static_class_type)
				check
					l_typ_not_void: l_typ /= Void
				end
			else
				l_typ := typ
			end

			buf.put_character ('(')
			real_type (type).c_type.generate_function_cast (buf, argument_types)
			if	
				Compilation_modes.is_precompiling or else
				l_typ.base_class.is_precompiled
			then
				if is_nested and need_invariant then
					buf.put_string ("RTVPF(")
				else
					buf.put_string ("RTWPF(")
				end
				r_id := l_typ.base_class.feature_table.item_id (feature_name_id).rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				buf.put_class_id (rout_info.origin)
				buf.put_string (gc_comma)
				buf.put_integer (rout_info.offset)
			else
				if is_nested and need_invariant then
					buf.put_string ("RTVF(")
				else
					buf.put_string ("RTWF(")
				end
				buf.put_static_type_id (l_typ.associated_class_type.static_type_id)
				buf.put_string (gc_comma)
				buf.put_integer (real_feature_id)
			end
			buf.put_string (gc_comma)
			if not is_nested then
				if is_static_call then
						-- Use dynamic type of `static_class_type' instead 
						-- of dynamic type of Current.
					buf.put_string ("RTUD(");
					buf.put_static_type_id (l_typ.associated_class_type.static_type_id)
					buf.put_character (')');
				else
					context.generate_current_dtype
				end
			elseif need_invariant then
				buf.put_string_literal (feature_name)
				buf.put_string (gc_comma)
				reg.print_register
			else
				buf.put_string (gc_upper_dtype_lparan)
				reg.print_register
				buf.put_character (')')
			end
			buf.put_string ("))")
		end

end -- class EXTERNAL_BW
