note
	description: "Summary description for {DBG_EXPRESSION_EVALUATION_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXPRESSION_EVALUATION_CONTEXT

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make,
	make_from_expression_context

feature {NONE} -- Initialization

	make
		do
		end

	make_from_expression_context (ctx: DBG_EXPRESSION_CONTEXT)
		do
			on_class := ctx.on_class
			on_context := ctx.on_context
			on_object := ctx.on_object

			class_c := ctx.associated_class
			address := ctx.associated_address
		end

feature -- Element change

	set_data (f: like feature_i; c: like class_c; ct: like class_type;
				loctab: like local_table; otl: like object_test_locals;
				a_bp, a_bp_nested: INTEGER)
			-- Set context data related to `f', `c', `ct', `otl', `a_bp' and `a_bp_nested', ..
		local
			l_reset_byte_node: BOOLEAN
			c_c_t: CLASS_TYPE
			c_t_i: CL_TYPE_A
		do
			changed := False
			if c /= Void then
				if
					f /= feature_i
				then
					feature_i := f
					l_reset_byte_node := True
				end
				if class_c /~ c then
					class_c := c
					l_reset_byte_node := True
				end
				if ct /= Void then
					c_c_t := ct
				elseif class_c /= Void then
					c_t_i := class_c.actual_type
					if c_t_i.has_associated_class_type (Void) then
						c_c_t := c_t_i.associated_class_type (Void)
					end
				end
				if class_type /~ c_c_t then
					class_type := c_c_t
					l_reset_byte_node := True
				end
				if class_c = Void and class_type /= Void then
					class_type := Void
					l_reset_byte_node := True
				end

				if loctab /~ local_table then
					local_table := loctab
				end
				if otl /~ object_test_locals then
					object_test_locals := otl
				end
				if breakable_index /= a_bp then
					breakable_index := a_bp
				end
				if bp_nested_index /= a_bp_nested then
					bp_nested_index := a_bp_nested
				end

				if feature_i = Void then
					if not on_object then
						l_reset_byte_node := True
						feature_i := default_context_feature
					end
				end
				changed := l_reset_byte_node
			end
		end

	to_string: STRING
			-- context information as string
			-- for debugging purpose only
		local
			ca: like address
			cc: like class_c
			cct: like class_type
			cf: like feature_i
			r: BOOLEAN
		do
			if not r then
				ca := address
				cc := class_c
				cct := class_type
				cf := feature_i

				create Result.make_from_string ("Context:%N")
				Result.append_string (" address=")
				if ca /= Void then
					Result.append_string (ca.output)
				else
					Result.append_string ("...")
				end
				Result.append_string ("%N")

				Result.append_string (" class=")
				if cc /= Void then
					Result.append_string (cc.name_in_upper)
				else
					Result.append_string ("...")
				end
				Result.append_string ("%N")

				Result.append_string (" type=")
				if cct /= Void then
					Result.append_string (cct.associated_class.name_in_upper)
				else
					Result.append_string ("...")
				end
				Result.append_string ("%N")

				Result.append_string (" feature=")
				if cf /= Void then
					Result.append_string (cf.feature_name)
				else
					Result.append_string ("...")
				end
				Result.append_string ("%N")
			end
		rescue
			r := True
			retry
		end

feature -- Status report

	changed: BOOLEAN
			-- Context changed

	is_valid: BOOLEAN
		do
			Result := class_c /= Void and class_type = Void and feature_i = Void
		end

	on_class: BOOLEAN
			-- Is the expression relative to a class ?

	on_object: BOOLEAN
			-- Is the expression relative to an object ?

	on_context: BOOLEAN
			-- Is the expression relative to a context ?	

feature -- Backup

	backup_data: like Current

	backup
		local
			bak: like backup_data
		do
			bak := backup_data
			if bak = Void then
				create bak.make
			end
			bak.copy (Current)
		end

	restore
		local
			bak: like backup_data
		do
			bak := backup_data
			set_data (bak.feature_i, bak.class_c, bak.class_type, bak.local_table, bak.object_test_locals, bak.breakable_index, bak.bp_nested_index)
		end

feature -- Access

	class_type: CLASS_TYPE
			-- Class related to the target, in on_object context

	class_c: CLASS_C
			-- Class related to the expression

	address: DBG_ADDRESS
			-- Object's address related to the expression	

	feature_i: FEATURE_I
			-- Feature associated to the context

	breakable_index: INTEGER
			-- Breakable index position

	bp_nested_index: INTEGER
			-- Breakable nested index position	

	local_table: detachable HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Local variable table

	object_test_locals: detachable LIST [TUPLE [id: ID_AS; li: LOCAL_INFO]]
			-- Object test local info associated to the context

feature -- Element change

	reset_changed
			-- Reset `changed'
		do
			changed := False
		end

	set_address (c: like address)
			-- set value of `address' with `c'
		do
			address := c
		end

	set_class_c (c: like class_c)
			-- set value of `class_c' with `c'
		do
			class_c := c
		end

feature {NONE} -- Implementaion

	Default_context_feature: FEATURE_I
			-- Default context feature for `context_feature'
		once
			Result := System.Any_class.compiled_class.feature_named ("default_create")
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
