indexing
	description: "Class which deals with the comments for html doc"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMENTS_HTML

feature

generate_indexing ( cl : LINKABLE_DATA ; s: LINKED_LIST [ STRING ] ) is
	local
		list : ELEMENT_LIST [ INDEX_DATA ]
		fi : FILE_NAME
		str : STRING
		st : STRING
		i : INTEGER
	do
			if cl.chart /= Void and then
				cl.chart.indexes/= Void and then 
				cl.chart.indexes.count>0 then
					list := cl.chart.indexes
					from
						list.start
					until
						list.after
					loop
						s.extend(list.item.clickable_string)
						s.extend("<BR>")
						list.forth
					end
			else
				s.extend("??")
			end
	end

	generate_description ( desc : DESCRIPTION_DATA; s : 
		LINKED_LIST[STRING] ) is
	local
		st : STRING
	do
		if desc /= Void then
		from
			desc.start
		until
			desc.after
		loop
			st := deep_clone(desc.item)
			if st.is_equal("<<description>>") then
				st:= clone ("??")
			else
				st.replace_substring_all("%R","<BR>")
			end
			s.extend(st)
			desc.forth
		end
		end
	end


end -- class COMMENTS_HTML
