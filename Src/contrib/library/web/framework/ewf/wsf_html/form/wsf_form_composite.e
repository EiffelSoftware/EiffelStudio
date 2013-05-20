note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	WSF_FORM_COMPOSITE

inherit
	WSF_WIDGET_COMPOSITE
		redefine
			extend
		end

feature -- Status

	has_field (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := container_has_field (Current, a_name)
		end

feature -- Access

	fields_by_name (a_name: READABLE_STRING_GENERAL): detachable LIST [WSF_FORM_FIELD]
		do
			Result := fields_by_name_from (Current, a_name)
		end

feature -- Change

	extend (i: WSF_WIDGET)
		local
			n: READABLE_STRING_8
		do
			if attached {WSF_FORM_FIELD} i as l_field then
				n := l_field.name
				if n.is_empty then
					n := (items.count + 1).out
					l_field.update_name (n)
				end
			end
			Precursor (i)
		end

feature {NONE} -- Implementation: Items			

	container_has_field (a_container: ITERABLE [WSF_WIDGET]; a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			across
				a_container as i
			until
				Result
			loop
				if attached {WSF_FORM_FIELD} i.item as l_field and then l_field.name.same_string_general (a_name) then
					Result := True
				elseif attached {ITERABLE [WSF_WIDGET]} i.item as l_cont then
					Result := container_has_field (l_cont, a_name)
				end
			end
		end

	fields_by_name_from (a_container: ITERABLE [WSF_WIDGET]; a_name: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [WSF_FORM_FIELD]
		local
			res: detachable ARRAYED_LIST [WSF_FORM_FIELD]
		do
			across
				a_container as i
			loop
				if attached {WSF_FORM_FIELD} i.item as l_field and then l_field.name.same_string_general (a_name) then
					if res = Void then
						create res.make (1)
					end
					res.force (l_field)
				elseif attached {ITERABLE [WSF_WIDGET]} i.item as l_cont then
					if attached fields_by_name_from (l_cont, a_name) as lst then
						if res = Void then
							res := lst
						else
							res.append (lst)
						end
					end
				end
			end
			Result := res
		end


end
