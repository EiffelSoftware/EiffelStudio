indexing
	description: "objects representing a element";
	status:			"See notice at end of class.";
	author:			"Andreas Leitner";

class
	XML_ELEMENT
inherit
	XML_NAMED_NODE
			-- `name' means name of the tag
		rename
			make as make_named_node
		redefine
			out
		end
creation
	make, make_root
feature
	make (a_parent: XML_ELEMENT; tag_name: STRING) is
			-- creates a XML_ELEMENT object with
			-- `a_parent' as parent and `tag_name' as
			-- tag name
		require
			valid_tag_name: tag_name /= Void
		do
			make_named_node (a_parent)
			name := clone (tag_name)		
			!! attributes.make
		end

	make_root (tag_name: STRING) is
			-- creates a XML_ELEMENT root object with
			-- `tag_name' as tag name
		require
			valid_tag_name: tag_name /= Void
		do
			make (Void, tag_name)
		end


	attributes: XML_ATTRIBUTE_TABLE
			-- table of attributes the element contains
	
	children_allowed: BOOLEAN is
			-- this type of node allows children
		do
			Result := True
		end
feature
	out: STRING is
		do
			!! Result.make (0)
			Result.append (start_tag)
			Result.append (Precursor)
			Result.append (end_tag)
		end

	start_tag: STRING is
		do
			!! Result.make (0)
			Result.append ("<")
			Result.append (name)



			Result.append (">")
		end
	end_tag: STRING is
		do
			!! Result.make (0)
			Result.append ("</")
			Result.append (name)
			Result.append (">")
		end
feature

	join_text_nodes is
			-- joins sequences of text nodes
		local
			text_node: XML_TEXT
			joint_text_node: XML_TEXT
			cs: DS_BILINKED_LIST_CURSOR [XML_NODE]
		do
			from
				cs := new_cursor
				cs.start
			until
				cs.off
			loop
				text_node ?= cs.item
				if
					text_node /= Void
				then
						-- found a text node
						-- now join all text-nodes that are
						-- more forward until there
						-- is a node that is no text-node
					joint_text_node := clone (text_node)
					remove_at_cursor (cs)
					from
					until
						cs.off or text_node = Void
					loop
						text_node ?= cs.item
						if
							text_node /= Void
						then
								-- found another text-node -> join
							joint_text_node.append_content (text_node)
							remove_at_cursor (cs)
						else
							cs.forth
						end
					end
					force_left_cursor (joint_text_node, cs)
				else				
					cs.forth
				end
			end
		end

	set_attributes (v: XML_ATTRIBUTE_TABLE) is
		require
			v_not_void: v /= Void
		do
			attributes := v
		ensure
			attributes_equals_v: attributes = v
		end


end -- XML_ELEMENT

--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------
