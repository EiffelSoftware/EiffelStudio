<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<%@ page language="Eiffel"%>

<html>
	<head>
		<link rel="stylesheet" href="default.css">
		<title>Data Binding Sample</title>

		<script runat="server">
			indexing
				description: "Shows data binding in Eiffel for ASP.NET"
				precompile_definition_file: "$ISE_CODEDOM\Samples\code_behind\ace.ace"
		</script>

		<script runat="server">
			inherit
				WEB_PAGE
					redefine
						on_load
					end
		</script>

		<script runat="server">
			on_load (e: EVENT_ARGS) is
					-- Initialize values used for data binding.
				local
					l_values: ARRAY_LIST
					l_res: SYSTEM_OBJECT
				do
					if not is_post_back then
						create l_values.make
						l_res := l_values.add (0)
						l_res := l_values.add (1)
						l_res := l_values.add (2)
						l_res := l_values.add (3)
						l_res := l_values.add (4)
						l_res := l_values.add (5)
						l_res := l_values.add (6)
						data_list.set_data_source (l_values)
						data_list.data_bind
					end
				end

			even_or_odd (a_number: SYSTEM_OBJECT): STRING is
					-- "Even" if `a_number' is even, "Odd" otherwise
				local
					l_number: INTEGER
				do
					l_number ?= a_number
					if l_number \\ 2 /= 0 then
						Result := "Odd"
					else
						Result := "Even"
					end
				ensure
					valid_result: Result.is_equal ("Odd") or Result.is_equal ("Even")
				end
		</script>
	</head>
	<body>
		<h3>Databinding to Methods and Expressions</h3>

		<form runat=server>
			<asp:DataList runat="server"
				BorderColor="black" 
				BorderWidth="1" 
				GridLines="Both" 
				CellPadding="3" 
				CellSpacing="0"
				ID="data_list"
			>
				<ItemTemplate>
					Number Value: <%# container.data_item %>
					Even/Odd: <%# (even_or_odd (container.data_item)).to_cil %>
				</ItemTemplate>

			</asp:DataList>
		</form>
	</body>
</html>

<!--
--+--------------------------------------------------------------------
--| Eiffel for ASP.NET 5.6
--| Copyright (c) 2005-2006 Eiffel Software
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
-->
