note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_ROUTINES

inherit
	INTERNAL

feature

	internal_field_value (obj: ANY; fdn: STRING): detachable ANY
		require
			obj_not_void: obj /= Void
			field_name_not_void: fdn /= Void
		local
			otn: STRING
			obj_fields: detachable STRING_TABLE [INTEGER]
		do
			otn := type_name (obj)
			if
				template_inspectors.has (otn) and then
				attached Template_inspectors.item (otn) as tpl_inspector and then
				attached tpl_inspector.internal_data (fdn, obj) as cl -- If Void, this is not handled by tpl_inspector
			then
				Result := cl.item
			else
				if internal_info.has (otn) then
					obj_fields := internal_info.item (otn)
				else
					obj_fields := internal_info_build (obj)
				end
				if
					obj_fields /= Void and then
					obj_fields.has (fdn)
				then
					Result := field (obj_fields.item (fdn), obj)
				end
			end
		end

	internal_info_build (obj: ANY): STRING_TABLE [INTEGER]
		require
			obj /= Void
		local
			fi, fc: INTEGER
			fn: STRING
			otn: STRING
		do
			otn := type_name (obj)
			from
				fi := 1
				fc := field_count (obj)
				create Result.make (fc)
			until
				fi > fc
			loop
				fn := field_name (fi, obj)
				Result.force (fi, fn)
				fi := fi + 1
			end
			internal_info.force (Result, otn)
		end

	internal_info: STRING_TABLE [STRING_TABLE [INTEGER]]
		once
			create Result.make (10)
		end

feature -- Inspectors

	register_template_inspector (ti: TEMPLATE_INSPECTOR; ti_name: STRING)
		require
			ti_name /= Void
		do
			template_inspectors.force (ti, ti_name)
		end

	template_inspectors: STRING_TABLE [TEMPLATE_INSPECTOR]
		once
			create Result.make (10)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end -- class TEMPLATE_ROUTINES
