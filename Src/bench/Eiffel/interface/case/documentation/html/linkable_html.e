indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINKABLE_HTML

inherit
	ONCES

	CONSTANTS

feature -- functionnalities

	generate_parent_cluster ( cl : LINKABLE_DATA ; s: LINKED_LIST [ STRING ] ; is_chart :BOOLEAN) is
	local
		str,s0 : STRING
		fi : FILE_NAME
	do
		!! s0.make(20)
		!! str.make ( 20 )
		--fi.extend(Environment.html_directory)
		s0.append("../")
		if cl.parent_cluster /= Void then
			str.append("<A HREF=%"")
			s0.append(cl.parent_cluster.name)
			s0.append("/")
			s0.append(cl.parent_cluster.name)
			str.append(s0)
			if not is_chart then
				str.append("_cas.html%">")
			else
				str.append("_chart_cas.html%">")
			end
			s.extend(str)
			s.extend(cl.parent_cluster.name)
			s.extend("</A>")
		else
			s.extend("No Parent Cluster")
			s.extend("%N")
		end
	end

		generate_relational( cl : LINKABLE_DATA ; s: LINKED_LIST [ STRING ]; is_chart : BOOLEAN ; with_name: BOOLEAN) is
	local
		str : STRING
	do
		!! str.make(20)
		str.append("<A HREF=%"")
		str.append(cl.name)
		if is_chart then
			str.append("_cas")
		else
			str.append("_chart_cas")
		end
		str.append(".html%">")
		s.extend(str)
		if with_name then
			s.extend(cl.name)
			s.extend("</A>")
		end
	end

	generate_class_spc ( cl : LINKABLE_DATA ; s: LINKED_LIST [ STRING ] ; is_chart :BOOLEAN) is
	local
		str,s0 : STRING
		fi : FILE_NAME
	do
		!! s0.make(20)
		!! str.make ( 20 )
		s0.append("../") 
		if cl.parent_cluster /= Void then
			str.append("<A HREF=%"")
			s0.append(cl.parent_cluster.name)
			s0.append("/")
			s0.append(cl.name)
			str.append(s0)
			if not is_chart then
				str.append("_cas.html%">")
			else
				str.append("_chart_cas.html%">")
			end
			s.extend(str)
			s.extend(cl.name)
			s.extend("</A>")
		else
			s.extend("None")
			s.extend("%N")
		end
	end

feature -- Facilities

	relative_root: STRING is
		-- return the relative root 
		do
			!! Result.make(4)
			Result.append("..")
			Result.append_character(Environment.directory_separator)
		end

end -- class LINKABLE_HTML
