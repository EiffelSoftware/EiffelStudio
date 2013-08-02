<html>
<head>
<title>Info</title>
</head>
<body>

<pre>
HTML simple table


<table>
{foreach from="$names" item="item"}
   <tr>
      <td>{$item/}</td>
   </tr>
{/foreach}
</table>
</body>
</html>