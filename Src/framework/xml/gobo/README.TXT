This library was inspired by GoboEiffel's xml library (http://www.gobosoft.com/)

This `gobo' library is mainly used to ease the replacement of the Gobo's XML library
with the current .. xml library.

One can use this code in .ecf to include and replace gobo XM_ classes with XML_ classes from those libraries ...
if equivalent interface exists.


		<library name="xml_tree" location="$ISE_LIBRARY\framework\xml\tree\xml_tree.ecf">
			<renaming old_name="XML_ATTRIBUTE" new_name="XM_ATTRIBUTE"/>
			<renaming old_name="XML_CHARACTER_DATA" new_name="XM_CHARACTER_DATA"/>
			<renaming old_name="XML_COMMENT" new_name="XM_COMMENT"/>
			<renaming old_name="XML_COMPOSITE" new_name="XM_COMPOSITE"/>
			<renaming old_name="XML_DOCUMENT" new_name="XM_DOCUMENT"/>
			<renaming old_name="XML_ELEMENT" new_name="XM_ELEMENT"/>
			<renaming old_name="XML_NAMESPACE" new_name="XM_NAMESPACE"/>
			<renaming old_name="XML_CALLBACKS_TREE" new_name="XM_CALLBACKS_TREE"/>
			<renaming old_name="XML_DOCUMENT_NODE" new_name="XM_DOCUMENT_NODE"/>
			<renaming old_name="XML_ELEMENT_NODE" new_name="XM_ELEMENT_NODE"/>
			<renaming old_name="XML_NAMED_NODE" new_name="XM_NAMED_NODE"/>
			<renaming old_name="XML_NODE" new_name="XM_NODE"/>
			<renaming old_name="XML_TREE_TO_EVENTS" new_name="XM_TREE_TO_EVENTS"/>
			<renaming old_name="XML_NODE_VISITOR_NULL" new_name="XM_NODE_PROCESSOR"/>
			<renaming old_name="XML_NODE_VISITOR_NULL" new_name="XM_NODE_VISITOR_NULL"/>
			<renaming old_name="XML_NODE_VISITOR_PRINT" new_name="XM_NODE_VISITOR_PRINT"/>
			<renaming old_name="XML_PROCESSING_INSTRUCTION" new_name="XM_PROCESSING_INSTRUCTION"/>
		</library>
		<library name="xml_parser" location="$ISE_LIBRARY\framework\xml\parser\xml_parser.ecf">
			<renaming old_name="XML_PARSER_FACTORY" new_name="XM_PARSER_FACTORY"/>
			<renaming old_name="XML_CALLBACKS" new_name="XM_CALLBACKS"/>
			<renaming old_name="XML_CALLBACKS_FILTER" new_name="XM_CALLBACKS_FILTER"/>
			<renaming old_name="XML_CALLBACKS_NULL" new_name="XM_CALLBACKS_NULL"/>
			<renaming old_name="XML_CALLBACKS_SOURCE" new_name="XM_CALLBACKS_SOURCE"/>
			<renaming old_name="XML_FORWARD_CALLBACKS" new_name="XM_FORWARD_CALLBACKS"/>
			<renaming old_name="XML_NAMESPACE_RESOLVER" new_name="XM_NAMESPACE_RESOLVER"/>
			<renaming old_name="XML_NAMESPACE_RESOLVER_CONTEXT" new_name="XM_NAMESPACE_RESOLVER_CONTEXT"/>
		</library>
		<library name="xml_gobo" location="$ISE_LIBRARY\framework\xml\gobo\xml_gobo.ecf" readonly="false">
			<renaming old_name="XML_CALLBACKS_FILTER_FACTORY" new_name="XM_CALLBACKS_FILTER_FACTORY"/>
			<renaming old_name="XML_TREE_CALLBACKS_PIPE" new_name="XM_TREE_CALLBACKS_PIPE"/>
			<renaming old_name="XML_CONTENT_CONCATENATOR" new_name="XM_CONTENT_CONCATENATOR"/>
			<renaming old_name="XML_CALLBACKS_TO_TREE_FILTER" new_name="XM_CALLBACKS_TO_TREE_FILTER"/>
			<renaming old_name="XML_STOP_ON_ERROR_FILTER" new_name="XM_STOP_ON_ERROR_FILTER"/>
			<renaming old_name="XML_POSITION_TABLE" new_name="XM_POSITION_TABLE"/>
			<renaming old_name="XML_MARKUP_CONSTANTS" new_name="XM_MARKUP_CONSTANTS"/>
		</library>

Actually you might not have to rename all those classes ...
that depends how you use the Gobo's xml library.