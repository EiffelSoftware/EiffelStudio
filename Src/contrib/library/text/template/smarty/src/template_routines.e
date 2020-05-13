note
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_ROUTINES

inherit
	INTERNAL

feature

	internal_field_value (obj: ANY; fdn: STRING): detachable CELL [detachable ANY]
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
				Result := cl
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
					create Result.put (field (obj_fields.item (fdn), obj))
				elseif attached {HASH_TABLE [detachable ANY, READABLE_STRING_GENERAL]} obj as htb then
					if htb.has_key (fdn) then
						create Result.put (htb.found_item)
					end
				elseif attached {TABLE [detachable ANY, READABLE_STRING_GENERAL]} obj as tb then
					if tb.valid_key (fdn) then
						create Result.put (tb.item (fdn))
					end
				end
			end
		end

	internal_info_build (obj: ANY): STRING_TABLE [INTEGER]
		require
			obj /= Void
		local
			fi, fc: INTEGER
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
				Result.force (fi, field_name (fi, obj))
				fi := fi + 1
			end
			internal_info.force (Result, otn)
		end

	internal_info: STRING_TABLE [STRING_TABLE [INTEGER]]
		once
			create Result.make (10)
		end

feature -- Inspectors

	register_template_inspector (ti: TEMPLATE_INSPECTOR; ti_name: READABLE_STRING_8)
		require
			ti_name /= Void
		do
			template_inspectors.force (ti, ti_name)
		end

	unregister_template_inspector (ti: TEMPLATE_INSPECTOR)
		local
			l_inspectors: like template_inspectors
		do
			l_inspectors := template_inspectors
			from
				l_inspectors.start
			until
				l_inspectors.off
			loop
				if ti = l_inspectors.item_for_iteration then
						-- FIXME jfiat [2014/12/03] : avoid remove in a loop for table.
					l_inspectors.remove (l_inspectors.key_for_iteration)
				else
					l_inspectors.forth
				end
			end
		end

	template_inspectors: STRING_TABLE [TEMPLATE_INSPECTOR]
		once
			create Result.make (10)
		end

note
	copyright: "2011-2019, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"

end
